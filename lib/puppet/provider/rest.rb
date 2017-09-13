require 'json'
require 'net/http'
require 'openssl'

# Parent class encapsulating general-use functions for children REST-based
# providers.
class Puppet::Provider::REST < Puppet::Provider
  class << self
  end

  # Perform a REST API request against the indicated endpoint.
  #
  # @return Net::HTTPResponse
  def rest host, \
                port, \
                resource, \
                verb, \
                ssl = true, \
                body = nil, \
                timeout = 10, \
                username = nil, \
                password = nil

    protocol = 'https'
    if ssl
      protocol = 'http'
    end
    uri = URI("#{protocol}://#{host}:#{port}/#{resource}")
    http = Net::HTTP.new uri.host, uri.port

    req = nil
    case verb
    when 'GET'
      req = Net::HTTP::Get.new uri.request_uri
    when 'PUT'
      req = Net::HTTP::Put.new uri.request_uri
      req.set_form_data(body)
    when 'POST'
      req = Net::HTTP::Post.new uri.request_uri
    when 'DELETE'
      req = Net::HTTP::Delete.new uri.request_uri
    when 'HEAD'
      req = Net::HTTP::Head.new uri.request_uri
    end

    if username and password
      req.basic_auth username, password
    elsif username or password
      Puppet.warning(
        'username and password must both be defined, skipping basic auth'
      )
    end

    req['Accept'] = 'application/json'

    http.read_timeout = timeout
    http.open_timeout = timeout
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless ssl

    begin
      response = http.request req
    rescue Net::HTTPError => e
      raise Puppet::Error,
        "Received '#{e}' from the REST Endpoint."
    end
    return response
  end
end # of class

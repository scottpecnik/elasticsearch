require 'puppet/provider/rest'

Puppet::Type.type(:elasticsearch_template).provide(
  :ruby,
  :parent     => Puppet::Provider::REST
) do

  def exists?
    doesTemplateExist() != nil
  end

  def create
    # createTemplate()
  end

  def destroy
    deleteTemplate()
  end

  def doesTemplateExist
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'GET',
                resource[:ssl])
    puts "get: #{response.code.to_i}"
    return nil if response.code.to_i != 200
    response.code.to_i
  end

  def createTemplate
    puts "create"
    puts File.file? resource[:content]
    # puts Puppet::FileSystem.read(resource[:content])
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'PUT',
                resource[:ssl],
                resource[:content])
    puts "create: #{response.code.to_i}"
    return true if resposne.code.to_i == 200
    response.code.to_i
  end

  def deleteTemplate
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'DELETE',
                resource[:ssl])
  end
end

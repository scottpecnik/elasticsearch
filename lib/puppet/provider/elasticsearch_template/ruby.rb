require 'puppet/provider/rest'

Puppet::Type.type(:elasticsearch_template).provide(
  :ruby,
  :parent => Puppet::Provider::REST
) do

  def exists?
    doesTemplateExist() != nil
  end

  def create
    createTemplate()
  end

  def destroy
    deleteTemplate()
  end

  def doesTemplateExist
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'GET',
                resource[:ssl])
    return nil if response.code.to_i != 200
    response.code.to_i
  end

  def createTemplate
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'PUT',
                resource[:ssl],
                Puppet::FileSystem.read(resource[:content]))
  end

  def deleteTemplate
    response = rest(resource[:servername], resource[:port],
                "_template/#{resource[:name]}",
                'DELETE',
                resource[:ssl])
  end
end

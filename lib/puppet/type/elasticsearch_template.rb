Puppet::Type.newtype(:elasticsearch_template) do
  desc "Puppet type that models creating elastic search templates"

  ensurable

  newparam(:name, :namevar => true) do
    desc "Name of template - > name from URI after '_template'"
  end

  newparam(:servername) do
    desc "DNS resolvable name of server or container"
  end

  newparam(:port) do
    desc "Port that elasticsearch is running on"
  end

  newparam(:ssl) do
    desc "Is SSL enabled"
    defaultto :false
    newvalues(:true, :false)
  end

  newparam(:content) do
    desc "Contents of template in JSON format"
  end
end

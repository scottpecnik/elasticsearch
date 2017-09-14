# The baseline for module testing used by Puppet Inc. is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#
# include ::elasticsearch

file { 'C:/temp/template_1.json':
  ensure  => present,
  content => 'puppet:///modules/elasticsearch/template_1.json',
}

elasticsearch_template { 'template_1':
  ensure     => present,
  servername => 'localhost',
  port       => '9201',
  ssl        => false,
  content    => 'C:/temp/template_1.json',
  require    => File['C:/temp/template_1.json']
}

# Class: puppet_infra::profile::broker
#
#
class puppet_infra::profile::broker inherits puppet_infra::profile::global {
  include puppet_enterprise::profile::amq::broker
  file { '/etc/security/limits.d/10-pe-activemq.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/pe-activemq-limits.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['pe-activemq'],
  }
}

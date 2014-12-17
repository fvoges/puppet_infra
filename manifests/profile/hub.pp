# Class: puppet_infra::profile::hub
#
#
class puppet_infra::profile::hub inherits puppet_infra::profile::global {
  include ::puppet_enterprise::profile::amq::hub
  include ::puppet_infra::amq::logrotate

  file { '/etc/security/limits.d/10-pe-activemq.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/pe-activemq-limits.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['pe-activemq'],
  }
}

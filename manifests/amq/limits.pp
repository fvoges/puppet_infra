# Class: puppet_infra::amq::limits
#
#
class puppet_infra::amq::limits {
  file { '/etc/security/limits.d/10-pe-activemq.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/pe-activemq-limits.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['pe-activemq'],
  }
}

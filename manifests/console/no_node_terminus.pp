class puppet_infra::console::no_node_terminus {
  $confdir = '/etc/puppetlabs/puppet'

  Pe_ini_setting {
    ensure  => present,
    section => 'main'
  }

  pe_ini_setting { 'no_node_terminus' :
    ensure  => absent,
    path    => "${confdir}/puppet.conf",
    section => 'master',
    setting => 'node_terminus',
  }

}
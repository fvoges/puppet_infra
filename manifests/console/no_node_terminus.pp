class puppet_infra::console::no_node_terminus {

  Pe_ini_setting {
    ensure  => present,
    section => 'main'
  }

  pe_ini_setting { 'no_node_terminus' :
    ensure  => absent,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'master',
    setting => 'node_terminus',
  }

}
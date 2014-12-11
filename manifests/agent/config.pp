# Class: puppet_infra::agent::config
#
#
class puppet_infra::agent::config {
  Pe_ini_setting {
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'agent'
  }

  pe_ini_setting { 'agent ca_server' :
    setting => 'ca_server',
    value   => $::puppet_infra::agent::agent_ca,
  }

  pe_ini_setting { 'agent server' :
    setting => 'server',
    value   => $::puppet_infra::agent::agent_server,
  }

  pe_ini_setting { 'agent runinterval' :
    setting => 'runinterval',
    value   => $::puppet_infra::agent::agent_run_interval,
  }
}

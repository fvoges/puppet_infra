# Class: puppet_infra::agent::config
#
#
class puppet_infra::agent::config {
  Pe_ini_setting {
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'agent'
  }

  pe_ini_setting { 'ca_server' :
    setting => $::puppet_infra::agent::agent_ca,
  }

  pe_ini_setting { 'server' :
    setting => $::puppet_infra::agent::agent_server,
  }

  pe_ini_setting { 'runinterval' :
    setting => $::puppet_infra::agent::agent_run_interval,
  }
}

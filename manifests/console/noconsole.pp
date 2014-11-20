class puppet_infra::console::noconsole {

  Pe_ini_setting {
    ensure  => present,
    section => 'main'
  }

  pe_ini_subsetting { 'no_reports_console' :
    ensure               => absent,
    path                 => "${::settings::confdir}/puppet.conf",
    section              => 'master',
    setting              => 'reports',
    subsetting           => 'console',
    subsetting_separator => ',',
  }

}

# Class: puppet_infra::profile::console
#
#
class puppet_infra::profile::console inherits puppet_infra::profile::global {
  $prune_upto                = hiera('puppet_infra::profile::console::prune_upto')
  $password_reset_expiration = hiera('puppet_infra::profile::console::password_reset_expiration')
  $session_timeout           = hiera('puppet_infra::profile::console::session_timeout')
  $failed_attempts_lockout   = hiera('puppet_infra::profile::console::failed_attempts_lockout')
  $timezone                  = hiera('puppet_infra::profile::console::timezone')
  $unresponsive_threshold    = hiera('puppet_infra::profile::console::unresponsive_threshold')
  $disable_live_management   = str2bool(hiera('puppet_infra::profile::console::disable_live_management'))

  validate_re($password_reset_expiration, '^\d+$')
  validate_re($session_timeout, '^\d+$')
  validate_re($failed_attempts_lockout, '^\d+$')
  validate_bool($disable_live_management)

  include ::puppet_enterprise::license
  #include ::puppet_infra::console::logrotate

  # PE 3.7.0 doesn't expose delayed_job_workers
  if $::pe_version == '3.7.0' {
    include ::puppet_enterprise::profile::console
  } else {
    # Anything with less than 3 CPU cores will use just 1 worker
    # everything else will use CPUs/2
    if $processorcount > 3 {
      $workers = $processorcount / 2
    } else {
      $workers = 1
    }
    class { 'puppet_enterprise::profile::console':
      delayed_job_workers => $workers,
    }
  }

  include ::puppet_enterprise::profile::mcollective::console

  class { 'pe_console_prune':
    prune_upto => $prune_upto,
  }

  file { "/etc/puppetlabs/console-services/conf.d/custom-settings.conf":
    ensure  => file,
    content => template("${module_name}/console-settings.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify => Service['pe-console-services'],
  }

  class { 'puppet_infra::console':
    timezone                => $timezone,
    unresponsive_threshold  => $unresponsive_threshold,
    disable_live_management => $disable_live_management,
    require => Class['puppet_enterprise::profile::console'],
  }

  file { '/etc/security/limits.d/10-pe-console-services.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/pe-console-services-limits.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['pe-console-services'],
  }

}

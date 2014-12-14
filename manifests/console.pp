# Class: puppet_infra::console
#
#
class puppet_infra::console (
  $timzone                 = $puppet_infra::params::console_timezone,
  $unresponsive_threshold  = $puppet_infra::params::console_unresponsive_threshold,
  $disable_live_management = $puppet_infra::params::console_disable_live_management,
) inherits puppet_infra::params {
  validate_string($timezone)
  validate_re($unresponsive_threshold, '^\d+$')
  validate_bool($disable_live_management)

  File_line {
    path => '/etc/puppetlabs/puppet-dashboard/settings.yml',
  }

  file_line { 'dashboard timezone':
    line  => "time_zone: '${timezone}'",
    match => '^time_zone.*:',
  }

  file_line { 'dashboard unresponsive threshold':
    line  => "no_longer_reporting_cutoff: ${unresponsive_threshold}",
    match => '^no_longer_reporting_cutoff.*:',
  }

  file_line { 'dashboard disable live management':
    line  => "disable_live_management: ${disable_live_management}",
    match => '^disable_live_management.*:',
  }

}
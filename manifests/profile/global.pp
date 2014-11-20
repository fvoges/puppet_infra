# Class: puppet_infra::profile::global
#
#
class puppet_infra::profile::global {

  $mcollective_middleware_hosts = hiera('puppet_infra::profile::global::mcollective_middleware_hosts')
  $database_host                = hiera('puppet_infra::profile::global::database_host')
  $puppetdb_host                = hiera('puppet_infra::profile::global::puppetdb_host')
  $puppet_master_host           = hiera('puppet_infra::profile::global::puppet_master_host')
  $certificate_authority_host   = hiera('puppet_infra::profile::global::certificate_authority_host')
  $disable_console              = str2bool(hiera('puppet_infra::profile::global::disable_console'))
  $console_host                 = hiera('puppet_infra::profile::global::console_host', '')

  validate_bool($disable_console)
  if ! $disable_console and ! $console_host {
    fail('puppet_infra::profile::global::console_host is not defined in Hiera or it\'s empty.')
  }

  if $disable_console {
    $real_console_host = ''
  } else {
    $real_console_host = $console_host
  }

  class {'puppet_enterprise':
    mcollective_middleware_hosts => $mcollective_middleware_hosts,
    database_host                => $database_host,
    puppetdb_host                => $puppetdb_host,
    database_port                => '5432',
    database_ssl                 => true,
    puppet_master_host           => $puppet_master_host,
    certificate_authority_host   => $certificate_authority_host,
    console_port                 => '443',
    puppetdb_database_name       => 'pe-puppetdb',
    puppetdb_database_user       => 'pe-puppetdb',
    puppetdb_port                => '8081',
    console_host                 => $real_console_host,
  }
}

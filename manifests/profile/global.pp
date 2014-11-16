# Class: puppet_infra::profile::global
#
#
class puppet_infra::profile::global {

   $mcollective_middleware_hosts  = hiera('puppet_infra::profile::global::mcollective_middleware_hosts')
   $database_host                 = hiera('puppet_infra::profile::global::database_host')
   $puppetdb_host                 = hiera('puppet_infra::profile::global::puppetdb_host')
   $puppet_master_host            = hiera('puppet_infra::profile::global::puppet_master_host')
   $certificate_authority_host    = hiera('puppet_infra::profile::global::certificate_authority_host')
   $console_host                  = hiera('puppet_infra::profile::global::console_host') 

   validate_array($mcollective_middleware_hosts)
   validate_string($database_host)
   validate_string($puppetdb_host)
   validate_string($puppet_master_host)
   validate_string($certificate_authority_host)
   validate_string($console_host)

  class {'puppet_enterprise':
    mcollective_middleware_hosts  => $mcollective_middleware_hosts,
    database_host                 => $database_host,
    puppetdb_host                 => $puppetdb_host,
    database_port                 => '5432',
    database_ssl                  => true,
    puppet_master_host            => $puppet_master_host,
    certificate_authority_host    => $certificate_authority_host,
    console_port                  => '443',
    puppetdb_database_name        => 'pe-puppetdb',
    puppetdb_database_user        => 'pe-puppetdb',
    puppetdb_port                 => '8081',
    console_host                  =>  $console_host,
  }
}

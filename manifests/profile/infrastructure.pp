# Class: puppet_infra::profile::infrastructure
#
#
class puppet_infra::profile::infrastructure {
  class {'puppet_enterprise':
    mcollective_middleware_hosts  => ['pupca01v.enp.aramco.com.sa'],
    database_host                 => 'pupd01.enp.aramco.com.sa',
    puppetdb_host                 => 'pupd01.enp.aramco.com.sa',
    database_port                 => '5432',
    database_ssl                  => true,
    puppet_master_host            => 'pupca01v.enp.aramco.com.sa',
    certificate_authority_host    => 'pupca01v.enp.aramco.com.sa',
    console_port                  => '443',
    puppetdb_database_name        => 'pe-puppetdb',
    puppetdb_database_user        => 'pe-puppetdb',
    puppetdb_port                 => '8081',
    console_host                  => undef,
  }
}
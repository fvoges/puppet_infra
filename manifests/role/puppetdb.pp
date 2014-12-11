class puppet_infra::role::puppetdb {
  include puppet_infra::profile::puppetdb
  include profiles::monitoring::ganglia::gmond

}

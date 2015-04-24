# Class: puppet_infra::profile::puppetdb
#

class puppet_infra::profile::puppetdb {
  include ::puppet_infra::profile::global
  include ::puppet_enterprise::profile::puppetdb
  #include ::puppet_infra::puppetdb::logrotate

}

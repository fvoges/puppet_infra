# Class: puppet_infra::profile::puppetdb
#

class puppet_infra::profile::puppetdb inherits puppet_infra::profile::infrastructure {
  include puppet_enterprise::profile::puppetdb
}

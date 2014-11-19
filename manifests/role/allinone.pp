# Class: puppet_infra::role::allinone
#
#
class puppet_infra::role::allinone {
  include puppet_infra::profile::master
  include puppet_infra::profile::ca
  include puppet_enterprise::profile::amq::broker
  include puppet_infra::profile::puppetdb
  include puppet_infra::profile::console
  include puppet_infra::profile::mcollective
}

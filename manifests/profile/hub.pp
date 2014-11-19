# Class: puppet_infra::profile::hub
#
#
class puppet_infra::profile::hub inherits puppet_infra::profile::global {
  include puppet_enterprise::profile::amq::hub
}

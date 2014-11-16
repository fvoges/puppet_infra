# Class: puppet_infra::profile::broker
#
#
class puppet_infra::profile::broker inherits puppet_infra::profile::infrastructure {
  include puppet_enterprise::profile::amq::broker
}

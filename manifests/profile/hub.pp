# Class: puppet_infra::profile::hub
#
#
class puppet_infra::profile::hub {
  include ::puppet_infra::profile::global
  include ::puppet_enterprise::profile::amq::hub
  #include ::puppet_infra::amq::logrotate
  include ::puppet_infra::amq::limits
}

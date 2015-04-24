# Class: puppet_infra::profile::broker
#
#
class puppet_infra::profile::broker  {
  include ::puppet_infra::profile::global
  include ::puppet_enterprise::profile::amq::broker
  #include ::puppet_infra::amq::logrotate
  include ::puppet_infra::amq::limits
}

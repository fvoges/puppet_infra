# class puppet_infra::role::master
class puppet_infra::role::master {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::broker
  include ::puppet_infra::profile::mcollective
  include ::profiles::monitoring::ganglia::gmond
  include ::profiles::monitoring::ganglia::report

}

class puppet_infra::role::console {
  include puppet_infra::profile::console
  include puppet_infra::profile::mcollective
  include profiles::monitoring::ganglia::gmond

}

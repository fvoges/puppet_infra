class puppet_infra::role::console {
  include puppet_infra::profile::console
  include puppet_infra::profile::mcollective
}
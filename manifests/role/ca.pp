# class puppet_infra::role::ca
class puppet_infra::role::ca {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::ca
  include ::puppet_infra::profile::hub
  include ::puppet_infra::profile::mcollective
}

class puppet_infra::role::ca {
  include puppet_infra::profile::master
  include puppet_infra::profile::ca
  include puppet_infra::profile::mcollective
  include puppet_infra::profile::noconsole
  include puppet_infra::profile::no_node_terminus
}
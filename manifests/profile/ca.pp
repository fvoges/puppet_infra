# Class: puppet_infra::profile::ca
#
class puppet_infra::profile::ca {
  include ::puppet_infra::profile::global
  include ::puppet_enterprise::profile::certificate_authority
}

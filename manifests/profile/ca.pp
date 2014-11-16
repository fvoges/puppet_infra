# Class: puppet_infra::profile::ca
#
class puppet_infra::profile::ca inherits puppet_infra::profile::infrastructure {
  include puppet_enterprise::profile::certificate_authority
}

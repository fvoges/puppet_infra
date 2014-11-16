# Class: puppet_infra::profile::console
#
#
class puppet_infra::profile::console inherits puppet_infra::profile::infrastructure {
  include puppet_enterprise::license
  include puppet_enterprise::profile::console
  include puppet_enterprise::profile::mcollective::console

  class { 'pe_console_prune':
    prune_upto => '30',
  }
}

# Class: puppet_infra::profile::console
#
#
class puppet_infra::profile::console inherits puppet_infra::profile::global {
  $prune_upto = hiera('puppet_infra::profile::console::prune_upto')

  include puppet_enterprise::license
  include puppet_enterprise::profile::console
  include puppet_enterprise::profile::mcollective::console

  class { 'pe_console_prune':
    prune_upto => $prune_upto,
  }
}

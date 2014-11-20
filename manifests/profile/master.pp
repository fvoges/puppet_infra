# Class: puppet_infra::profile::master
#
class puppet_infra::profile::master inherits puppet_infra::profile::global {
  $hiera_hierarchy   = hiera('puppet_infra::profile::master::hiera_hierarchy')
  $hiera_base        = hiera('puppet_infra::profile::master::hiera_base')
  $pe_repo_base_path = hiera('puppet_infra::profile::master::pe_repo_base_path')

  validate_array($hiera_hierarchy)
  validate_string($hiera_base)
  validate_string($pe_repo_base_path)

  class { 'pe_repo':
    base_path => $pe_repo_base_path,
  }

  include ::pe_repo::platform::el_5_x86_64
  include ::pe_repo::platform::el_6_x86_64
  include ::pe_repo::platform::el_7_x86_64
  include ::puppet_enterprise::profile::mcollective::peadmin
  include ::puppet_enterprise::profile::master::mcollective

  if $::puppet_infra::profile::global::disable_console {
    class { '::puppet_enterprise::profile::master':
      console_host    => '',
      classifier_host => '',
    }
    include ::puppet_infra::master::no_console_rep_processor
    include ::puppet_infra::master::no_node_terminus
  } else {
    include ::puppet_enterprise::profile::master
  }

  class {'::puppet_infra::master::hiera':
    hiera_hierarchy => $hiera_hierarchy,
    hiera_base      => $hiera_base,
  }

}

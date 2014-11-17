# Class: puppet_infra::profile::master
#
class puppet_infra::profile::master inherits puppet_infra::profile::global {
  
  $pe_repo_base_path = hiera('puppet_infra::profile::master::pe_repo_base_path')
  $hiera_hierarchy  = hiera('puppet_infra::profile::master::hiera_hierarchy')
  $hiera_base_path = hiera('puppet_infra::profile::master::hiera_base')

  validate_string($pe_repo_base_path)
  validate_array($hiera_hierarchy)
  validate_absolute_path($hiera_base_path)

  class { 'pe_repo':
    base_path => $pe_repo_base_path,
  }

  include pe_repo::platform::el_5_x86_64
  include pe_repo::platform::el_6_x86_64
  include pe_repo::platform::el_7_x86_64
  include puppet_enterprise::profile::mcollective::peadmin
  include puppet_enterprise::profile::master::mcollective

  class { 'puppet_enterprise::profile::master':
    #console_host    => undef,
    #classifier_host => undef,
  }

  class {'puppet_infra::master::hiera':
   hiera_hierarchy => $hiera_hierarchy,
 
  }
}

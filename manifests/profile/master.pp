# Class: puppet_infra::profile::master
#
class puppet_infra::profile::master inherits puppet_infra::profile::global {
  $pe_repo_base_path = hiera('puppet_infra::profile::master::pe_repo_base_path')
  $manage_r10k       = str2bool(hiera('puppet_infra::profile::master::manage_r10k'))
  $basemodulepath    = hiera('puppet_infra::profile::master::basemodulepath')
  $environmentpath   = hiera('puppet_infra::profile::master::environmentpath')

  validate_string($pe_repo_base_path)
  validate_bool($manage_r10k)
  validate_string($basemodulepath)
  validate_string($environmentpath)

  Pe_ini_setting {
    ensure => present,
    path   => "${::settings::confdir}/puppet.conf",
  }

  pe_ini_setting { 'Configure environmentpath':
    section => 'main',
    setting => 'environmentpath',
    value   => $environmentpath,
  }

  pe_ini_setting { 'Configure basemodulepath':
    section => 'main',
    setting => 'basemodulepath',
    value   => $basemodulepath,
  }

  class { 'pe_repo':
    base_path => $pe_repo_base_path,
  }

#  include ::pe_repo::platform::el_5_x86_64
#  include ::pe_repo::platform::el_6_x86_64
  include ::pe_repo::platform::el_7_x86_64
  include ::puppet_enterprise::profile::mcollective::peadmin
  include ::puppet_enterprise::profile::master::mcollective
  include ::puppet_infra::gemrc
#include ::puppet_infra::master::logrotate


  if $::puppet_infra::profile::global::disable_console {
    $console_host = ''
    include ::puppet_infra::master::no_console_rep_processor
  } else {
    $console_host = $::puppet_infra::profile::global::console_host
  }

  if $::puppet_infra::profile::global::disable_classifier {
    $classifier_host = ''
    include ::puppet_infra::master::no_node_terminus
  } else {
    $classifier_host = $::puppet_infra::profile::global::classifier_host

  }
  class { '::puppet_enterprise::profile::master':
    console_host    => $console_host,
    classifier_host => $classifier_host,
    enable_ca_proxy => true,
  }

  if $manage_r10k {
    include ::puppet_infra::profile::master::r10k
  }

  file { '/etc/security/limits.d/10-pe-puppet.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/pe-puppet-limits.conf",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['pe-puppetserver'],
  }

}

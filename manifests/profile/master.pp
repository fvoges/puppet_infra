# Class: puppet_infra::profile::master
#
class puppet_infra::profile::master {
  $pe_repo_base_path  = hiera('puppet_infra::profile::master::pe_repo_base_path')
  $pe_repo_platforms  = hiera('puppet_infra::profile::master::pe_repo_platforms')
  $manage_r10k        = str2bool(hiera('puppet_infra::profile::master::manage_r10k'))
  $basemodulepath     = hiera('puppet_infra::profile::master::basemodulepath')
  $environmentpath    = hiera('puppet_infra::profile::master::environmentpath')
  $hiera_conf_symlink = str2bool(hiera('puppet_infra::profile::master::hiera_conf_symlink'))

  validate_string($pe_repo_base_path)
  validate_array($pe_repo_platforms)
  validate_bool($manage_r10k)
  validate_string($basemodulepath)
  validate_string($environmentpath)
  validate_bool($hiera_conf_symlink)

  $pe_repos = regsubst($pe_repo_platforms, '^(.*)$', '::pe_repo::platform::\1')

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

  if $hiera_conf_symlink {
    file { "${::settings::confdir}/hiera.yaml":
      ensure => link,
      target => "${environmentpath}/production/hiera.yaml",
      notify => Service['pe-puppetserver'],
    }
  }

  class { 'pe_repo':
    base_path => $pe_repo_base_path,
  }

  include ::puppet_infra::profile::global

  include $pe_repos

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

# Class: puppet_infra::profile::master::r10k
#
#
class puppet_infra::profile::master::r10k {
  $remote          = hiera('puppet_infra::profile::master::r10k::remote')
  $version         = hiera('puppet_infra::profile::master::r10k::version')
  $install_options = hiera('puppet_infra::profile::master::r10k::install_options', ['--no-ri', '--no-rdoc'])
  $basemodulepath  = hiera('puppet_infra::profile::master::basemodulepath')
  $environmentpath = hiera('puppet_infra::profile::master::environmentpath')
  $webhook_enable  = str2bool(hiera('puppet_infra::profile::master::r10k::webhook_enable'))

  validate_array($install_options)

  if $webhook_enable {
    $webhook_certname         = hiera('puppet_infra::profile::master::r10k::webhook_certname', $::fqdn)
    $webhook_enable_ssl       = str2bool(hiera('puppet_infra::profile::master::r10k::webhook_enable_ssl'))
    $webhook_protected        = str2bool(hiera('puppet_infra::profile::master::r10k::webhook_protected'))
    $webhook_user             = hiera('puppet_infra::profile::master::r10k::webhook_user', undef)
    $webhook_pass             = hiera('puppet_infra::profile::master::r10k::webhook_pass', undef)
    $webhook_public_key_path  = hiera('puppet_infra::profile::master::r10k::webhook_public_key_path', undef)
    $webhook_private_key_path = hiera('puppet_infra::profile::master::r10k::webhook_private_key_path', undef)

    if $webhook_protected {
      validate_string($webhook_user)
      validate_string($webhook_pass)
    }

    if $webhook_enable_ssl {
      validate_string($webhook_certname)
      validate_absolute_path($webhook_public_key_path)
      validate_absolute_path($webhook_private_key_path)
    }

    class {'puppet_infra::r10k::webhook':
      certname         => $webhook_certname,
      protected        => $webhook_protected,
      user             => $webhook_user,
      pass             => $webhook_pass,
      enable_ssl       => $webhook_enable_ssl,
      public_key_path  => $webhook_public_key_path,
      private_key_path => $webhook_private_key_path,
    }
  }

  ##  This section requires the zack/R10k module
  class { '::r10k':
    version           => $version,
    sources           => {
      'puppet' => {
        'remote'  => $remote,
        'basedir' => $environmentpath,
        'prefix'  => false,
      }
    },
    install_options   => $install_options,
  }

  exec {'r10k deploy environment -p':
    creates => "${environmentpath}/production/Puppetfile",
    command => '/opt/puppet/bin/r10k deploy environment -p',
    require => Class['::r10k'],
  }

}

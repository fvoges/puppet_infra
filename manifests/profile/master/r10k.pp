# Class: puppet_infra::profile::master::r10k
#
#
class puppet_infra::profile::master::r10k {
  $remote          = hiera('puppet_infra::profile::master::r10k::remote')
  $version         = hiera('puppet_infra::profile::master::r10k::version')
  $install_options = hiera('puppet_infra::profile::master::r10k::install_options', undef)

  Ini_setting {
    ensure => present,
    path   => "${::settings::confdir}/puppet.conf",
  }

  ini_setting { 'Configure environmentpath':
    section => 'main',
    setting => 'environmentpath',
    value   => '$confdir/environments',
  }

  ini_setting { 'Configure basemodulepath':
    section => 'main',
    setting => 'basemodulepath',
    value   => '$confdir/modules:/opt/puppet/share/puppet/modules',
  }

  ##  This section requires the zack/R10k module

  class { '::r10k':
    version           => $version,
    sources           => {
      'puppet' => {
        'remote'  => $remote,
        'basedir' => "${::settings::confdir}/environments",
        'prefix'  => false,
      }
    },
    purgedirs         => ["${::settings::confdir}/environments"],
    manage_modulepath => false,
    install_options   => $install_options,
  }

  # Remove the default production folder so git/r10k does not complain
  # This will then be regenerated from the this repos production branch
  exec {'rm -rf production':
    creates => "${::settings::confdir}/environments/production/Puppetfile",
    command => 'rm -rf /etc/puppetlabs/puppet/environments/production',
    require => Class['r10k'],
    path    => $::path,
  }

  exec {'r10k deploy environment -p':
    creates => "${::settings::confdir}/environments/production/Puppetfile",
    command => '/opt/puppet/bin/r10k deploy environment -p',
    require => Exec['rm -rf production'],
  }

}

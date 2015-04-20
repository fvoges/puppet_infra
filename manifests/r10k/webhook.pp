# Class: puppet_infra::r10k::webhook
#
#
class puppet_infra::r10k::webhook (
  $certname         = $::fqdn,
  $enable_ssl       = undef,
  $protected        = undef,
  $user             = undef,
  $pass             = undef,
  $public_key_path  = undef,
  $private_key_path = undef,
) {

  include r10k::mcollective

  # This is needed for compatibility
  # PE 3.7 changed the cert names
  file { "/var/lib/peadmin/.mcollective.d/$::fqdn-cert.pem":
    ensure => link,
    target => "/var/lib/peadmin/.mcollective.d/$::fqdn.cert.pem",
  }

  file { "/var/lib/peadmin/.mcollective.d/$::fqdn-private.pem":
    ensure => link,
    target => "/var/lib/peadmin/.mcollective.d/$::fqdn.private_key.pem",
  }

  class { '::r10k::webhook::config':
    certname         => $certname,
    enable_ssl       => $enable_ssl,
    protected        => $protected,
    pass             => $user,
    user             => $pass,
    # New parameters available on the master branch only
    #public_key_path  => $public_key_path,
    #private_key_path => $private_key_path,
  }

  class {'::r10k::webhook':
    require => Class['r10k::webhook::config'],
  }

}

# Class: puppet_infra::r10k::webhook
#
#
class puppet_infra::r10k::webhook (
  $user,
  $pass,
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
    certname       => $::fqdn,
    enable_ssl     => true,
    protected      => true,
    pass           => $user,
    user           => $pass,
  }

  class {'r10k::webhook':
    require => Class['r10k::webhook::config'],
  }

}

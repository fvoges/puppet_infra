class puppet_infra::gemrc {
  $managed = str2bool(hiera('puppet_infra::gemrc::managed'))

  validate_bool($managed)

  if $managed {
    $clear_sources = str2bool(hiera('puppet_infra::gemrc::clear_sources'))
    $sources       = hiera('puppet_infra::gemrc::sources')

    validate_bool($clear_sources)
    validate_array($sources)

    file { '/opt/puppet/etc':
      ensure => directory,
      owner  => 'root',
      group  => '0',
      mode   => '0755',
    }
    file { '/opt/puppet/etc/gemrc':
      ensure => file,
      owner  => 'root',
      group  => '0',
      mode   => '0644',
      content => template('puppet_infra/gemrc.erb'),
    }
  }
}
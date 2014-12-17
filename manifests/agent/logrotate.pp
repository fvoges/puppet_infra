# Class: puppet_infra::agent::logrotate
#
#
class puppet_infra::agent::logrotate {
  logrotate::rule { 'pe-puppet':
    ensure        => present,
    path          => '/var/log/pe-puppet/*log',
    rotate_every  => 'hour',
    rotate        => 7,
    size          => '1G',
    missingok     => true,
    sharedscripts => true,
    ifempty       => false,
    create        => true,
    create_owner  => 'pe-puppet',
    create_group  => 'pe-puppet',
    create_mode   => '0640',
    postrotate    => '[ -e /etc/init.d/pe-puppet ] && /etc/init.d/pe-puppet reload > /dev/null 2>&1 || true',
  }
}


# Class: puppet_infra::amq:logrotate
#
#
class puppet_infra::amq::logrotate {
  logrotate::rule { 'pe-mcollective':
    ensure        => present,
    path          => '/var/log/pe-mcollective/*log',
    rotate_every  => 'hour',
    rotate        => 7,
    size          => '1G',
    missingok     => true,
    sharedscripts => true,
    ifempty       => false,
    postrotate    => '/etc/init.d/pe-mcollective restart >/dev/null 2>&1 || true',
  }
}

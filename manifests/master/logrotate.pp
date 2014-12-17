# Class: puppet_infra::master::logrotate
#
#
class puppet_infra::master::logrotate {
  logrotate::rule { 'pe-puppetserver':
    ensure        => present,
    path          => '/var/log/pe-puppetserver/*log',
    rotate_every  => 'hour',
    rotate        => 7,
    size          => '1G',
    missingok     => true,
    ifempty       => false,
    copytruncate  => true,
    compress      => true,
    create        => true,
    create_owner  => 'pe-puppet',
    create_group  => 'pe-puppet',
    create_mode   => '0640',
  }

}
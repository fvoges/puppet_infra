# Class: puppet_infra::puppetdb::logrotate
#
#
class puppet_infra::puppetdb::logrotate {
  logrotate::rule { 'pe-puppetdb':
    ensure        => present,
    path          => '/var/log/pe-puppetdb/*log',
    rotate_every  => 'hour',
    rotate        => 7,
    size          => '1G',
    missingok     => true,
    ifempty       => false,
    copytruncate  => true,
    compress      => true,
    create        => true,
    create_owner  => 'pe-puppetdb',
    create_group  => 'pe-puppetdb',
    create_mode   => '0640',
  }
}
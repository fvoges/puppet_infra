# Class: puppet_infra::console::logrotate
#
#
class puppet_infra::console::logrotate {

  logrotate::rule { 'pe-console-services':
    ensure        => present,
    path          => '/var/log/pe-console-services/*log',
    rotate_every  => 'hour',
    rotate        => 7,
    size          => '1G',
    missingok     => true,
    ifempty       => false,
    missingok     => true,
    copytruncate  => true,
    compress      => true,
    create        => true,
    create_owner  => 'pe-console-services',
    create_group  => 'pe-console-services',
    create_mode   => '0640',
  }  

  logrotate::rule { 'pe-httpd':
    ensure        => present,
    path          => '/var/log/pe-httpd/*log',
    rotate_every  => 'hour',
    rotate        => '7',
    missingok     => true,
    ifempty       => false,
    sharedscripts => true,
    postrotate    => '/sbin/service pe-httpd reload > /dev/null 2>/dev/null || true'

  }

  logrotate::rule { 'pe-puppet-dashboard':
    ensure        => present,
    path          => '/var/log/pe-puppet-dashboard/*.log',
    rotate_every  => 'hour',
    rotate        => '7',
    missingok     => true,
    ifempty       => false,
    compress      => true,
    delaycompress => true,
    copytruncate  => true,
  }
}
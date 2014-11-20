# Class: puppet_infra::agent::service
#
#
class puppet_infra::agent::service {
  service { 'pe-puppet':
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }
}

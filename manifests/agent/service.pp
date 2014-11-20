# Class: puppet_infra::agent::service
#
#
class puppet_infra::agent::service {
  service { 'pe-puppet':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

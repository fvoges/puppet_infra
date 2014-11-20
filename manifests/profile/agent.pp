# Class: puppet_infra::profile::agent
#
#
class puppet_infra::profile::agent {
  $ca          = hiera('puppet_infra::profile::agent::ca')
  $server      = hiera('puppet_infra::profile::agent::server')
  $runinterval = hiera('puppet_infra::profile::agent::runinterval')

  class { '::puppet_infra::agent':
    agent_server       => $ca,
    agent_ca           => $server,
    agent_run_interval => $runinterval,
  }
}
# Class: puppet_infra::agent
#
#
class puppet_infra::agent (
  $agent_server       = $::puppet_infra::params::agent_server,
  $agent_ca           = $::puppet_infra::params::agent_ca,
  $agent_run_interval = $::puppet_infra::params::agent_run_interval,
) inherits ::puppet_infra::params {

  validate_string($agent_server)
  validate_string($agent_ca)
  validate_string($agent_run_interval)

  contain puppet_infra::agent::config
  contain puppet_infra::agent::service

  Class['puppet_infra::agent::config'] ~>
  Class['puppet_infra::agent::service']
}

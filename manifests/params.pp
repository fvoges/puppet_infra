# Class: puppet_infra::params
#
#
class puppet_infra::params {
  $agent_server                    = $::servername
  $agent_ca                        = $::servername
  $agent_run_interval              = '30m'

  $console_timzone                 = 'GMT'
  $console_unresponsive_threshold  = '3600'
  $console_disable_live_management = false

}

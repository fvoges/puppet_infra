# Class: puppet_infra::params
#
#
class puppet_infra::params {
  $hiera_base                      = "${::settings::confdir}/hieradata"
  $hiera_backends                  = ['yaml']
  $hiera_hierarchy                 = ['"%{clientcert}"','global',]
  $hiera_template                  = "${module_name}/hiera.yaml.erb"

  $agent_server                    = $::servername
  $agent_ca                        = $::servername
  $agent_run_interval              = '30m'

  $console_timzone                 = 'GMT'
  $console_unresponsive_threshold  = '3600'
  $console_disable_live_management = false

}

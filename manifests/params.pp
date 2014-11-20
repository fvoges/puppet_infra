# Class: puppet_infra::params
#
#
class puppet_infra::params {
  $hiera_base       = "${::settings::confdir}/hieradata"
  $hiera_backends   = ['yaml']
  $hiera_hierarchy  = ['"%{clientcert}"','global',]
  $hiera_template   = "${module_name}/hiera.yaml.erb"

  $agent_server       = $::server
  $agent_ca           = $::server
  $agent_run_interval = '30m'

}

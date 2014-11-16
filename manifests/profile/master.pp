# Class: puppet_infra::profile::master
#
class puppet_infra::profile::master inherits puppet_infra::profile::global {

  class { 'pe_repo':
    base_path => '/enod/hpc/repos/puppet/pe-packages',
  }

  include pe_repo::platform::el_5_x86_64
  include pe_repo::platform::el_6_x86_64
  include pe_repo::platform::el_7_x86_64
  include puppet_enterprise::profile::mcollective::peadmin
  include puppet_enterprise::profile::master::mcollective

  class { 'puppet_enterprise::profile::master':
    dns_alt_names   => ['pup01,pup01.enp.aramco.sa'],
    #console_host    => undef,
    #classifier_host => undef,
  }


}

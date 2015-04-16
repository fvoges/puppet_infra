# Class: puppet_infra::role::master
#
# DO NOT ADD YOUR PROFILES HERE
#
# This should only be used for reference/testing.
#
# To use in your enviroment, copy to your own roles module and add the
# base/common profile and nything else you require for your environment
#
class puppet_infra::role::master {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::broker
  include ::puppet_infra::profile::mcollective
}

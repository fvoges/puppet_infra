# Class: puppet_infra::role::ca
#
# DO NOT ADD YOUR PROFILES HERE
#
# This should only be used for reference/testing.
#
# To use in your enviroment, copy to your own roles module and add the
# base/common profile and nything else you require for your environment
#
class puppet_infra::role::ca {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::ca
  include ::puppet_infra::profile::hub
  include ::puppet_infra::profile::mcollective
}

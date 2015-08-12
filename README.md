# puppet_infra Puppet Module

## Table of contents

<!-- MarkdownTOC  depth=0 -->

- [Overview](#overview)
- [Requirements](#requirements)
- [Module Description](#module-description)
- [Setup](#setup)
  - [What `puppet_infra` affects](#what-puppet_infra-affects)
    - [On CA](#on-ca)
    - [On Puppet DB](#on-puppet-db)
    - [On Console](#on-console)
    - [On MCollective Hub and Spoke](#on-mcollective-hub-and-spoke)
    - [On Compile only Masters](#on-compile-only-masters)
    - [On the Puppet Agents](#on-the-puppet-agents)
  - [Beginning with `puppet_infra`](#beginning-with-puppet_infra)
    - [Configuration](#configuration)
- [Usage](#usage)
- [Reference](#reference)
- [Limitations](#limitations)
- [Development](#development)

<!-- /MarkdownTOC -->


- [Overview](#overview)
- [Requirements](#requirements)
- [Module Description](#module-description)
- [Setup](#setup)
  - [What `puppet_infra` affects](#what-puppet_infra-affects)
    - [On CA](#on-ca)
    - [On Puppet DB](#on-puppet-db)
    - [On Console](#on-console)
    - [On MCollective Hub and Spoke](#on-mcollective-hub-and-spoke)
    - [On Compile only Masters](#on-compile-only-masters)
    - [On the Puppet Agents](#on-the-puppet-agents)
  - [Beginning with `puppet_infra`](#beginning-with-puppet_infra)
    - [Configuration](#configuration)
- [Usage](#usage)
- [Reference](#reference)
- [Limitations](#limitations)
- [Development](#development)

## Overview

This Module manages a Multi Master Puppet Enterprise environment with the CA acting as Master of Masters and multiple compile masters.

It was inspired by [beergeek/puppet_master](https://github.com/beergeek/puppet_master) but it tries to re-use the modules bundled with PE 3.7+ as much as possible.

## Requirements

This module requires Puppet Enterprise, it relies on modules shipped with PE that are not available with Puppet open source.

* Puppet Enterprise 3.7+ - Use [beergeek/puppet_master](https://github.com/beergeek/puppet_master) for PE 3.3.x
* Modules:
  * [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)
  * [rodjek/logrotate](https://forge.puppetlabs.com/rodjek/logrotate)
  * [reidmv/yamlfile](https://forge.puppetlabs.com/reidmv/yamlfile) ([future](https://github.com/fvoges/puppet_infra/issues/2))

## Module Description

## Setup

### What `puppet_infra` affects

This module uses `puppet_enterprise` and other PE modules. The next section list only the resouces that are directly managed by this module.

#### On CA

 * Limits for `pe-puppet`.
 * `/etc/puppetlabs/puppet/hiera.yaml`
 * `/opt/puppet/etc/gemrc`

#### On Puppet DB

#### On Console

Limits for `pe-console-services`.
Console settings (`/etc/puppetlabs/console-settings.conf`).

#### On MCollective Hub and Spoke

Limits for `pe-activemq`.

#### On Compile only Masters

#### On the Puppet Agents

 * Agent section of `/etc/puppetlabs/puppet/puppet.conf`
   * `ca_server`
   * `server`
   * `runinterval`
 * `/etc/logrotate.d/pe-puppet.conf`


### Beginning with `puppet_infra`

The basic installation is

1. Create control repository (optional)
1. Install PE
1. Bootstrap r10k (optional)
1. Run r10k to deploy all the Puppet environments (optional)
1. Apply puppet_infra::role::ca to the Puppet CA node to finish off configureing PE

`puppet_infra` provides a set of example roles that you can use in your environment. Do not modify puppet_infra. Instead, copy them to your roles module, rename the classes and add your changes (for example, your base/common/global profile).


Puppet CA/Master of Masters (MOM)

```puppet
class puppet_infra::role::ca {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::ca
  include ::puppet_infra::profile::hub
  include ::puppet_infra::profile::mcollective
}
```

Puppet DB

```puppet
class puppet_infra::role::puppetdb {
  include ::puppet_infra::profile::puppetdb
}
```

Puppet Console

```puppet
class puppet_infra::role::console {
  include ::puppet_infra::profile::console
  include ::puppet_infra::profile::mcollective
}
```

Puppet Master (compile only)

```puppet
class puppet_infra::role::master {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::broker
  include ::puppet_infra::profile::mcollective
}
```

There's also an all-in-one role you can use for testing.

```puppet
class puppet_infra::role::allinone {
  include ::puppet_infra::profile::master
  include ::puppet_infra::profile::ca
  include ::puppet_enterprise::profile::amq::broker
  include ::puppet_infra::profile::puppetdb
  include ::puppet_infra::profile::console
  include ::puppet_infra::profile::mcollective
}
```

#### Configuration

The PE infrastruture then can be configured with Hiera. Here's an example:

```yaml
#PE3.7
puppet_enterprise::profile::puppetdb::listen_address: '0.0.0.0'
puppet_enterprise::profile::amq::broker::heap_mb: '4096'
# If not set, the hub will use the broker setting
puppet_enterprise::profile::amq::hub::heap_mb: '4096'
puppet_enterprise::profile::master::java_args:
  Xmx: '4096m'
  Xms: '4096m'
#  'XX:MaxPermSize': '=96m'
#  'XX:PermSize': '=96m'
puppet_enterprise::profile::puppetdb::java_args:
  Xmx: '8192m'
  Xms: '8192m'
puppet_enterprise::profile::console::java_args:
  Xmx: '8192m'
  Xms: '8192m'
puppet_enterprise::master::puppetserver::jruby_max_active_instances: 4
puppet_enterprise::profile::console::delayed_job_workers: 4
#shared_buffers takes affect during install but is not managed after
#puppet_enterprise::profile::database::shared_buffers: '4MB'

puppet_infra::profile::global::mcollective_middleware_hosts:
  - mcospoke01.example.com
  - mcospoke02.example.com
  - mcospoke03.example.com
puppet_infra::profile::global::database_host: 'puppetdb.example.com'
puppet_infra::profile::global::puppetdb_host: 'puppetdb.example.com'
puppet_infra::profile::global::puppet_master_host: 'master.example.com'
puppet_infra::profile::global::certificate_authority_host: 'puppetca.example.com'
puppet_infra::profile::global::console_host: 'puppetconsole.example.com'
puppet_infra::profile::global::disable_console: 'no'
puppet_infra::profile::global::disable_classifier: 'yes'

puppet_infra::profile::console::prune_upto: '30'
puppet_infra::profile::console::password_reset_expiration: '24'
puppet_infra::profile::console::session_timeout: '14400'
puppet_infra::profile::console::failed_attempts_lockout: '10'
puppet_infra::profile::console::timezone: 'GMT'
puppet_infra::profile::console::unresponsive_threshold: '3600'
puppet_infra::profile::console::disable_live_management: false

puppet_infra::profile::master::pe_repo_base_path: 'http://puppetca.example.com/'
puppet_infra::profile::master::basemodulepath: '/etc/puppetlabs/puppet/modules:/opt/puppet/share/puppet/modules'
puppet_infra::profile::master::environmentpath: '/etc/puppetlabs/puppet/environments'
puppet_infra::profile::master::hiera_conf_symlink: 'yes'
puppet_infra::profile::master::manage_r10k: 'yes'
puppet_infra::profile::master::r10k::webhook_enable: 'yes'
puppet_infra::profile::master::r10k::webhook_user: ''
puppet_infra::profile::master::r10k::webhook_pass: ''
puppet_infra::profile::master::r10k::remote: 'http://git.example.com/puppet/puppet-control.git'
puppet_infra::profile::master::r10k::version: '1.5.1'
puppet_infra::profile::master::r10k::webhook_enable_ssl: 'no'
puppet_infra::profile::master::r10k::webhook_protected: 'no'

puppet_infra::gemrc::managed: 'yes'
puppet_infra::gemrc::clear_sources: 'yes'
puppet_infra::gemrc::sources:
  - 'http://rubygems.example.com/rubygems/repo/'
```

## Usage

## Reference

## Limitations

Tested on RedHat/Centos 6.x 64 only.

## Development

Pull requests are welcome.

Issues tracker in the [project page](https://github.com/fvoges/puppet_infra/issues)




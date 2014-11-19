# puppet_infra 

## Table of contents

1. [Overview](#overview)
2. [Module description](#module-description)
3. [Setup - The basics of getting started with puppet_infra](#setup)
    * [What puppet_infra affects](#what-infra-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet_infra](#beginning-with-puppet_infra)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This Module is to manage a Multi Master Puppet Enterprise environment with the CA acting as Master of Masters and multiple compile masters.

It was inspired by [beergeek/puppet_master](https://github.com/beergeek/puppet_master) but it tries to re-use the modules  bundled with PE as much as possible.

## Module Description

## Setup

### What puppet_infra affects

On CA
  * hiera.yaml

On Compile only Masters
  * hiera.yaml


### Setup requirements

* Puppet Enterprise 3.7+ - Use [beergeek/puppet_master](https://github.com/beergeek/puppet_master) for PE 3.3.x


### Beginning with puppet_infra
## Usage
## Reference

## Limitations

Tested on RedHat/Centos 6.5 64 only.

## Development

Pull requests are welcome.




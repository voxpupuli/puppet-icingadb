# icingadb

![Icinga Logo](https://www.icinga.com/wp-content/uploads/2014/06/icinga_logo.png)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with icingadb](#setup)
    * [What icingadb affects](#what-icingadb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with icingadb](#beginning-with-icingadb)
4. [Reference](#reference)
5. [Release notes](#release-notes)

## Description

This module manages the IcingaDB Redis server and the IcingaDB itself.

## Setup

### What the IcingaDB Puppet module supports

* Management of the IcingaDB Redis
* and the icingaDB itself

### Setup Requirements

This module supports:

* [puppet] >= 6.0.0 < 8.0.0

And requiers:

* [puppetlabs/stdlib] >= 5.1.0 < 9.0.0
* [icinga/icinga] >= 2.9.0 < 4.0.0

### Beginning with icingadb

Add this declaration to your Puppetfile:
```
mod 'icingadb',
  :git => 'https://github.com/icinga/puppet-icingadb.git',
  :tag => 'v1.0.0'
```
Then run:
```
bolt puppetfile install
```

Or do a `git clone` by hand into your modules directory:
```
git clone https://github.com/icinga/puppet-icingadb.git icingadb
```
Change to `icingadb` directory and check out your desired version:
```
cd icingadb
git checkout v1.0.0
```

## Reference

See [REFERENCE.md](https://github.com/Icinga/puppet-icingadb/blob/master/REFERENCE.md)

## Release Notes

This code is a very early release and may still be subject to significant changes.

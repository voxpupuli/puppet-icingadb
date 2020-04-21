# icingadb

![Icinga Logo](https://www.icinga.com/wp-content/uploads/2014/06/icinga_logo.png)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with icingadb](#setup)
    * [What icingadb affects](#what-icingadb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with icingadb](#beginning-with-icingadb)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference](#reference)
5. [Release notes](#release-notes)

## Description

This module manages the IcingaDB Redis server and the IcingaDB itself.

## Setup

### What the IcingaDB Puppet module supports

* 
*

### Setup Requirements

This module supports:

* [puppet] >= 5.5.8 < 7.0.0

And requiers:

* [puppetlabs/stdlib] >= 4.16.0 < 7.0.0
    * If Puppet 6 is used a stdlib 5.1 or higher is required
* [icinga/icinga] >= 0.1.1
* [puppet/redis] >= 4.0.0

### Beginning with icingadb

Add this declaration to your Puppetfile:
```
mod 'icingadb',
  :git => 'https://github.com/icinga/puppet-icingadb.git',
  :tag => 'v0.1.0'
```
Then run:
```
bolt puppetfile install
```

Or do a `git clone` by hand into your modules directory:
```
git clone https://github.com/icinga/puppet-icingadb.bgit icinga
```
Change to `icingadb` directory and check out your desired version:
```
cd icingadb
git checkout v0.1.0
```

## Usage

### icingadb::redis

```
include ::icingadb::redis
```

```
class { '::icinga::redis':
  manage_repo  => true,
  bind         => '127.0.0.1',
  port         => 6381,
}
```

### icingadb

To store historical data IcingaDB uses a MySQL/MariaDB database. In the future also PostgreSQL support will be available.
```
include ::mysql::server
```
Note: If you’re using a version of MySQL < 5.7 or MariaDB < 10.2, the following server options must be set:
```
class { 'mysql::server':
  override_options => {
    mysqld => {
      innodb_file_format    => 'barracuda',
      innodb_file_per_table => 1,
      innodb_large_prefix   => 1,
    },
  },
}
```
The database declaration itself is in both case the same:
```
mysql::db { 'icingadb':
  user     => 'icingadb',
  password => 'supersecret',
  host     => 'localhost',
  grant    => [ 'ALL' ],
}
```
By default only a database password has to be set. After a puppet run, IcingaDB is configures to connect a local MySQL/MariaDB and a local Redis server on port 6380. But no repository is involved. To do this, set `manage_repo` to `true` to use the class `icinga::repos` automatically. For more feature see [icinga](https://github.com/Icinga/puppet-icinga). 
```
class { '::icingadb':
  manage_repo => true,
  db_password => 'supersecret',
}
```
In the last example the database will be connected but you've first to import the schema. This could by done by hand or you set `import_db_schema` to `true` like in the following example. There is also shown how a Redis server has to connect on a different port.
```
class { '::icingadb':
  redis_host       => 'localhost',
  redis_port       => 6381,
  db_password      => 'supersecret',
  import_db_schema => true,
}
```
Also the needed database can located on a different host and port:
```
class { '::icingadb':
  db_host     => 'mysql.example.de',
  db_port     => 3309,
  db_name     => 'icingadb',
  db_username => 'icingadb',
  db_password => 'supersecret',
}
```
  

## Reference

See [REFERENCE.md](https://github.com/Icinga/puppet-icingadb/blob/master/REFERENCE.md)

## Release Notes

This code is a very early release and may still be subject to significant changes.

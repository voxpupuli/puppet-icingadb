# TESTING

## Prerequisites
Before starting any test, you should make sure you have installed the Puppet PDK and Bolt.

Required gems are installed with `bundler`:
```
cd puppet-icingadb
pdk bundle install
```

Or just do an update:
```
cd puppet-icingadb
pdk bundle update
```

## Validation tests
Validation tests will check all manifests, templates and ruby files against syntax violations and style guides .

Run validation tests:
```
cd puppet-icingadb
pdk validate
```

## Unit tests
For unit testing we use [RSpec]. All classes, defined resource types and functions should have appropriate unit tests.

Run unit tests:
``` bash
cd puppet-icingadb
pdk test unit
```

Or dedicated tests:
``` bash
pdk test unit --tests=spec/classes/redis_spec.rb,spec/classes/icingadb_spec.rb
```

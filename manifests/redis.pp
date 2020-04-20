# @summary
#   Manage the IcingaDB Redis server
#
# @param [Enum['running','stopped']] ensure
#
# @param [Boolean] ensure

# @example
#   include icingadb::redis
#
class icingadb::redis(
  Enum['running','stopped']                 $ensure         = 'running',
  Boolean                                   $enable         = true,
  Variant[Stdlib::Host,Array[Stdlib::Host]] $bind           = [ '127.0.0.1', '::1' ],
  Stdlib::Port::Unprivileged                $port           = 6380,
  Boolean                                   $manage_repo    = false,
  Boolean                                   $manage_package = true,
) {

  require ::icingadb::redis::globals

  if $manage_repo {
    require ::icinga::repos
  }

  class { '::icingadb::redis::install': }
  -> class { '::icingadb::redis::config': }
  ~> class { '::icingadb::redis::service': }

  contain ::icingadb::redis::install
  contain ::icingadb::redis::config
  contain ::icingadb::redis::service
}

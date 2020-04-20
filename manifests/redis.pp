# @summary
#   Manage the IcingaDB Redis server.
#
# @param [Enum['running','stopped']] ensure
#   Choose wether the service is `running` or `stopped`. Defaults to `running`.
#
# @param [Boolean] ensure
#   Choose wether the service has to start at boot. Defaults to `true`.
#
# @param [Array[Stdlib::Host]] bind
#   Configure which IP address(es) to listen on. To bind on all interfaces, use an empty array.
#   Defaults to `127.0.0.1` and `::1`.
#
# @param [Stdlib::Port::Unprivileged] port
#   Configure which port to listen on. Defaults to `6380`.
#
# @param [Boolean] manage_repo
#   Whether to involve the Icinga repositories. Defaults to `false`.
#
# @param [Boolean] manage_package
#   Whether to manage the IcingaDB package. Defaults to `true`.
#
# @example
#   class { '::icingadb::redis':
#     manage_repo => true,
#     bind        => '127.0.0.1',
#     port        => 6380,
#   }
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

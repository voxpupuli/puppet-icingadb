# @summary
#   Manage the IcingaDB Redis server.
#
# @param ensure
#   Choose wether the service is `running` or `stopped`.
#
# @param ensure
#   Choose wether the service has to start at boot.
#
# @param bind
#   Configure which IP address(es) to listen on. To bind on
#   all interfaces, use an empty array.
#
# @param port
#   Configure which port to listen on.
#
# @param manage_repo
#   Whether to involve the Icinga repositories.
#
# @param manage_package
#   Whether to manage the IcingaDB package.
#
# @param requirepass
#   Require clients to issue AUTH <PASSWORD> before processing
#   any other commands.
#
# @param config
#   Other parameters that can be set, see redis::instance.
#
# @example
#   class { '::icingadb::redis':
#     manage_repo => true,
#     bind        => '127.0.0.1',
#     port        => 6380,
#     config      => {
#       tcp_keepalive => 400,
#       databases     => 8,
#     }
#   }
#
class icingadb::redis(
  Enum['running','stopped']                 $ensure         = 'running',
  Boolean                                   $enable         = true,
  Variant[Stdlib::Host,Array[Stdlib::Host]] $bind           = [ '127.0.0.1', '::1' ],
  Stdlib::Port::Unprivileged                $port           = 6380,
  Optional[String]                          $requirepass    = undef,
  Boolean                                   $manage_repo    = false,
  Boolean                                   $manage_package = true,
  Hash[String,Any]                          $config         = {},
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

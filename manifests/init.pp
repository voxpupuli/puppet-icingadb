# @summary
#   Puppet class to manage IcingaDB.
#
# @param ensure
#   Choose wether the service is `running` or `stopped`.
#
# @param enable
#   Choose wether the service has to start at boot.
#
# @param manage_repos
#   Whether to involve the Icinga repositories.
#
# @param manage_package
#   Whether to manage the IcingaDB package.
#
# @param redis_host
#   Redis server to connect.
#
# @param redis_port
#   Port on the Redis host to connect.
#
# @param redis_password
#   Passwort to login into redis.
#
# @param db_type
#   Choose wether MySQL or PostgreSQL as backend for historical data.
#
# @param db_host
#   Database server.
#
# @param db_port
#   Port to connect the database.
#
# @param db_name
#   The IcingaDB database.
#
# @param db_username
#   User that is used to connect the database.
#
# @param db_password
#   Passwort to login into database.
#
# @param import_db_schema
#   Enables the initial creation of the database schema.
#
# @param logging_level
#   Specifies the default logging level. Can be set to fatal, error, warn, info or debug.
#
# @param logging_output
#   Configures the logging output. Can be set to console (stderr) or systemd-journald.
#
# @param logging_interval
#   Interval for periodic logging defined as duration string.
#
# @param logging_options
#   Map of component-logging level pairs to define a different log level than
#   the default value for each component.
#
# @param retention_history_data
#   Number of days to retain full historical data.
#
# @param retention_sla_data
#   Number of days to retain historical data for SLA reporting.
#
# @param retention_options
#   Map of history category to number of days to retain its data in order to
#   enable retention only for specific categories or to override the number
#   that has been configured in `retention_history_data`.
#
# @example
#   class { 'icingadb':
#     manage_repos     => true,
#     db_type          => 'pgsql',
#     db_password      => 'supersecret',
#     import_db_schema => true,
#   }
#
class icingadb(
  Variant[String, Sensitive[String]]             $db_password,
  Enum['running','stopped']                      $ensure                 = 'running',
  Boolean                                        $enable                 = true,
  Boolean                                        $manage_repos           = false,
  Boolean                                        $manage_package         = true,
  Stdlib::Host                                   $redis_host             = 'localhost',
  Optional[Stdlib::Port]                         $redis_port             = undef,
  Optional[Variant[String, Sensitive[String]]]   $redis_password         = undef,
  Enum['mysql','pgsql']                          $db_type                = 'mysql',
  Stdlib::Host                                   $db_host                = 'localhost',
  Optional[Stdlib::Port]                         $db_port                = undef,
  String                                         $db_name                = 'icingadb',
  String                                         $db_username            = 'icingadb',
  Boolean                                        $import_db_schema       = false,
  Enum['fatal','error','warn','info','debug']    $logging_level          = 'info',
  Optional[Enum['console','systemd-journald']]   $logging_output         = undef,
  Hash[Enum[
    'config-sync','database','dump-signals',
    'heartbeat','high-availability',
    'history-sync','overdue-sync','redis',
    'retention','runtime-updates','telemetry'
  ],Enum['fatal','error','warn','info','debug']] $logging_options        = {},
  Pattern[/^\d+\.?\d*[d|h|m|s]?$/]               $logging_interval       = '20s',
  Optional[Integer[1]]                           $retention_history_data = undef,
  Optional[Integer[1]]                           $retention_sla_data     = undef,
  Hash[Enum[
    'acknowledgement','comment','downtime',
    'flapping','notification','state'
  ],Integer[1]]                                $retention_options        = {},
) {

  require ::icingadb::globals

  if $manage_repos {
    require ::icinga::repos
  }

  class { '::icingadb::install': }
  -> class { '::icingadb::config': }
  ~> class { '::icingadb::service': }

  contain icingadb::install
  contain icingadb::config
  contain icingadb::service
}

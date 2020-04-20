# @summary
#   Puppet class to manage IcingaDB.
#
# @param Enum['running','stopped'] ensure
#   Choose wether the service is `running` or `stopped`. Defaults to `running`.
#
# @param [Boolean] enable
#   Choose wether the service has to start at boot. Defaults to `true`.
#
# @param [Stdlib::Host] redis_host
#   Redis server to connect. Defaults to `localhost`.
#
# @param [Stdlib::Port::Unprivileged] redis_port
#   Port on the Redis host to connect. Defaults by IcingaDB to `6380`.
#
# @param [Integer[0]] redis_pool_size
#   Maximum number of socket connections. Defaults by IcingaDB to `64`.
#
# @param [Enum['mysql','pgsql']] db_type
#   Choose wether MySQL or PostgreSQL as backend for historical data. Defaults to `mysql`.
#
# @param [Stdlib::Host] db_host
#   Database server. Defaults to `localhost`.
#
# @param [Stdlib::Port::Unprivileged] db_port
#   Port to connect the DBMS. Defaults by IcingaDB to 3306 for MySQL or 5432 for PostgreSQL.
#
# @param [String] db_name
#   The IcingaDB database. Defaults to `icingadb`.
#
# @param [String] db_username
#   User that is used to connect the database. Defaults to `icingadb`.
#
# @param [String] db_password
#   Passwort to login database.
#
# @param [Integer[0]] db_max_open_conns
#   Maximum number of open connections. Defaults by IcingaDB to 50.
#
# @param [Boolean] import_db_schema
#   Enables the initial creation of the database schema. Defaults to `false`.
#
# @param [Boolean] manage_repo
#   Whether to involve the Icinga repositories. Defaults to `false`.
#
# @param [Boolean] manage_package
#   Whether to manage the IcingaDB package. Defaults to `true`.
#
# @example
#   class { 'icingadb':
#     manage_repo      => true,
#     db_password      => 'supersecret',
#     import_db_schema => true,
#     require          => Mysql::Db['icingadb'],
#   }
#
class icingadb(
  String                               $db_password,
  Enum['running','stopped']            $ensure            = 'running',
  Boolean                              $enable            = true,
  Stdlib::Host                         $redis_host        = 'localhost',
  Optional[Stdlib::Port::Unprivileged] $redis_port        = undef,
  Optional[Integer[0]]                 $redis_pool_size   = undef,
  Enum['mysql','pgsql']                $db_type           = 'mysql',
  Stdlib::Host                         $db_host           = 'localhost',
  Optional[Stdlib::Port::Unprivileged] $db_port           = undef,
  String                               $db_name           = 'icingadb',
  String                               $db_username       = 'icingadb',
  Optional[Integer[0]]                 $db_max_open_conns = undef,
  Boolean                              $import_db_schema  = false,
  Boolean                              $manage_repo       = false,
  Boolean                              $manage_package    = true,
) {

  require ::icingadb::globals

  if $manage_repo {
    require ::icinga::repos
  }

  class { '::icingadb::install': }
  -> class { '::icingadb::config': }
  ~> class { '::icingadb::service': }

  contain icingadb::install
  contain icingadb::config
  contain icingadb::service
}

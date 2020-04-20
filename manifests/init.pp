# @summary
#   Puppet class to manage IcingaDB.
#
# @param ensure
#
# @param [Boolean] enable
#
# @param [Stdlib::Host] redis_host
#
# @param [Stdlib::Port::Unprivileged] redis_port
#
# @param [Integer[0]] redis_pool_size
#
# @param db_type
#
# @param [Stdlib::Host] db_host
#
# @param [Stdlib::Port::Unprivileged] db_port
#
# @param [String] db_name
#
# @param [String] db_username
#
# @param [String] db_password
#
# @param [Integer[0]] db_max_open_conns
#
# @param [Boolean] import_db_schema
#
# @param [Boolean] manage_repo
#
# @param [Boolean] manage_package
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

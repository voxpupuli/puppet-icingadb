# @summary A short summary of the purpose of this class
#   Configures IcingaDB
#
# @api private
#
class icingadb::config {

  $conf_dir          = $::icingadb::globals::conf_dir
  $user              = $::icingadb::globals::user
  $group             = $::icingadb::globals::group
  $redis_host        = $::icingadb::redis_host
  $redis_port        = $::icingadb::redis_port
  $redis_pool_size   = $::icingadb::redis_pool_size
  $db_type           = $::icingadb::db_type
  $db_host           = $::icingadb::db_host
  $db_port           = $::icingadb::db_port
  $db_name           = $::icingadb::db_name
  $db_username       = $::icingadb::db_username
  $db_password       = $::icingadb::db_password
  $db_max_open_conns = $::icingadb::db_max_open_conns

  file { "${conf_dir}/icingadb.ini":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('icingadb/icingadb.ini.erb'),
  }

}

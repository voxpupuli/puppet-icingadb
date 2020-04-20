# @summary
#   Imports MySQL IcingaDB schema
#
# @api private
#
class icingadb::install::mysql {

  $mysql_db_schema = $::icingadb::globals::mysql_db_schema
  $db_host         = $::icingadb::db_host
  $db_port         = $::icingadb::db_port
  $db_name         = $::icingadb::db_name
  $db_username     = $::icingadb::db_username
  $db_password     = $::icingadb::db_password

  $_mysql_options = join(any2array(delete_undef_values({
    '-h' => $db_host ? {
      /localhost/ => undef,
      default     => $db_host,
    },
    '-P' => $db_port,
    '-u' => $db_username,
  })), ' ')

  $_mysql_command = "mysql ${_mysql_options} -p'${db_password}' ${db_name}"

  exec { 'icingadb-mysql-import-schema':
    user    => 'root',
    path    => $::path,
    command => "${_mysql_command} < \"${mysql_db_schema}\"",
    unless  => "${_mysql_command} -Ns -e 'select version from icingadb_schema'",
  }
}

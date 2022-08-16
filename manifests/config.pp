# @summary A short summary of the purpose of this class
#   Configures IcingaDB
#
# @api private
#
class icingadb::config {

  $conf_dir          = $::icingadb::globals::conf_dir
  $user              = $::icingadb::globals::user
  $group             = $::icingadb::globals::group

  file { "${conf_dir}/config.yml":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => epp(
      'icingadb/config.yml.epp', {
        redis_host             => $::icingadb::redis_host,
        redis_port             => $::icingadb::redis_port,
        redis_password         => $::icingadb::redis_password,
        db_type                => $::icingadb::db_type,
        db_host                => $::icingadb::db_host,
        db_port                => $::icingadb::db_port,
        db_name                => $::icingadb::db_name,
        db_username            => $::icingadb::db_username,
        db_password            => $::icingadb::db_password,
        logging_level          => $::icingadb::logging_level,
        logging_output         => $::icingadb::logging_output,
        logging_interval       => $::icingadb::logging_interval,
        logging_options        => $::icingadb::logging_options,
        retention_history_data => $::icingadb::retention_history_data,
        retention_sla_data     => $::icingadb::retention_sla_data,
        retention_options      => $::icingadb::retention_options,
      }
    ),
  }

}

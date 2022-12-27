# @summary A short summary of the purpose of this class
#   Configures IcingaDB
#
# @api private
#
class icingadb::config {
  assert_private()

  $conf_dir        = $icingadb::globals::conf_dir
  $user            = $icingadb::globals::user
  $group           = $icingadb::globals::group
  $redis_tls_files = $icingadb::redis_tls_files
  $db_tls_files    = $icingadb::db_tls_files

  icinga::cert { 'icingadb tls files for the database client connect':
    owner => $user,
    group => $group,
    args  => $db_tls_files,
  }

  icinga::cert { 'icingadb tls files for the redis client connect':
    owner => $user,
    group => $group,
    args  => $redis_tls_files,
  }

  file { "${conf_dir}/config.yml":
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => epp(
      'icingadb/config.yml.epp', {
        redis_host             => $icingadb::redis_host,
        redis_port             => $icingadb::redis_port,
        redis_password         => $icingadb::redis_password,
        db_type                => $icingadb::db_type,
        db_host                => $icingadb::db_host,
        db_port                => $icingadb::db_port,
        db_name                => $icingadb::db_name,
        db_username            => $icingadb::db_username,
        db_password            => $icingadb::db_password,
        db_tls                 => $icingadb::db_use_tls,
        db_tls_cert            => $db_tls_files['cert_file'],
        db_tls_key             => $db_tls_files['key_file'],
        db_tls_cacert          => $db_tls_files['cacert_file'],
        db_tls_insecure        => $icingadb::db_tls_insecure,
        redis_tls              => $icingadb::redis_use_tls,
        redis_tls_cert         => $redis_tls_files['cert_file'],
        redis_tls_key          => $redis_tls_files['key_file'],
        redis_tls_cacert       => $redis_tls_files['cacert_file'],
        redis_tls_insecure     => $icingadb::redis_tls_insecure,
        logging_level          => $icingadb::logging_level,
        logging_output         => $icingadb::logging_output,
        logging_interval       => $icingadb::logging_interval,
        logging_options        => $icingadb::logging_options,
        retention_history_data => $icingadb::retention_history_data,
        retention_sla_data     => $icingadb::retention_sla_data,
        retention_options      => $icingadb::retention_options,
      }
    ),
  }

  -> File <| ensure != 'directory' and tag == 'icingadb::config::file' |>
}

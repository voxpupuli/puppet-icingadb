# @summary 
#   Configures IcingaDB Redis server
#
# @api private
#   
class icingadb::redis::config {
  redis::instance { 'icingadb-redis':
    * => merge($::icingadb::redis::config, {
      bind                => any2array($::icingadb::redis::bind),
      config_file         => "${::icingadb::redis::globals::conf_dir}/icingadb-redis.conf",
      config_file_orig    => "${::icingadb::redis::globals::conf_dir}/icingadb-redis.conf",
      config_owner        => $::icingadb::redis::globals::user,
      config_group        => $::icingadb::redis::globals::group,
      port                => $::icingadb::redis::port,
      daemonize           => true,
      service_user        => $::icingadb::redis::globals::user,
      service_group       => $::icingadb::redis::globals::group,
      workdir             => $::icingadb::redis::globals::work_dir,
      manage_service_file => false,
      service_name        => $::icingadb::redis::globals::service_name,
      pid_file            => "${::icingadb::redis::globals::run_dir}/icingadb-redis-server.pid",
      log_file            => "${::icingadb::redis::globals::log_dir}/icingadb-redis-server.log",
      requirepass         => $::icingadb::redis::requirepass,
    })
  }
}

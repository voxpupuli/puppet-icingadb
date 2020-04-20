# @summary 
#   Configures IcingaDB Redis server
#
# @api private
#   
class icingadb::redis::config {

  $redis_bin         = $::icinga::redis::globals::redis_bin
  $conf_dir          = $::icinga::redis::globals::conf_dir
  $work_dir          = $::icinga::redis::globals::work_dir
  $run_dir           = $::icinga::redis::globals::run_dir
  $log_dir           = $::icinga::redis::globals::log_dir
  $user              = $::icinga::redis::globals::user
  $group             = $::icinga::redis::globals::group
  $service_unit_file = $::icingadb::redis::globals::service_unit_file
  $service_name      = $::icingadb::redis::globals::service_name
  $bind              = $::icingadb::redis::bind
  $port              = $::icingadb::redis::port

  redis::instance { 'icingadb-redis':
    bind                => any2array($bind),
    config_file         => "${conf_dir}/icingadb-redis.conf",
    config_file_orig    => "${conf_dir}/icingadb-redis.conf",
    config_group        => $group,
    config_owner        => $user,
    port                => $port,
    service_user        => $user,
    workdir             => "${work_dir}/icingadb-redis",
    manage_service_file => false,
    service_name        => $service_name,
    pid_file            => "${run_dir}/icingadb-redis-server.pid",
    log_file            => "${log_dir}/icingadb-redis-server.log",
    unixsocket          => '',
    tcp_keepalive       => lookup('redis::tcp_keepalive', Integer[0], undef, 300),
  }

  file { $service_unit_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icingadb/redis-service-unit-file.erb')
  }

  ~> Exec['systemd-reload-redis']
}

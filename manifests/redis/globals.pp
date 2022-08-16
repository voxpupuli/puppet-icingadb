# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
class icingadb::redis::globals(
  String               $package_name,
  String               $service_name,
  String               $user,
  String               $group,
  Stdlib::Absolutepath $redis_bin,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $work_dir,
  Stdlib::Absolutepath $run_dir,
  Stdlib::Absolutepath $log_dir,
  Stdlib::Absolutepath $service_unit_file,
) {
}

# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
# @param package_name
#  The name of the icingadb-redis package to manage.
#
# @param selinux_package_name
#   The name of the icingadb-redis selinux package.
#
# @param service_name
#   The name of the icingadb-redis service to manage.
#
# @param user
#   User as the icingadb-redis process runs.
#   CAUTION: This does not manage the user context for the runnig icingadb-redis process!
#   The parameter is only used for ownership of files or directories.
#
# @param group
#   Group as the icingadb-redis process runs.
#   CAUTION: This does not manage the group context for the runnig icingadb-redis process!
#   The parameter is only used for group membership of files or directories.
#
# @param redis_bin
#   Redis binary
#
# @param conf_dir
#   Directory of the IcingaDB Redis config files.
#
# @param work_dir
#   Directory for the IcingaDB Redis working data.
#
# @param run_dir
#   Location to store the runtime information.
#
# @param log_dir
#   Directory for the log files.
#
class icingadb::redis::globals (
  String[1]            $package_name,
  String[1]            $selinux_package_name,
  String[1]            $service_name,
  String[1]            $user,
  String[1]            $group,
  Stdlib::Absolutepath $redis_bin,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $work_dir,
  Stdlib::Absolutepath $run_dir,
  Stdlib::Absolutepath $log_dir,
) {
}

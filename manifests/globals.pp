# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
# @param [String] package_name
#
# @param [String] service_name
#
# @param [String] user
#
# @param [String] group
#
# @param [Stdlib::Absolutepath] conf_dir
#
# @param [Stdlib::Absolutepath] mysql_db_schema
#
class icingadb::globals(
  String               $package_name,
  String               $service_name,
  String               $user,
  String               $group,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $mysql_db_schema,
) {
}

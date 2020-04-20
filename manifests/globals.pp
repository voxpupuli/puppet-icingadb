# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
class icingadb::globals(
  String               $package_name,
  String               $user,
  String               $group,
  String               $service_name,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $mysql_db_schema,
) {
}

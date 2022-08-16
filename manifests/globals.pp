# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
# @param package_name
#
# @param service_name
#
# @param user
#
# @param group
#
# @param conf_dir
#
# @param mysql_db_schema
#
# @param mysql_db_schema
#
class icingadb::globals(
  String               $package_name,
  String               $service_name,
  String               $user,
  String               $group,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $mysql_db_schema,
  Stdlib::Absolutepath $pgsql_db_schema,
) {
}

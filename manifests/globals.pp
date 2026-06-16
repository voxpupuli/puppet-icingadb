# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
# @param package_name
#  The name of the icingadb package to manage.
#
# @param selinux_package_name
#   The name of the icingadb selinux package.
#
# @param service_name
#   The name of the icingadb service to manage.
#
# @param user
#   User as the icingadb process runs.
#   CAUTION: This does not manage the user context for the runnig icingadb process!
#   The parameter is only used for ownership of files or directories.
#
# @param group
#   Group as the icingadb process runs.
#   CAUTION: This does not manage the group context for the runnig icingadb process!
#   The parameter is only used for group membership of files or directories.
#
# @param conf_dir
#   Location of the configuration directory of IcingaDB.
#
# @param mysql_db_schema
#   Location of the MySQL database schema for IcingaDB.
#
# @param pgsql_db_schema
#   Location of the PostgreSQL database schema for IcingaDB.
#
class icingadb::globals (
  String[1]            $package_name,
  String[1]            $selinux_package_name,
  String[1]            $service_name,
  String[1]            $user,
  String[1]            $group,
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $mysql_db_schema,
  Stdlib::Absolutepath $pgsql_db_schema,
) {
  $stdlib_version = load_module_metadata('stdlib')['version']
}

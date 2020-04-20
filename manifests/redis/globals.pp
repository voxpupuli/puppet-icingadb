# @summary
#   This class loads the default parameters by doing a hiera lookup.
#
# @api private
#
class icingadb::redis::globals(
  String               $package_name,
  String               $service_name,
  Stdlib::Absolutepath $service_unit_file,
) {
}

# @summary
#   Installs IcingaDB Redis server
#
# @api private
#
class icingadb::redis::install {
  assert_private()

  contain icinga::redis

  $package_name    = $icingadb::redis::globals::package_name
  $manage_packages = $icingadb::redis::manage_packages

  if $manage_packages {
    package { $package_name:
      ensure => installed,
    }
  }
}

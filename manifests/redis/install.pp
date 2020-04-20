# @summary
#   Installs IcingaDB Redis server
#
# @api private
#
class icingadb::redis::install {

  contain ::icinga::redis

  $package_name   = $::icingadb::redis::globals::package_name
  $manage_package = $::icingadb::redis::manage_package

  if $manage_package {
    contain ::icinga::redis

    package { $package_name:
      ensure => installed,
    }
  }

}

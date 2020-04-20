# @summary
#   Installs IcingaDB Redis server
#
# @api private
#
class icingadb::redis::install {

  $package_name   = $::icingadb::redis::globals::package_name
  $manage_package = $::icingadb::redis::manage_package

  contain icinga::redis

  if $manage_package {
    contain ::icinga::redis

    package { $package_name:
      ensure => installed,
    }
  }

}

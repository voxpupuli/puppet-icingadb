# @summary 
#   Manage IcingaDB Redis server service
#
# @api private
#   
class icingadb::redis::service {

  $service_name = $::icingadb::redis::globals::service_name
  $ensure       = $::icingadb::redis::ensure
  $enable       = $::icingadb::redis::enable

  service { $service_name:
    ensure => $ensure,
    enable => $enable,
  }

}

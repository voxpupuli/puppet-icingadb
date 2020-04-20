# @summary
#   Installs IcingaDB
# @api private
#
class icingadb::install {

  assert_private()

  $package_name     = $icingadb::globals::package_name
  $manage_package   = $icingadb::manage_package
  $import_db_schema = $icingadb::import_db_schema
  $db_type          = $icingadb::db_type

  if $manage_package {
    package { $package_name:
      ensure => installed,
    }
  }

  if $import_db_schema {
    if $db_type == 'pgsql' {
      contain ::icingadb::install::pgsql
    } else {
      contain ::icingadb::install::mysql
    }
  }

}

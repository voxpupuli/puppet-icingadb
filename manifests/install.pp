# @summary
#   Installs IcingaDB
#
# @api private
#
class icingadb::install {
  assert_private()

  $package_name         = $icingadb::globals::package_name
  $manage_packages      = $icingadb::manage_packages
  $selinux_package_name = $icingadb::globals::selinux_package_name
  $manage_selinux       = $icingadb::_selinux

  if $manage_packages {
    package { $package_name:
      ensure => installed,
    }

    if $manage_selinux {
      package { $selinux_package_name:
        ensure  => installed,
        require => Package[$package_name],
      }
    }
  }
}

# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'redis' do
  password = ENV.fetch('ICINGA_REPO_PASSWORD', nil)
  user = ENV.fetch('ICINGA_REPO_USER', nil)
  # TODO: the secrets are only required for EL tests, so we can limit the scope further down
  it 'works idempotently with no errors', if: password && user do
    pp = <<~MANIFEST
      if $facts['os']['family'] == 'RedHat' and $facts['os']['name'] != 'Fedora' {
        yumrepo { 'icinga-stable-release':
          descr    => 'ICINGA (stable release for epel)',
          baseurl  => 'https://packages.icinga.com/subscription/rhel/$releasever/release/',
          enabled  => 1,
          gpgcheck => 1,
          gpgkey   => 'https://packages.icinga.com/icinga.key',
          username => "#{user}",
          password => "#{password}",
          before   => Class['icingadb::redis'],
        }
        $manage_repos = false
      } else {
        $manage_repos = true
      }
      class { 'icingadb::redis':
        manage_repos => $manage_repos,
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end

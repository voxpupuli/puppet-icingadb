# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'redis' do
  it 'works idempotently with no errors' do
    pp = <<~MANIFEST
      # Has to be an EL distribution and both, user and password have to be set!
      if fact('os.family') == 'RedHat' and fact('os.name') != 'Fedora' and (!fact('icinga_repo_user') or !fact('icinga_repo_password')) {
        fail('Enterprise Linux distributions require to set ICINGA_REPO_USER and ICINGA_REPO_PASSWORD for access to the Icinga Subscription repository!')
      }

      class { 'icingadb::redis':
        manage_repos => true,
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end

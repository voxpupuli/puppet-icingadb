# frozen_string_literal: true

require 'spec_helper_acceptance'

skip = if (fact('os.family') == 'RedHat') && (fact('os.name') != 'Fedora') && !ENV.fetch('ICINGA_REPO_USER', nil).nil? && !ENV.fetch('ICINGA_REPO_PASSWORD', nil).nil?
         puts 'Skipping acceptance test on RedHat-like systems, because environment variables ICINGA_REPO_USER and ICINGA_REPO_PASSWORD are missing'
         true
       else
         false
       end
describe 'redis', skip: skip do
  it 'works idempotently with no errors' do
    pp = <<~MANIFEST
      class { 'icingadb::redis':
        manage_repos => true,
      }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end
end

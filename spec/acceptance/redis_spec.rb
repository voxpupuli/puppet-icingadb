# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'redis' do
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

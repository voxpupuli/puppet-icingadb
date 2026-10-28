# frozen_string_literal: true

require 'spec_helper_acceptance'

# packages.icinga.com only serves RHEL-family packages to subscribers
describe 'icingadb', if: fact('os.family') == 'Debian' do
  # The database is set up with puppetlabs/postgresql, which isn't a module dependency
  before(:all) { install_puppet_module_via_pmt_on(hosts, 'puppetlabs-postgresql') }

  it_behaves_like 'an idempotent resource' do
    let(:manifest) do
      <<~PUPPET
        class { 'icinga::repos':
          manage_stable => true,
        }

        class { 'postgresql::server':
          password_encryption => 'scram-sha-256',
        }
        class { 'icinga::db::database':
          db_type          => 'pgsql',
          db_pass          => Sensitive('supersecret'),
          access_instances => ['127.0.0.1', '::1'],
        }

        -> class { 'icingadb::redis':
          manage_repos => true,
          requirepass  => Sensitive('supersecret'),
        }

        -> class { 'icingadb':
          manage_repos   => true,
          db_type        => 'pgsql',
          db_password    => Sensitive('supersecret'),
          redis_password => Sensitive('supersecret'),
          import_schema  => true,
        }
      PUPPET
    end
  end

  %w[icingadb-redis icingadb].each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end

    describe service(pkg) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end

  describe port(6380) do
    it { is_expected.to be_listening }
  end

  describe file('/etc/icingadb/config.yml') do
    its(:content) { is_expected.to match %r{type: pgsql} }
    its(:content) { is_expected.to match %r{port: 6380} }
  end

  describe command("su - postgres -c \"psql -d icingadb -tAc 'SELECT count(*) FROM icingadb_schema'\"") do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to match %r{^[1-9]} }
  end
end

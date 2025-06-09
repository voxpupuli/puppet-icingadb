# frozen_string_literal: true

require 'spec_helper_acceptance'

skip = if fact('os.family') == 'RedHat' && fact('os.name') != 'Fedora' && (!fact('icinga_repo_user') || !fact('icinga_repo_password'))
         puts 'Skipping acceptance test on RedHat-like systems, because environment variables ICINGA_REPO_USER and ICINGA_REPO_PASSWORD are missing'
         true
       else
         false
       end

describe 'works with Redis and PostgreSQL backend', skip: skip do
  it_behaves_like 'the example', 'init_pgsql.pp'

  describe service('icingadb-redis') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(6380) do
    it { should be_listening }
  end

  describe service('icingadb') do
    it { should be_enabled }
    it { should be_running }
  end
end

describe 'works with Redis and MariaDB backend', skip: skip do
  it_behaves_like 'the example', 'init_mysql.pp'

  describe service('icingadb-redis') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(6380) do
    it { should be_listening }
  end

  describe service('icingadb') do
    it { should be_enabled }
    it { should be_running }
  end
end

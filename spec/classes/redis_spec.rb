# frozen_string_literal: true

require 'spec_helper'

describe 'icingadb::redis' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        it { should_not contain_class('icinga::repos') }
        it { should contain_class('icinga::redis') }
        it { should contain_package('icingadb-redis') }
        it { should contain_redis__instance('icingadb-redis').with('manage_service_file' => false) }
        it { should contain_file('/usr/lib/systemd/system/icingadb-redis.service').with('owner' => 'root', 'group' => 'root', 'mode' => '0644') }
        it { should contain_file('/usr/lib/systemd/system/icingadb-redis.service').with_content(/User=icinga-redis/) }
        it { should contain_file('/usr/lib/systemd/system/icingadb-redis.service').with_content(/Group=icinga-redis/) }
        it { should contain_file('/usr/lib/systemd/system/icingadb-redis.service').that_notifies('Exec[systemd-reload-redis]') }
        it { should contain_service('icingadb-redis').with('ensure' => 'running', 'enable' => true) }
      end

      context 'with ensure => stopped, enable => false, manage_repo => true, manage_package => false' do
        let(:params) { {:ensure => 'stopped', :enable => false, :manage_repo => true, :manage_package => false} }

        it { should contain_class('icinga::repos') }
        it { should_not contain_package('icingadb-redis') }
        it { should contain_service('icingadb-redis').with('ensure' => 'stopped', 'enable' => false) }
      end

    end
  end
end

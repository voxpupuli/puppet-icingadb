# frozen_string_literal: true

require 'spec_helper'

describe 'icingadb::redis' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        it { is_expected.not_to contain_class('icinga::repos') }
        it { is_expected.to contain_class('icinga::redis') }
        it { is_expected.to contain_package('icingadb-redis') }
        it { is_expected.to contain_redis__instance('icingadb-redis').with('manage_service_file' => false) }
        it { is_expected.to contain_service('icingadb-redis').with('ensure' => 'running', 'enable' => true) }
      end

      context 'with SELinux enabled and TLS' do
        let(:facts) do
          os_facts.merge(os: os_facts[:os].merge(selinux: { enabled: true }))
        end

        let(:params) do
          {
            manage_selinux: true,
            port: 6380,
            use_tls: true,
            tls_port: 6381,
            tls_key: 'redis-key',
            tls_cert: 'redis-cert',
            tls_cacert: 'redis-ca',
          }
        end

        it {
          is_expected.to contain_selinux__port('icingadb-redis-tcp-6380').with(
            'seltype' => 'redis_port_t',
            'protocol' => 'tcp',
            'port' => 6380,
          )
        }

        it {
          is_expected.to contain_selinux__port('icingadb-redis-tcp-6381').with(
            'seltype' => 'redis_port_t',
            'protocol' => 'tcp',
            'port' => 6381,
          )
        }

        it {
          is_expected.to contain_icinga__cert('icingadb-redis tls files for the database client connect')
            .with_seltype('redis_conf_t')
        }
      end

      context 'with ensure => stopped, enable => false, manage_repo => true, manage_package => false' do
        let(:params) do
          {
            ensure: 'stopped',
            enable: false,
            manage_repos: true,
            manage_packages: false,
          }
        end

        it { is_expected.to contain_class('icinga::repos') }
        it { is_expected.not_to contain_package('icingadb-redis') }
        it { is_expected.to contain_service('icingadb-redis').with('ensure' => 'stopped', 'enable' => false) }
      end
    end
  end
end

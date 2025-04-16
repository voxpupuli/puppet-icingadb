# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

ENV['BEAKER_FACTER_ICINGA_REPO_USER'] = ENV.fetch('ICINGA_REPO_USER', nil)
ENV['BEAKER_FACTER_ICINGA_REPO_PASSWORD'] = ENV.fetch('ICINGA_REPO_PASSWORD', nil)

configure_beaker do |host|
  install_puppet_module_via_pmt_on(host, 'puppetlabs-mysql')
  install_puppet_module_via_pmt_on(host, 'puppetlabs-postgresql')
end

Dir['./spec/support/acceptance/**/*.rb'].sort.each { |f| require f }

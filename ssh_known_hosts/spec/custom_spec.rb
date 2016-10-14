require 'spec_helper'

describe 'ssh_known_hosts_test::custom' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
  end

  it { expect(chef_run).to append_to_ssh_known_hosts 'github.com' }
end

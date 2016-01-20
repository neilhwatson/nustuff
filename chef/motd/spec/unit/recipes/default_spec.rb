#
# Cookbook Name:: motd
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'motd::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'promise motd' do
       expect(chef_run).to create_file('/etc/motd').with(
          user: 'root',
          group: 'root',
          mode: 644
       )
       
       expect(chef_run).to render_file('/etc/motd').with_content(
          /Neil H. Watson/
       )
    end

    
  end
end

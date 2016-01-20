#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
file '/etc/motd' do
   content node['motd']['sysadmin']
   mode '644'
   owner 'root'
   group 'root'
end


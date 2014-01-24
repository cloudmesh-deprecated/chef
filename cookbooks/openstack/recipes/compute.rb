# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2
#
# Cookbook Name:: openstack
# Recipe:: controller
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

password = node['openstack']['password']
admin_password = node['openstack']['admin_password']
service_password = node['openstack']['service_password']
mysql_admin_password = node['openstack']['mysql_admin_password']
mysql_password = node['openstack']['mysql_password']
rabbit_password = node['openstack']['rabbit_password']
controller_public_address = node['openstack']['controller_public_address']
controller_admin_address = node['openstack']['controller_admin_address']
controller_internal_address = node['openstack']['controller_internal_address']
fixed_range = node['openstack']['fixed_range']
mysql_access = node['openstack']['mysql_access']
public_interface = node['openstack']['public_interface']
internal_interface = node['openstack']['internal_interface']

package "ubuntu-cloud-keyring" do
  action :install
end

cookbook_file "/etc/apt/sources.list.d/havana.list" do
  source "havana.list"
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
end

execute "apt-get-update" do
  command "apt-get update && touch /tmp/apt-get-update"
  not_if { ::File.exists?("/tmp/apt-get-update")}
end

execute "apt-get-upgrade" do
  command "DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" dist-upgrade && touch /tmp/apt-get-upgrade"
  not_if { ::File.exists?("/tmp/apt-get-upgrade")}
end

script "set-mysql-admin-password" do
  interpreter "bash"
  user "root"
  code <<-EOH
  echo mysql-server mysql-server/root_password password #{mysql_admin_password} | debconf-set-selections
  echo mysql-server mysql-server/root_password_again password #{mysql_admin_password} | debconf-set-selections
  touch /tmp/set-mysql-admin-password
  EOH
  not_if { ::File.exists?("/tmp/set-mysql-admin-password")}
end

packages = %w[ntp
              python-mysqldb
              python-memcache
              open-iscsi
              open-iscsi-utils
              bridge-utils
              python-libvirt
              python-cinderclient
              nova-api
              nova-compute
              nova-compute-kvm
              nova-network
              python-keystoneclient
              ]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

script "delete-default-vnet" do
  interpreter "bash"
  user "root"
  code <<-EOH
  virsh net-autostart default --disable
  virsh net-destroy default
  touch /tmp/delete-default-vnet
  EOH
  not_if { ::File.exists?("/tmp/delete-default-vnet")}
end

template "/etc/nova/nova.conf" do
  source "nova.conf.erb"
  mode 0644
  owner "nova"
  group "nova"
  action :create
  variables(
    :public_interface => public_interface,
    :internal_interface => internal_interface,
    :fixed_range => fixed_range,
    :controller_public_address => controller_public_address,
    :controller_internal_address => controller_internal_address,
    :rabbit_password => rabbit_password,
    :mysql_password => mysql_password
  )
end

cookbook_file "/etc/sysctl.conf" do
  source "sysctl.conf"
  mode 0644
  owner "root"
  group "root"
  action :create
end

directory "/root/bin" do
  owner "root"
  group "root"
  mode 0700
  action :create
end

cookbook_file "/root/bin/compute.sh" do
  source "compute.sh"
  owner "root"
  group "root"
  mode 0700
  action :create
end

template "/etc/nova/api-paste.ini" do
  source "nova_api-paste.ini.erb"
  owner "nova"
  group "nova"
  mode 0640
  action :create
  variables(
    :service_password => service_password,
    :controller_admin_address => controller_admin_address
  )
end


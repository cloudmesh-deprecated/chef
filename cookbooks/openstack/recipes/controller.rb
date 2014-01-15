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
controller_iternal_address = node['openstack']['controller_internal_address']
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
  command "apt-get update && apt-get -y dist-upgrade"
  ignore_failure true
  action :run
end

packages = %w[ntp
              python-mysqldb
              python-memcache
              rabbitmq-server
              mysql-server
              memcached
              open-iscsi-utils
              bridge-utils
              keystone
              glance
              cinder-api
              cinder-scheduler
              nova-api
              nova-cert
              nova-objectstore
              nova-network
              nova-scheduler
              nova-conductor
              nova-doc
              nova-console
              nova-consoleauth
              nova-novncproxy
              novnc
              openstack-dashboard]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

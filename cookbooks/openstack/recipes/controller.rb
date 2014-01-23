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
              nova-compute
              nova-compute-kvm
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

package "openstack-dashboard-ubuntu-theme" do
  action :purge
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

template "/etc/memcached.conf" do
  source "memcached.conf.erb"
  mode 0644
  owner "root"
  group "root"
  action :create
  variables(
    :controller_admin_address => controller_admin_address
  )
end

execute "restart-memcached" do
  command "service memcached restart && touch /tmp/restart-memcached"
  not_if { ::File.exists?("/tmp/restart-memcached")}
end

script "do-rabbitmqctl" do
  interpreter "bash"
  user "root"
  code <<-EOH
  rabbitmqctl add_vhost /nova
  rabbitmqctl add_user nova #{rabbit_password}
  rabbitmqctl set_permissions -p /nova nova ".*" ".*" ".*"
  rabbitmqctl delete_user guest
  touch /tmp/do-rabbitmqctl
  EOH
  not_if { ::File.exists?("/tmp/do-rabbitmqctl")}
end

cookbook_file "/etc/mysql/my.cnf" do
  source "my.cnf"
  mode 0644
  owner "root"
  group "root"
  action :create
end

execute "restart-mysql" do
  command "service mysql restart && touch /tmp/restart-mysql"
  not_if { ::File.exists?("/tmp/restart-mysql")}
end

template "/root/mysql_db_setting.txt" do
  source "mysql_db_setting.txt.erb"
  mode 0600
  owner "root"
  group "root"
  action :create
  variables(
    :controller_admin_address => controller_admin_address,
    :mysql_password => mysql_password,
    :mysql_access => mysql_access
  )
end

script "mysql-db-setting" do
  interpreter "bash"
  user "root"
  code <<-EOH
  mysql -uroot -p#{mysql_admin_password} < /root/mysql_db_setting.txt
  touch /tmp/mysql-db-setting
  EOH
  not_if { ::File.exists?("/tmp/mysql-db-setting")}
end

directory "/root/bin" do
  owner "root"
  group "root"
  mode 0700
  action :create
end

cookbook_file "/root/bin/openstack.sh" do
  source "openstack.sh"
  owner "root"
  group "root"
  mode 0700
  action :create
end

template "/etc/keystone/keystone.conf" do
  source "keystone.conf.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
  variables(
    :admin_password => admin_password,
    :mysql_password => mysql_password,
    :controller_internal_address => controller_internal_address
  )
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

template "/etc/glance/glance-api.conf" do
  source "glance-api.conf.erb"
  owner "glance"
  group "glance"
  mode 0644
  action :create
  variables(
    :controller_admin_address => controller_admin_address,
    :controller_internal_address => controller_internal_address,
    :controller_public_address => controller_public_address,
    :service_password => service_password,
    :mysql_password => mysql_password,
    :rabbit_password => rabbit_password
  )
end

template "/etc/glance/glance-registry.conf" do
  source "glance-registry.conf.erb"
  owner "glance"
  group "glance"
  mode 0644
  action :create
  variables(
    :controller_admin_address => controller_admin_address,
    :controller_internal_address => controller_internal_address,
    :service_password => service_password,
    :mysql_password => mysql_password
  )
end

template "/etc/cinder/cinder.conf" do
  source "cinder.conf.erb"
  owner "cinder"
  group "cinder"
  mode 0644
  action :create
  variables(
    :controller_internal_address => controller_internal_address,
    :rabbit_password => rabbit_password,
    :mysql_password => mysql_password
  )
end

template "/etc/cinder/api-paste.ini" do
  source "cinder_api-paste.ini.erb"
  owner "cinder"
  group "cinder"
  mode 0640
  action :create
  variables(
    :service_password => service_password,
    :controller_admin_address => controller_admin_address
  )
end

script "do-db-sync" do
  interpreter "bash"
  user "root"
  code <<-EOH
  keystone-manage db_sync
  glance-manage db_sync
  nova-manage db sync
  cinder-manage db sync
  touch /tmp/do-db-sync
  EOH
  not_if { ::File.exists?("/tmp/do-db-sync")}
end

script "restart-keystone" do
  interpreter "bash"
  user "root"
  code <<-EOH
  restart keystone
  sleep 5
  status keystone
  touch /tmp/restart-keystone
  EOH
  not_if { ::File.exists?("/tmp/restart-keystone")}
end

template "/root/bin/sample_data.sh" do
  source "sample_data.sh.erb"
  owner "root"
  group "root"
  mode 0700
  action :create
  variables(
    :admin_password => admin_password,
    :service_password => service_password,
    :controller_admin_address => controller_admin_address,
    :controller_internal_address => controller_internal_address,
    :controller_public_address => controller_public_address
  )
end

execute "set-keystone-data" do
  command "/root/bin/sample_data.sh && touch /tmp/set-keystone-data"
  not_if { ::File.exists?("/tmp/set-keystone-data")}
end



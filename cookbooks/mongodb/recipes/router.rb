#
# Cookbook Name:: mongodb
# Recipe:: router
#
# Copyright 2015, Jonathan Klinginsmith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "mongodb::repo"

mongodb_config_server_port = node["mongodb"]["config_server_port"]
mongodb_config_servers = node["mongodb"]["config_servers"].map{ |config_server| "#{config_server}:#{mongodb_config_server_port}"}.join(",")
mongodb_log_dir = node["mongodb"]["log_dir"]
mongodb_run_dir = node["mongodb"]["run_dir"]

package "mongodb-org-mongos" do
  action :install
end

group "mongos" do
  gid "1002"
  action :create
end

user "mongos" do
  uid "1003"
  gid "mongos"
  shell "/bin/bash"
  system true
  action :create
end

directories = [mongodb_log_dir, mongodb_run_dir]
directories.each do |dir|
  directory dir do
    mode "0755"
    user "mongos"
    group "mongos"
    action :create
    recursive true
  end
end

template "/etc/mongos.conf" do
  source "mongos.conf.erb"
  mode "0644"
  user "root"
  group "root"
  variables(
    :log_dir => mongodb_log_dir,
    :run_dir => mongodb_run_dir,
    :config_servers => mongodb_config_servers
  )
end

template "/etc/init.d/mongos" do
  source "mongos.erb"
  mode "0755"
  user "root"
  group "root"
end

#service "mongos" do
#  action [:enable, :start]
#end

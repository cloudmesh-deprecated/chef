#
# Cookbook Name:: cassandra
# Recipe:: default
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

broadcast_rpc_address = node["cassandra"]["broadcast_rpc_address"]
cluster_name = node["cassandra"]["cluster_name"]
conf_dir = node["cassandra"]["conf_dir"]
listen_address = node["cassandra"]["listen_address"]
rmi_server_hostname = node["cassandra"]["rmi_server_hostname"]
rpc_address = node["cassandra"]["rpc_address"]
seeds = node["cassandra"]["seeds"]


jdk_packages = %w[java-1.8.0-openjdk java-1.8.0-openjdk-devel]
jdk_packages.each do |jdk_package|
  package "#{jdk_package}" do
    action :install
  end
end

cookbook_file "datastax.repo" do
  path "/etc/yum.repos.d/datastax.repo"
  mode "0644"
end

package "dsc21" do
  action :install
end

template "#{File.join(conf_dir, "cassandra.yaml")}" do
  source "cassandra.yaml.erb"
  mode "0644"
  variables(
    :cluster_name => cluster_name,
    :seeds => seeds,
    :listen_address => listen_address,
    :rpc_address => rpc_address,
    :broadcast_rpc_address => broadcast_rpc_address
  )
end

template "#{File.join(conf_dir, "cassandra-env.sh")}" do
  source "cassandra-env.sh.erb"
  mode "0644"
  variables(
    :rmi_server_hostname => rmi_server_hostname
  )
end

service "cassandra" do
  action [ :enable, :start ]
end

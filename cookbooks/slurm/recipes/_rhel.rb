#
# Cookbook Name:: slurm
# Recipe:: _rhel
#
# Copyright 2014, Jonathan Klinginsmith
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

slurm_hash = node["slurm"]

slurm_sysconfdir = slurm_hash.fetch("sysconfdir", "/etc/slurm")

slurm_user = slurm_hash["user"]
slurm_uid = slurm_hash["uid"]
slurm_group = slurm_hash["group"]
slurm_gid = slurm_hash["gid"]

slurm_node_list = slurm_hash["node_list"]

slurm_role = slurm_hash.fetch("role", "")
slurm_control_machine = slurm_hash.fetch("control_machine", "")
slurm_control_addr = slurm_hash.fetch("control_addr", "")

# If the control_machine attribute was not specificed then use
# Chef's searching capability.
if slurm_control_machine.to_s.empty?
  # A cluster name must be specified.
  # A machine containing the condor role "headnode" must be specified within the same cluster.
  slurm_cluster_name = slurm_hash.fetch("cluster_name", "")
  slurm_control_machine_data = search("node", "slurm_role:headnode AND slurm_cluster_name:#{slurm_cluster_name}").first
 
  slurm_control_machine = slurm_control_machine_data["hostname"]
  slurm_control_addr = slurm_control_machine_data["ipaddress"]
end

slurm_baseurl = slurm_hash["baseurl"]

# Create yum repo file.
template "/etc/yum.repos.d/slurm.repo" do
  source "slurm.repo.erb"
  mode "0644"
  variables(
    :baseurl => slurm_baseurl
  )
end

packages = %w[slurm slurm-munge]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

# TODO: Determine how we want to create the munge.key file.
cookbook_file "/etc/munge/munge.key" do
  source "munge.key"
  mode "0400"
  owner "munge"
  group "munge"
end

# TODO: Determine how we want to populate NodeName values.
# Create the slurm.conf file.
template "#{File.join(slurm_sysconfdir, "slurm.conf")}" do
  source "slurm.conf.erb"
  mode "0644"
  variables(
    :control_machine => slurm_control_machine,
    :control_addr => slurm_control_addr,
    :node_list => slurm_node_list )
end

# Create the slurm group and user.
group "#{slurm_group}" do
  gid "#{slurm_gid}"
end

user "#{slurm_user}" do
  uid "#{slurm_uid}"
  gid "#{slurm_group}"
end

# Create the log directory. This is found in the slurm.conf file.
directory "/var/log/slurm" do
  owner "#{slurm_user}"
  group "#{slurm_group}"
  mode 00755
  action :create
end

services = %w[munge slurm]
services.each do |service|
  service "#{service}" do
    action [ :enable, :start ]
  end
end

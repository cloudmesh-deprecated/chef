#
# Cookbook Name:: condor
# Recipe:: default
#
# Copyright 2012, Jonathan Klinginsmith
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

cookbook_file "/etc/yum.repos.d/condor-stable-rhel5.repo" do
  source "condor-stable-rhel5.repo"
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
end

# TODO: Revisit why the package resource isn't working.
#       Use the execute resource to do a yum install.
#package "condor" do
#  action :install
#end
execute "install condor" do
  command "yum -y -d0 -e0 install condor"
end

# Retrieve the condor hash; otherwise, create an empty one.
condor_hash = node[:condor]

# Retrieve the mode (local|cluster).
# If it not specified then assume it is "cluster".
pool_mode = condor_hash.has_key?(:mode) ? condor_hash[:mode] : "cluster"

if "local".eql?(pool_mode)
  central_manager = node[:hostname]
  # Because of local mode, this machine will exibit all roles.
  condor_roles = ["centralmanager", "execute", "submit"]

else
  # See if the central manager was specified.
  central_manager = condor_hash.has_key?(:central_manager) ? condor_hash[:central_manager] : ""
  condor_roles = condor_hash[:roles]

  # If the central manager was not specified then use Chef's searching capabilities.
  if central_manager.to_s.empty?
    # A pool name must be specified.
    # A machine containing the condor role "centralmanager" must be specified within the same pool.
    # Use the name attribute of the machine found in the search.

    pool_name = condor_hash[:name]
    central_manager_data = search(:node, "condor_roles:centralmanager AND condor_name:#{pool_name}").first
    central_manager = central_manager_data.name
  end
end

log("Condor mode: #{pool_mode}") { level :debug }
log("Condor roles: #{condor_roles.join(', ')}") { level :debug }
log("Central manager: #{central_manager}") { level :debug }

# Build the daemon list based on the role(s) for this server.
daemons = []

# Iterate through each role to capture the daemons to run.
condor_roles.each do |role|
  if "centralmanager".eql?(role)
    daemons += ["COLLECTOR", "MASTER", "NEGOTIATOR"]
  elsif "execute".eql?(role)
    daemons += ["MASTER", "STARTD"]
  elsif "submit".eql?(role)
    daemons += ["MASTER", "SCHEDD"]
  end
end

# Get the unique daemons and build a comma-separated list.
unique_daemons = daemons.uniq.sort!
daemon_list = unique_daemons.join(", ")
log("Daemon list: #{daemon_list}") { level :debug }

cloud_provider = node[:cloud][:provider]
# TODO: Come back and determine how to secure the allow_write host list.
allow_write = "ec2".eql?( cloud_provider ) ? "$(FULL_HOSTNAME), $(IP_ADDRESS), *.compute-1.amazonaws.com, *.internal" : "10.*"
filesystem_domain = "ec2".eql?( cloud_provider ) ? "ec2.internal" : "euca.internal"

# TODO: Come back to nova
#allow_write = "10.*"
#filesystem_domain = "localhost"

# Create the condor_config file.
template "/etc/condor/condor_config" do
  source "condor_config.erb"
  mode "0644"
  variables(
    :master_update_interval => 60,
    :allow_write => allow_write,
    :filesystem_domain => filesystem_domain)
end

# Create the condor_config.local file.
template "/etc/condor/condor_config.local" do
  source "condor_config.local.erb"
  mode "0644"
  variables(
    :condor_host => central_manager,
    :daemon_list => daemon_list)
end

# Enable and start the condor service.
service "condor" do
  action [ :enable, :start ]
end

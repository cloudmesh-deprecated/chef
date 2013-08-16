#
# Cookbook Name:: pegasus
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

# TODO: officially address pre-reqs
# Java 1.6 or higher.
# $ java -version
# Python 2.4 or higher.
# # python -v

# Grab the version from the configured attributes.
pegasus_version = node[:pegasus][:version]
pegasus_home = "/opt/pegasus/default"
pegasus_version_home = "/opt/pegasus/#{pegasus_version}"
pegasus_name = "pegasus"

# Set up the Pegasus repo.
cookbook_file "/etc/yum.repos.d/pegasus.repo" do
  source "pegasus.repo"
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
end

execute "update yum" do
  command "yum update -y yum"
end

# Install the pegasus package.
package "pegasus-#{pegasus_version}" do
  action :install
end

# Set up the alternatives so that this version is recognized by #{pegasus_home}.
script "set alternatives" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOL
  alternatives --install #{pegasus_home} #{pegasus_name} #{pegasus_version_home} 50
  alternatives --set #{pegasus_name} #{pegasus_version_home}
  EOL
end

# Create an entry so Pegasus shows up in the user's path.
cookbook_file "/etc/profile.d/pegasus.sh" do
  source "pegasus.sh"
  mode "0755"
  owner "root"
  group "root"
  action :create_if_missing
end

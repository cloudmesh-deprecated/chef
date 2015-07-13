#
# Cookbook Name:: postgresql
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

postgres_download_url = node["postgres"]["download_url"]
postgres_rpm_path = File.join(Chef::Config[:file_cache_path], File.basename(postgres_download_url))
postgres_checksum = node["postgres"]["checksum"]
postgres_server_rpm = node["postgres"]["server_rpm"]
postgres_version = node["postgres"]["version"]

remote_file "#{postgres_rpm_path}" do
  source "#{postgres_download_url}"
  mode "0755"
  checksum "#{postgres_checksum}"
end

package "#{File.basename(postgres_rpm_path, ".rpm")}" do
  action :install
  source "#{postgres_rpm_path}"
  provider Chef::Provider::Package::Rpm
end

package_prefix = postgres_version.gsub(".", "")
packages = ["postgresql#{package_prefix}-server", "postgresql#{package_prefix}-devel"]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

execute "init db" do
  command "/usr/pgsql-#{postgres_version}/bin/postgresql#{postgres_version.gsub(".", "")}-setup initdb"
  not_if { ::File.exists?("/var/lib/pgsql/#{postgres_version}/data/pg_hba.conf") }
end

service "postgresql-#{postgres_version}" do
  action [:enable, :start]
end

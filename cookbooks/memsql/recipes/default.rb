#
# Cookbook Name:: memsql
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

memsql_version = node['memsql']['version']
memsql_download_url = node['memsql']['download_url']
memsql_download_dir = node['memsql']['download_dir']
memsql_checksum = node['memsql']['checksum']

remote_file "#{memsql_download_dir}/memsql-ops-#{memsql_version}.tar.gz" do
  source memsql_download_url
  mode '0644'
  checksum memsql_checksum
end

execute 'untar memsql tarball' do
  command "tar -xzf memsql-ops-#{memsql_version}.tar.gz"
  cwd memsql_download_dir
  creates "#{memsql_download_dir}/memsql-ops-#{memsql_version}"
end

execute 'install memsql' do
  command './install.sh -n'
  cwd "#{memsql_download_dir}/memsql-ops-#{memsql_version}"
  creates "/usr/bin/memsql-ops"
end

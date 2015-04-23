#
# Cookbook Name:: serf
# Recipe:: default
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

serf_version = node["serf"]["version"]
serf_download_url = node["serf"]["download_url"]
serf_download_dir = Chef::Config["file_cache_path"]
serf_checksum = node["serf"]["checksum"]
serf_prefix = node["serf"]["prefix"]
serf_config_dir = node["serf"]["config_dir"]

package "unzip" do
  action :install
end

remote_file "#{File.join(serf_download_dir, "#{serf_version}_linux_amd64.zip")}" do
  source "#{serf_download_url}"
  mode "0644"
  checksum "#{serf_checksum}"
end

execute "unzip serf zip file" do
  command "unzip #{serf_version}_linux_amd64.zip"
  cwd "#{serf_download_dir}"
  creates "#{serf_download_dir}/serf"
end

execute "copy serf executable" do
  command "cp #{serf_download_dir}/serf #{serf_prefix}/bin/serf"
  cwd "#{serf_download_dir}"
  creates "#{serf_prefix}/bin/serf"
end
 
directories = [serf_config_dir]
directories.each do |directory|
  directory "#{directory}" do
    mode "0755"
    action :create
    recursive true
  end
end

# Create the systemd service file.
template "/etc/systemd/system/serf.service" do
  source "serf.service.erb"
  mode "0755"
  variables(
    :bin_dir => File.join(serf_prefix, "bin"),
    :config_dir => serf_config_dir
  )
end

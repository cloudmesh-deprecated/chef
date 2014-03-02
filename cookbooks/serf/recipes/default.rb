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
serf_download_dir = node["serf"]["download_dir"]
serf_checksum = node["serf"]["checksum"]
serf_prefix = node["serf"]["prefix"]

packages = %w[unzip]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{serf_download_dir}/#{serf_version}_linux_amd64.zip" do
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

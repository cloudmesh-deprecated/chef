#
# Cookbook Name:: hdf5
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

hdf5_version = node["hdf5"]["version"]
hdf5_download_url = node["hdf5"]["download_url"]
hdf5_download_dir = node["hdf5"]["download_dir"]
hdf5_checksum = node["hdf5"]["checksum"]
hdf5_prefix = node["hdf5"]["prefix"]

packages = %w[gcc gcc-c++ make]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{hdf5_download_dir}/hdf5-#{hdf5_version}.tar.bz2" do
  source "#{hdf5_download_url}"
  mode "0644"
  checksum "#{hdf5_checksum}"
end

execute "untar hdf5 tarball" do
  command "tar -xjf hdf5-#{hdf5_version}.tar.bz2"
  cwd "#{hdf5_download_dir}"
  creates "#{hdf5_download_dir}/hdf5-#{hdf5_version}"
end

script "install hdf5" do
  interpreter "bash"
  cwd "/tmp/hdf5-#{hdf5_version}"
  code <<-EOH
  ./configure --prefix=#{hdf5_prefix}
  make
  make install
  EOH
  creates "#{hdf5_prefix}/bin/h5cc"
end

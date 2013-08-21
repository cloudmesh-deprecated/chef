#
# Cookbook Name:: openmpi
# Recipe:: default
#
# Copyright 2013, Jonathan Klinginsmith
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

openmpi_version = node["openmpi"]["version"]
openmpi_download_url = node["openmpi"]["download_url"]
openmpi_download_dir = node["openmpi"]["download_dir"]
openmpi_checksum = node["openmpi"]["checksum"]
openmpi_prefix = node["openmpi"]["prefix"]

packages = %w[gcc gcc-c++ gcc-gfortran java-1.7.0-openjdk]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{openmpi_download_dir}/openmpi-#{openmpi_version}.tar.bz2" do
  source "#{openmpi_download_url}"
  mode "0644"
  checksum "#{openmpi_checksum}"
end

execute "untar openmpi tarball" do
  command "tar -xjf openmpi-#{openmpi_version}.tar.bz2"
  cwd "#{openmpi_download_dir}"
  creates "#{openmpi_download_dir}/openmpi-#{openmpi_version}"
end

script "install openmpi" do
  interpreter "bash"
  cwd "#{openmpi_download_dir}/openmpi-#{openmpi_version}"
  code <<-EOH
  ./configure --prefix=#{openmpi_prefix}
  make
  make install
  EOH
  creates "#{openmpi_prefix}/bin/mpicc"
end

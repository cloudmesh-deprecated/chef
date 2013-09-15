#
# Cookbook Name:: python
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

python_version = node["python"]["version"]
python_download_url = node["python"]["download_url"]
python_download_dir = node["python"]["download_dir"]
python_checksum = node["python"]["checksum"]
python_prefix = node["python"]["prefix"]

packages = %w[gcc gcc-c++ bzip2-devel db4-devel expat-devel gdbm-devel make ncurses-devel openssl-devel readline-devel sqlite-devel tk-devel zlib-devel]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{python_download_dir}/Python-#{python_version}.tar.bz2" do
  source "#{python_download_url}"
  mode "0644"
  checksum "#{python_checksum}"
end

execute "untar python tarball" do
  command "tar -xjf Python-#{python_version}.tar.bz2"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/Python-#{python_version}"
end

# Create the lib directory before running configure.
directory "#{python_prefix}/lib" do
  mode "0755"
  action :create
  recursive true
end

script "install python" do
  interpreter "bash"
  cwd "#{python_download_dir}/Python-#{python_version}"
  code <<-EOH
  ./configure --prefix=#{python_prefix} --enable-shared LDFLAGS="-Wl,-rpath #{python_prefix}/lib"
  make
  make install
  EOH
  creates "#{python_prefix}/bin/python"
end

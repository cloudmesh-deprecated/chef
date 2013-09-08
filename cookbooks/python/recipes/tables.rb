#
# Cookbook Name:: python
# Recipe:: tables
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

#include_recipe "python::numpy"
#include_recipe "python::numexpr"
#include_recipe "python::cython"

tables_version = node["python"]["tables_version"]
tables_download_url = node["python"]["tables_download_url"]
tables_checksum = node["python"]["tables_checksum"]

python_version = node["python"]["version"]
python_short_version = python_version[0,3]
python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]
python_lib_directory = `#{python_prefix}/bin/python -c "import distutils.sysconfig as d; print(d.get_python_lib())"`.chomp

remote_file "#{python_download_dir}/tables-#{tables_version}.tar.gz" do
  source "#{tables_download_url}"
  mode "0644"
  checksum "#{tables_checksum}"
end

execute "untar tables tarball" do
  command "tar -xzf tables-#{tables_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/tables-#{tables_version}"
  action :run
end

script "install tables" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/tables-#{tables_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "test -f #{python_lib_directory}/tables-#{tables_version}-py#{python_short_version}.egg-info"
end

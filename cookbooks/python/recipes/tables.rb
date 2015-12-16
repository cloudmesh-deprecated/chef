#
# Cookbook Name:: python
# Recipe:: tables
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

python_prefix = node['python']['prefix']

include_recipe 'python::pip'
include_recipe 'python::numpy'

pip_packages = %w(numexpr cython)
pip_packages.each do |pip_package|
  execute "install #{pip_package}" do
    command "#{python_prefix}/bin/pip install #{pip_package}"
    action :run
  end
end

tables_version = node['python']['tables_version']
tables_download_url = node['python']['tables_download_url']
tables_checksum = node['python']['tables_checksum']
tables_setup_options = node['python']['tables_setup_options']

python_prefix = node['python']['prefix']
python_download_dir = node['python']['download_dir']

remote_file "#{python_download_dir}/tables-#{tables_version}.tar.gz" do
  source tables_download_url
  mode '0644'
  checksum tables_checksum
end

execute 'untar tables tarball' do
  command "tar -xzf tables-#{tables_version}.tar.gz"
  cwd python_download_dir
  creates "#{python_download_dir}/tables-#{tables_version}"
  action :run
end

script 'install tables' do
  interpreter 'bash'
  user 'root'
  cwd "#{python_download_dir}/tables-#{tables_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py install #{tables_setup_options}
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; import tables; sys.exit( 0 if '#{tables_version}' == tables.__version__ else 1)\" 2> /dev/null"
end

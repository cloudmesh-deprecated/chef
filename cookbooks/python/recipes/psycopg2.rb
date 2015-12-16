#
# Cookbook Name:: python
# Recipe:: psycopg2
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

psycopg2_version = node['python']['psycopg2_version']
psycopg2_download_url = node['python']['psycopg2_download_url']
psycopg2_checksum = node['python']['psycopg2_checksum']

pgsql_bin_dir = node['python']['pgsql_bin_dir']

python_prefix = node['python']['prefix']
python_download_dir = node['python']['download_dir']

remote_file "#{python_download_dir}/psycopg2-#{psycopg2_version}.tar.gz" do
  source psycopg2_download_url
  mode '0644'
  checksum psycopg2_checksum
end

execute 'untar psycopg2 tarball' do
  command "tar -xzf psycopg2-#{psycopg2_version}.tar.gz"
  cwd python_download_dir
  creates "#{python_download_dir}/psycopg2-#{psycopg2_version}"
  action :run
end

script 'install psycopg2' do
  interpreter 'bash'
  user 'root'
  cwd "#{python_download_dir}/psycopg2-#{psycopg2_version}"
  code <<-EOF
  PATH=${PATH}:#{pgsql_bin_dir}
  export PATH
  #{python_prefix}/bin/python setup.py build
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; import psycopg2; sys.exit( 0 if '#{psycopg2_version}' == psycopg2.__version__ else 1)\" 2> /dev/null"
end

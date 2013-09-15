#
# Cookbook Name:: python
# Recipe:: cython
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

cython_version = node["python"]["cython_version"]
cython_download_url = node["python"]["cython_download_url"]
cython_checksum = node["python"]["cython_checksum"]

python_prefix = node["python"]["prefix"]
python_lib_directory = `#{node["python"]["prefix"]}/bin/python -c "import distutils.sysconfig as d; print(d.get_python_lib())"`.chomp
python_download_dir = node["python"]["download_dir"]

remote_file "/tmp/Cython-#{cython_version}.tar.gz" do
  source "#{cython_download_url}"
  mode "0644"
  checksum "#{cython_checksum}"
end

execute "untar cython tarball" do
  command "tar -xzf Cython-#{cython_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/Cython-#{cython_version}"
  action :run
end

script "install cython" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/Cython-#{cython_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "test -d #{python_lib_directory}/Cython"
end

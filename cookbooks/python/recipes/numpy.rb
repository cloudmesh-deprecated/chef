#
# Cookbook Name:: python
# Recipe:: numpy
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

numpy_version = node["python"]["numpy_version"]
numpy_download_url = node["python"]["numpy_download_url"]
numpy_checksum = node["python"]["numpy_checksum"]

python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]

packages = %w{atlas atlas-devel blas blas-devel lapack lapack-devel}
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{python_download_dir}/numpy-#{numpy_version}.tar.gz" do
  source "#{numpy_download_url}"
  mode "0644"
  checksum "#{numpy_checksum}"
end

execute "untar numpy tarball" do
  command "tar -xzf numpy-#{numpy_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/numpy-#{numpy_version}"
  action :run
end

script "install numpy" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/numpy-#{numpy_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py build --fcompiler=gnu95
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; import numpy; sys.exit( 0 if '#{numpy_version}' == numpy.__version__ else 1)\" 2> /dev/null"
end

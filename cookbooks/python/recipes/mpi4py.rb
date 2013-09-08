#
# Cookbook Name:: python
# Recipe:: mpi4py
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

mpi4py_version = node["python"]["mpi4py_version"]
mpi4py_download_url = node["python"]["mpi4py_download_url"]
mpi4py_checksum = node["python"]["mpi4py_checksum"]

python_prefix = node["python"]["prefix"]
python_lib_directory = `#{node["python"]["prefix"]}/bin/python -c "import distutils.sysconfig as d; print(d.get_python_lib())"`.chomp
python_download_dir = node["python"]["download_dir"]

packages = %w{atlas atlas-devel blas blas-devel lapack lapack-devel}
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{python_download_dir}/mpi4py-#{mpi4py_version}.tar.gz" do
  source "#{mpi4py_download_url}"
  mode "0644"
  checksum "#{mpi4py_checksum}"
end

execute "untar mpi4py tarball" do
  command "tar -xzf mpi4py-#{mpi4py_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/mpi4py-#{mpi4py_version}"
  action :run
end

script "install mpi4py" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/mpi4py-#{mpi4py_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py build
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "test -d #{python_lib_directory}/mpi4py"
end

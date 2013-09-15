#
# Cookbook Name:: python
# Recipe:: matplotlib
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

include_recipe "python::imaging"
include_recipe "python::numpy"

matplotlib_version = node["python"]["matplotlib_version"]
matplotlib_download_url = node["python"]["matplotlib_download_url"]
matplotlib_checksum = node["python"]["matplotlib_checksum"]

python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]

packages = %w{freetype freetype-devel libpng libpng-devel}
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{python_download_dir}/matplotlib-#{matplotlib_version}.tar.gz" do
  source "#{matplotlib_download_url}"
  mode "0644"
  checksum "#{matplotlib_checksum}"
end

execute "untar matplotlib tarball" do
  command "tar -xzf matplotlib-#{matplotlib_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/matplotlib-#{matplotlib_version}"
  action :run
end

script "install matplotlib" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/matplotlib-#{matplotlib_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py build
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; import matplotlib; sys.exit( 0 if '#{matplotlib_version}' == matplotlib.__version__ else 1)\" 2> /dev/null"
end

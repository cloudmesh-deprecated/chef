#
# Cookbook Name:: python
# Recipe:: pandas
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

python_prefix = node["python"]["prefix"]

include_recipe "python::pip"
include_recipe "python::numpy"
include_recipe "python::matplotlib"

packages = %w[libxml2 libxml2-devel libxslt libxslt-devel]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

pip_packages = %w[python-dateutil==1.5 pytz==2013d numexpr bottleneck openpyxl xlrd xlwt xlutils beautifulsoup4 html5lib lxml]
pip_packages.each do |pip_package|
  execute "install #{pip_package}" do
    command "#{python_prefix}/bin/pip install #{pip_package}"
    action :run
  end
end

pandas_version = node["python"]["pandas_version"]
pandas_download_url = node["python"]["pandas_download_url"]
pandas_checksum = node["python"]["pandas_checksum"]

python_version = node["python"]["version"]
python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]

remote_file "#{python_download_dir}/pandas-#{pandas_version}.tar.gz" do
  source "#{pandas_download_url}"
  mode "0644"
  checksum "#{pandas_checksum}"
end

execute "untar pandas tarball" do
  command "tar -xzf pandas-#{pandas_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/pandas-#{pandas_version}"
  action :run
end

script "install pandas" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/pandas-#{pandas_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py install 
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; import pandas; sys.exit( 0 if '#{pandas_version}' == pandas.__version__ else 1)\" 2> /dev/null"
end

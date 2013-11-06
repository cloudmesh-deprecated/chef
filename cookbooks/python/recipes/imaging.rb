#
# Cookbook Name:: python
# Recipe:: imaging
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

imaging_version = node["python"][:imaging_version]
imaging_download_url = node["python"][:imaging_download_url]
imaging_checksum = node["python"][:imaging_checksum]

python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]

packages = %w{freetype freetype-devel libjpeg libjpeg-devel libtiff libtiff-devel zlib zlib-devel}
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{python_download_dir}/Imaging-#{imaging_version}.tar.gz" do
  source "#{imaging_download_url}"
  mode "0644"
  checksum "#{imaging_checksum}"
end

execute "untar imaging tarball" do
  command "tar -xzf Imaging-#{imaging_version}.tar.gz"
  cwd "#{python_download_dir}"
  creates "#{python_download_dir}/Imaging-#{imaging_version}"
  action :run
end

# Update the setup.py *_ROOT locations to "/usr/lib64"
cookbook_file "#{python_download_dir}/Imaging-#{imaging_version}/setup.py" do
  source "imaging_setup.py"
  mode "0644"
end

script "install imaging" do
  interpreter "bash"
  user "root"
  cwd "#{python_download_dir}/Imaging-#{imaging_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py build
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "#{python_prefix}/bin/python -c \"import sys; from PIL import Image; sys.exit( 0 if '#{imaging_version}' == Image.VERSION else 1)\" 2> /dev/null"
end

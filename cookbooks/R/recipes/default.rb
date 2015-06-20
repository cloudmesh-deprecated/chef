#
# Cookbook Name:: R
# Recipe:: default
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

R_version = node["R"]["version"]
R_download_url = node["R"]["download_url"]
R_download_dir = node["R"]["download_dir"]
R_checksum = node["R"]["checksum"]
R_prefix = node["R"]["prefix"]
R_configure_options = node["R"]["configure_options"]

packages = %w[atlas atlas-devel blas blas-devel gcc gcc-c++ bzip2-devel db4-devel expat-devel gdbm-devel java-1.7.0-openjdk java-1.7.0-openjdk-devel lapack lapack-devel make ncurses-devel openssl-devel readline-devel sqlite-devel tk-devel zlib-devel]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{R_download_dir}/R-#{R_version}.tar.gz" do
  source "#{R_download_url}"
  mode "0644"
  checksum "#{R_checksum}"
end

execute "untar R tarball" do
  command "tar -xzf R-#{R_version}.tar.gz"
  cwd "#{R_download_dir}"
  creates "#{R_download_dir}/R-#{R_version}"
end

script "install R" do
  interpreter "bash"
  user "root"
  cwd "#{R_download_dir}/R-#{R_version}"
  code <<-EOF
  ./configure #{R_configure_options}
  make
  make install
  make install-libR
  EOF
  creates "#{R_prefix}/bin/R"
end

#
# Cookbook Name:: zeromq
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

zeromq_version = node['zeromq']['version']
zeromq_download_url = node['zeromq']['download_url']
zeromq_download_dir = node['zeromq']['download_dir']
zeromq_checksum = node['zeromq']['checksum']
zeromq_prefix = node['zeromq']['prefix']

# http://blog.serverdensity.com/building-zeromq-and-pyzmq-on-red-hat/
# autoconf on RHEL6 -- autoconf2.6x needed.
# Needed to perform the following for all tests to pass "ulimit -n 1200"
packages = %w[autoconf gcc-c++ libsodium-devel libtool pkgconfig]
packages.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{zeromq_download_dir}/zeromq-#{zeromq_version}.tar.gz" do
  source zeromq_download_url
  mode '0644'
  checksum zeromq_checksum
end

execute 'untar zeromq tarball' do
  command "tar -xzf zeromq-#{zeromq_version}.tar.gz"
  cwd zeromq_download_dir
  creates "#{zeromq_download_dir}/zeromq-#{zeromq_version}"
  action :run
end

script 'install zeromq' do
  interpreter 'bash'
  cwd "#{zeromq_download_dir}/zeromq-#{zeromq_version}"
  code <<-EOH
  ./configure --prefix=#{zeromq_prefix}
  make
  make install
  EOH
  creates "#{zeromq_prefix}/lib/libzmq.so"
end

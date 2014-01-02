# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2
#
# Cookbook Name:: nagios
# Recipe:: nrpe
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2013-2014, FutureGrid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

nagios_prefix = node['nagios']['prefix']
nagios_download_dir = node['nagios']['download_dir']
nagios_plugins_version = node['nagios']['plugins']['version']
nagios_plugins_download_url = node['nagios']['plugins']['download_url']
nrpe_version = node['nagios']['nrpe']['version']
nrpe_download_url = node['nagios']['nrpe']['download_url']
nrpe_allowed_hosts = node['nagios']['nrpe']['allowed_hosts']

user "nagios" do
  home "/opt/nagios"
  shell "/bin/bash"
  action :create
end

remote_file "#{nagios_download_dir}/nagios-plugins-#{nagios_plugins_version}.tar.gz" do
  source "#{nagios_plugins_download_url}"
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
end

execute "untar nagios plugins tarball" do
  command "tar zxvf nagios-plugins-#{nagios_plugins_version}.tar.gz"
  cwd "#{nagios_download_dir}"
  creates "#{nagios_download_dir}/nagios-plugins-#{nagios_plugins_version}"
end

script "install nagios plugins" do
  interpreter "bash"
  cwd "#{nagios_download_dir}/nagios-plugins-#{nagios_plugins_version}"
  code <<-EOH
  ./configure --prefix=#{nagios_prefix}
  make
  make install
  EOH
  creates "#{nagios_prefix}/libexec/check_ping"
end

remote_file "#{nagios_download_dir}/nrpe-#{nrpe_version}.tar.gz" do
  source "#{nrpe_download_url}"
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
end

execute "untar nrpe tarball" do
  command "tar zxvf nrpe-#{nrpe_version}.tar.gz"
  cwd "#{nagios_download_dir}"
  creates "#{nagios_download_dir}/nrpe-#{nrpe_version}"
end

script "install nrpe" do
  interpreter "bash"
  cwd "#{nagios_download_dir}/nrpe-#{nrpe_version}"
  code <<-EOH
  ./configure --prefix=#{nagios_prefix}
  make all
  make install-plugin
  make install-daemon
  make install-daemon-config
  EOH
  creates "#{nagios_prefix}/etc"
end

template "/etc/init.d/nrpe" do
  source "init.d/nrpe.erb"
  mode "0744"
  owner "root"
  group "root"
  action :create
  variables(
    :nagios_prefix => nagios_prefix)
end

template "#{nagios_prefix}/etc/nrpe.cfg" do
  source "etc/nrpe.cfg.erb"
  mode "0644"
  owner "nagios"
  group "nagios"
  action :create
  variables(
    :allowed_hosts => nrpe_allowed_hosts)
end

service "nrpe" do
  action [ :enable, :start ]
end

# some how the above doesn't start nrpe. Here's a workaround.
execute "start nrpe" do
  command "/etc/init.d/nrpe start || /etc/init.d/nrpe restart"
end

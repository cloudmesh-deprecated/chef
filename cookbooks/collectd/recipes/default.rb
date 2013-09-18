#
# Cookbook Name:: collectd
# Recipe:: default
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

collectd_version = node["collectd"]["version"]
collectd_download_url = node["collectd"]["download_url"]
collectd_download_dir = node["collectd"]["download_dir"]
collectd_checksum = node["collectd"]["checksum"]
collectd_prefix = node["collectd"]["prefix"]

packages = %w[libgcrypt libgcrypt-devel perl-devel]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{collectd_download_dir}/collectd-#{collectd_version}.tar.gz" do
  source "#{collectd_download_url}"
  mode "0644"
  checksum "#{collectd_checksum}"
end

execute "untar collectd tarball" do
  command "tar -xzf collectd-#{collectd_version}.tar.gz"
  cwd "#{collectd_download_dir}"
  creates "#{collectd_download_dir}/collectd-#{collectd_version}"
  action :run
end

script "install collectd" do
  interpreter "bash"
  user "root"
  cwd "#{collectd_download_dir}/collectd-#{collectd_version}"
  code <<-EOF
  ./configure --prefix=#{collectd_prefix} --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib --mandir=/usr/share/man --disable-iptables
  make
  make install
  EOF
  not_if "test -f #{collectd_prefix}/sbin/collectd"
end

script "create collectd init.d file" do
  interpreter "bash"
  user "root"
  cwd "#{collectd_download_dir}/collectd-#{collectd_version}"
  code <<-EOF
  cp contrib/redhat/init.d-collectd /etc/init.d/collectd
  chmod 755 /etc/init.d/collectd
  chown root:root /etc/init.d/collectd
  EOF
  not_if "test -f /etc/init.d/collectd"
end

template "/etc/collectd.conf" do
  source "collectd.conf.erb"
  mode "0644"
  action :create_if_missing
end

service "collectd" do
  action [ :enable, :start ]
end

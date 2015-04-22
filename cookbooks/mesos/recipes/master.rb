#
# Cookbook Name:: mesos
# Recipe:: master
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

mesos_master_hostname = node["mesos"]["master_hostname"]
mesos_repo_rpm_download_url = node["mesos"]["repo_rpm_download_url"]
mesos_repo_rpm_path = node["mesos"]["repo_rpm_path"]

remote_file "#{mesos_repo_rpm_path}" do
  source "#{mesos_repo_rpm_download_url}"
end

package "#{File.basename(mesos_repo_rpm_path, ".rpm")}" do
  action :install
  source "#{mesos_repo_rpm_path}"
  provider Chef::Provider::Package::Rpm
end

mesos_packages = %w[mesos marathon mesosphere-zookeeper]
mesos_packages.each do |mesos_package|
  package "#{mesos_package}" do
    action :install
  end
end

template "/etc/mesos-master/hostname" do
  source "etc_mesos-master_hostname.erb"
  mode "0644"
  variables(
    :mesos_master_hostname => mesos_master_hostname
  )
end

service "mesos-slave" do
  action [ :disable, :stop ]
end

#sudo systemctl restart mesos-master.service
#sudo systemctl restart marathon

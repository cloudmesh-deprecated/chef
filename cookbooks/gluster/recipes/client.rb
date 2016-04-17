#
# Cookbook Name:: gluster
# Recipe:: client
#
# Copyright 2016, Jonathan Klinginsmith
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

include_recipe 'gluster::default'

gluster_server = node['gluster']['server']
gluster_volume = node['gluster']['volume']
gluster_mount_point = node['gluster']['mount_point']
gluster_fstype = node['gluster']['fstype']

packages = %w(glusterfs glusterfs-fuse)
packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory gluster_mount_point do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

mount gluster_mount_point do
  device "#{gluster_server}:/#{gluster_volume}"
  fstype gluster_fstype
  action [:mount]
end

#
# Cookbook Name:: gluster
# Recipe:: server
#
# Copyright 2014, Jonathan Klinginsmith
#
# All rights reserved - Do Not Redistribute
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

include_recipe "gluster::default"

gluster_volume = node["gluster"]["volume"]
gluster_server = node["gluster"]["server"]
gluster_brick = node["gluster"]["brick"]

packages = %w[glusterfs glusterfs-fuse glusterfs-server]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

services = %w[glusterd]
services.each do |service|
  service "#{service}" do
    action [ :enable, :start ]
  end
end

execute "gluster volume create #{gluster_volume} #{gluster_server}:/#{gluster_brick}" do
  not_if "gluster volume status #{gluster_volume}"
end

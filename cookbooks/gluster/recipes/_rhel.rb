#
# Cookbook Name:: gluster
# Recipe:: _rhel
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

remote_file "/etc/yum.repos.d/glusterfs-epel.repo" do
  source "http://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/glusterfs-epel.repo"
  mode "0644"
  checksum "11e24f4c7ea04cf51c38c7a8c5b24f3e0298c50f6119c4b58af207fedf85652e"
end

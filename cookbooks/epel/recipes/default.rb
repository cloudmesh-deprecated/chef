#
# Cookbook Name:: epel
# Recipe:: default
#
# Copyright 2012, Jonathan Klinginsmith
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

directory "/etc/pki/rpm-gpg" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL" do
  source "RPM-GPG-KEY-EPEL"
  mode "0644"
  action :create_if_missing 
end

directory "/etc/yum.repos.d" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/etc/yum.repos.d/epel.repo" do
  source "epel.repo"
  mode "0644"
  action :create_if_missing
end


#
# Cookbook Name:: munge
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

packages = %w[munge munge-devel munge-libs]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

# The ctx.h file is not included in RPMs
cookbook_file '/usr/include/ctx.h' do
  source 'ctx.h'
  mode '0644'
  owner 'root'
  group 'root'
end

# TODO: Determine how we want to create the munge.key file.
cookbook_file '/etc/munge/munge.key' do
  source 'munge.key'
  mode '0400'
  owner 'munge'
  group 'munge'
end

service 'munge' do
  action [ :enable, :start ]
end

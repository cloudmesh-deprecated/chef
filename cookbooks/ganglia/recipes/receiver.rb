#
# Cookbook Name:: ganglia
# Recipe:: receiver
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
#

include_recipe 'ganglia'

# Get the data sources to receive information from.
data_sources = node['ganglia']['data_sources']

packages = %w(rrdtool httpd php)
packages.each do |pkg|
  package pkg do
    action :install
  end
end

ganglia_packages = %w(ganglia-gmetad ganglia-web)
ganglia_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# Create the Ganglia gmetad conf file.
# Create one data source for each item in data_sources.
template '/etc/ganglia/gmetad.conf' do
  source 'gmetad.conf.erb'
  mode '0644'
  variables(
    data_sources: data_sources)
end

# Create the Ganglia Apache conf file.
template '/etc/httpd/conf.d/ganglia.conf' do
  source 'ganglia.conf.erb'
  mode '0644'
end

directory '/var/lib/ganglia/rrds' do
  owner 'nobody'
  group 'root'
  action :create
  recursive true
end

service 'gmetad' do
  action [:enable, :start]
end

service 'httpd' do
  action [:enable, :start]
end

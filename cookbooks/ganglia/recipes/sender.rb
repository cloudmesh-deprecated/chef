#
# Cookbook Name:: ganglia
# Recipe:: sender
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

# sender_name is the cluster name for this sender.
sender_name = node['ganglia']['name']
port = node['ganglia']['port']
receiver_name = node['ganglia']['receiver_name']

package 'ganglia-gmond' do
  action :install
end

# Search for the receiver by using the ganglia_roles "receiver" and
# where the "ganglia_data_sources_name" variable contains this cluster name.
# receiver_data = search(:node, "ganglia_roles:receiver AND ganglia_data_sources_name:#{sender_name}").first
# receiver_name = receiver_data.ipaddress

# Create the /etc/ganglia/gmond.conf file.
template '/etc/ganglia/gmond.conf' do
  source 'gmond.conf.erb'
  mode '0644'
  variables(
    cluster_name: sender_name,
    receiver_name: receiver_name,
    host: receiver_name,
    port: port)
end

service 'gmond' do
  action [:enable, :start]
end

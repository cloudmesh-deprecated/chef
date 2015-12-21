#
# Cookbook Name:: mongodb
# Recipe:: shard
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

include_recipe 'mongodb::repo'

mongodb_shard_port = node['mongodb']['shard_port']
mongodb_shard_role = node['mongodb']['shard_role']

packages = %w(mongodb-org-server mongodb-org-shell)
packages.each do |pkg|
  package pkg do
    action :install
  end
end

template '/etc/mongod.conf' do
  source 'shard.erb'
  mode '0644'
  variables(
    shard_port: mongodb_shard_port
  )
end

service 'mongod' do
  action [:enable, :start]
end

# Initiate the replica set only on the primary
if mongodb_shard_role == 'primary'
  execute 'initiate replica set' do
    command "mongo --port #{mongodb_shard_port} --eval \"rs.initiate()\""
    not_if "mongo --port #{mongodb_shard_port} --eval \"shellPrint(rs.conf())\" > /dev/null"
  end
end

# rs_status = Mixlib::ShellOut.new("mongo --eval \"printjson(rs.status())\" --quiet")
# rs_status.run_command
# rs_json = JSON.parse(rs_status.stdout)
# rs_json = `mongo --eval "printjson(rs.status())" --quiet`
# members = rs_json.fetch("members", [])
# members.each do |member|
#   log "message" do
#     message "Member: #{member['name']}"
#     level :info
#   end
# end

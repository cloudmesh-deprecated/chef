#
# Cookbook Name:: packstack
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

keystone_admin_password = node["packstack"]["keystone_admin_password"]

answers_path = node["packstack"]["answers_path"]
key_file_path = node["packstack"]["key_file_path"]

remote_file "/tmp/rdo-release-havana.rpm" do
  source "http://rdo.fedorapeople.org/openstack-havana/rdo-release-havana.rpm"
  mode "0644"
  checksum "cc3b2ed786f561fe8f6c137bd51cd0be592e8c64c9e5c75ff84e3728d7092db7"
end

package "rdo-release-havana" do
  source "/tmp/rdo-release-havana.rpm"
  action :install
end

packages = %w[ntp openstack-packstack python-pbr]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

template "#{answers_path}" do
  source "packstack-answers.txt.erb"
  mode "0644"
  variables(
    :ip_address => node["ipaddress"],
    :keystone_admin_password => keystone_admin_password
  )
end

execute "generate ssh key" do
  command "ssh-keygen -P '' -f #{key_file_path} > /dev/null"
  not_if "test -f #{key_file_path}"
end

execute "add to authorized keys" do
  command "cat #{key_file_path}.pub >>  ~/.ssh/authorized_keys"
  not_if "grep -f #{key_file_path}.pub ~/.ssh/authorized_keys > /dev/null"
end

execute "install packstack" do
  command "packstack --answer-file=#{answers_path}"
end

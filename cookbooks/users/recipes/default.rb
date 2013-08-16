#
# Cookbook Name:: users
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

# Include the epel recipe to get ruby-shadow installed.
include_recipe 'epel'

package "ruby-shadow" do
  action :install
end

users = node[:users]

# Iterate through the users.
users.each do |user_hash|
  user_name = user_hash[:name]
  user_id = user_hash[:id]
  group_id = user_hash[:group]
  home_dir = user_hash[:home_dir]
  shell = user_hash[:shell]
  password = user_hash[:password]

  # Create the user.
  user "#{user_name}" do
    comment "#{user_name} User"
    uid "#{user_id}"
    gid "#{group_id}"
    home "#{home_dir}"
    shell "#{shell}"
    password "#{password}"
  end

  # Create the home directory.
  directory "#{home_dir}" do
    owner "#{user_name}"
    group "#{group_id}"
    mode "0755"
    action :create
  end
end

#!/bin/bash

########################################
#
# The end result of this script is it provides a simple 'Hello World'
# Chef recipe that can be executed by chef-solo.
# This script assumes Chef is installed on the node.
#
# The goal is to provide some info on:
#  * The use of the solo.rb file for configuration.
#  * How to use knife to create a cookbook.
#  * The use of JSON files to create a run list.
#  * The use of an attribute in a Chef recipe.
#  * Calling chef-solo to test and run a recipe.
#
# Hopefully, by using and reviewing this script, one can get into Chef
# with a couple of less hurdles.
#
########################################

# Create the dirs for the cookbooks and roles
mkdir -p /var/chef/cookbooks
mkdir -p /var/chef/roles

# Create the dir for the solo.rb file.
mkdir -p /etc/chef

# Populate the solo.rb file.
cat << EOL > /etc/chef/solo.rb
log_location       STDOUT
file_cache_path    "/var/chef"
cookbook_path      [ "/var/chef/cookbooks" ]
role_path          [ "/var/chef/roles" ]
Mixlib::Log::Formatter.show_time = true
EOL

# Create a helloworld recipe.
cd /var/chef/cookbooks
knife cookbook create helloworld -u `whoami` -o ./

cat << EOF > ./helloworld/recipes/default.rb
#
# Cookbook Name:: helloworld
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

# If a message was provided then display it; otherwise, say 'Hello World'.
message = node.has_key?(:message) ? node[:message] : "Hello World"

execute "echo message" do
  command "echo '#{message}'"
  action :run
end
EOF

# Now to calling the recipe that was just created.

# Create two JSON files to test the recipe.
cd ~
echo "{ \"run_list\": [ \"recipe[helloworld]\" ] }" > helloworld.json
# Should see a debug stack with a "Hello World" message in the middle.
chef-solo -j helloworld.json

echo "{ \"run_list\": [ \"recipe[helloworld]\" ], \"message\": \"Second Message\" }" > secondmessage.json
# Should see a debug stack with a "Second Message" message in the middle.
chef-solo -j secondmessage.json

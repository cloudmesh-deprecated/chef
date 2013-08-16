#
# Cookbook Name:: groups
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

# groups is a list of group hashes, each containing a name and id.
groups = node[:groups]

# Iterate through the groups, configuring each.
groups.each do |group_hash|
  group_name = group_hash[:name]
  group_id = group_hash[:id].to_i

  # Add a group
  group "#{group_name}" do
    gid #{group_id}
  end
end

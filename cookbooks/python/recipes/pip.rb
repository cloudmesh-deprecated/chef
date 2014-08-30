#
# Cookbook Name:: python
# Recipe:: pip
#
# Copyright 2014, Jonathan Klinginsmith
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

python_prefix = node["python"]["prefix"]
get_pip_url = node["python"]["pip_get-pip_url"]
get_pip_checksum = node["python"]["pip_get-pip_checksum"]
get_pip_path = File.join(Chef::Config["file_cache_path"], "get-pip.py")

remote_file "#{get_pip_path}" do
  source "#{get_pip_url}"
  mode "0644"
  checksum "#{get_pip_checksum}"
end

execute "install pip" do
  command "#{python_prefix}/bin/python #{get_pip_path}"
  creates "#{python_prefix}/bin/pip"
end

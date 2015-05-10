#
# Cookbook Name:: python
# Recipe:: cassandra
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

python_prefix = node["python"]["prefix"]

packages = %w[libev libev-devel]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

execute "install cassandra-driver" do
  command "#{python_prefix}/bin/pip install cassandra-driver"
  not_if "#{python_prefix"/bin/python -c 'import cassandra' &> /dev/null"
end

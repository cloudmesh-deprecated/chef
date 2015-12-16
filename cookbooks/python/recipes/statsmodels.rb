#
# Cookbook Name:: python
# Recipe:: statsmodels
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

python_prefix = node['python']['prefix']

pip_packages = %w(patsy statsmodels)
pip_packages.each do |pip_package|
  execute "install #{pip_package}" do
    command "#{python_prefix}/bin/pip install #{pip_package}"
    action :run
  end
end

#
# Cookbook Name:: python
# Recipe:: setuptools 
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

python_setuptools_setup_download_url = node["python"]["setuptools_setup_download_url"]
python_setuptools_setup_checksum = node["python"]["setuptools_setup_checksum"]

python_prefix = node["python"]["prefix"]
python_download_dir = node["python"]["download_dir"]

remote_file "#{python_download_dir}/ez_setup.py" do
  source "#{python_setuptools_setup_download_url}"
  mode "0644"
 checksum "#{python_setuptools_setup_checksum}"
end

execute "run ez_setup.py" do
  command "#{python_prefix}/bin/python ez_setup.py"
  cwd "#{python_download_dir}"
  creates "#{python_prefix}/bin/easy_install"
end

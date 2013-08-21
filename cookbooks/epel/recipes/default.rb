#
# Cookbook Name:: epel
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

epel_download_url = node["epel"]["download_url"]
epel_download_dir = node["epel"]["download_dir"]
epel_checksum = node["epel"]["checksum"]

remote_file "#{epel_download_dir}/epel.rpm" do
  source "#{epel_download_url}"
  mode "0755"
  checksum "#{epel_checksum}"
end

package "#{epel_download_dir}/epel.rpm" do
  action :install
  not_if "test -f /etc/yum.repos.d/epel.repo"
end

#
# Cookbook Name:: epel
# Recipe:: default
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

epel_download_url = node["epel"]["download_url"]
epel_rpm_path = node["epel"]["rpm_path"]
epel_checksum = node["epel"]["checksum"]

remote_file "#{epel_rpm_path}" do
  source "#{epel_download_url}"
  mode "0755"
  checksum "#{epel_checksum}"
end

package "#{File.basename(epel_rpm_path, ".rpm")}" do
  action :install
  source "#{epel_rpm_path}"
  provider Chef::Provider::Package::Rpm
end

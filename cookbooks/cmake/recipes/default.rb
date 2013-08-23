#
# Cookbook Name:: cmake
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

cmake_version = node["cmake"]["version"]
cmake_download_url = node["cmake"]["download_url"]
cmake_download_dir = node["cmake"]["download_dir"]
cmake_checksum = node["cmake"]["checksum"]
cmake_prefix = node["cmake"]["prefix"]

remote_file "#{cmake_download_dir}/cmake-#{cmake_version}.tar.gz" do
  source "#{cmake_download_url}"
  mode "0644"
  checksum "#{cmake_checksum}"
end

execute "untar cmake tarball" do
  command "tar -xzf cmake-#{cmake_version}.tar.gz"
  cwd "#{cmake_download_dir}"
  creates "#{cmake_download_dir}/cmake-#{cmake_version}"
end

script "install cmake" do
  interpreter "bash"
  cwd "#{cmake_download_dir}/cmake-#{cmake_version}"
  code <<-EOH
  ./bootstrap --prefix=#{cmake_prefix}
  make
  make install
  EOH
  creates "#{cmake_prefix}/bin/cmake"
end

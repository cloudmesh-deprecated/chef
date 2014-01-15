#
# Cookbook Name:: maven
# Recipe:: default
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

maven_version = node["maven"]["version"]
maven_download_url = node["maven"]["download_url"]
maven_download_dir = node["maven"]["download_dir"]
maven_checksum = node["maven"]["checksum"]
maven_prefix = node["maven"]["prefix"]

remote_file "#{maven_download_dir}/apache-maven-#{maven_version}-bin.tar.gz" do
  source "#{maven_download_url}"
  mode "0644"
  checksum "#{maven_checksum}"
end

execute "untar maven tarball" do
  command "tar --directory=#{maven_prefix} -xzf apache-maven-#{maven_version}-bin.tar.gz"
  cwd "#{maven_download_dir}"
  creates "#{maven_prefix}/apache-maven-#{maven_version}"
end

binaries = %w[mvn mvnDebug mvnyjp]

binaries.each do |binary|
  link "/usr/local/bin/#{binary}" do
    to "#{maven_prefix}/apache-maven-#{maven_version}/bin/#{binary}"
  end
end

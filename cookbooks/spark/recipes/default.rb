#
# Cookbook Name:: spark
# Recipe:: default
#
# Copyright 2016, Jonathan Klinginsmith
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

spark_download_url = node['spark']['download_url']
spark_download_dir = node['spark']['download_dir']
spark_tarball = File.basename(spark_download_url)
spark_directory = File.join(spark_download_dir,
                            File.basename(spark_tarball, File.extname(spark_tarball)))
spark_checksum = node['spark']['checksum']

packages = %w(java-1.8.0-openjdk java-1.8.0-openjdk-devel)
packages.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{File.join(spark_download_dir, spark_tarball)}" do
  source spark_download_url
  mode '0644'
  checksum spark_checksum
end

execute 'untar spark tarball' do
  command "tar -xzf #{spark_tarball}"
  cwd spark_download_dir
  creates spark_directory
end

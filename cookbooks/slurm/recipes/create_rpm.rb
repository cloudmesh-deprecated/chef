#
# Cookbook Name:: slurm
# Recipe:: create_rpm
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

slurm_version = node['slurm']['version']
slurm_download_url = node['slurm']['download_url']
slurm_download_dir = node['slurm']['download_dir']
slurm_checksum = node['slurm']['checksum']

packages = %w(gcc gcc-c++ mailx make munge munge-devel munge-libs openssl openssl-devel pam-devel perl perl-ExtUtils-MakeMaker readline-devel rpm-build)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{slurm_download_dir}/slurm-#{slurm_version}.tar.bz2" do
  source slurm_download_url
  mode '0644'
  checksum slurm_checksum
end

execute 'build slurm rpm' do
  command "rpmbuild -ta slurm-#{slurm_version}.tar.bz2"
  cwd slurm_download_dir
  creates "#{File.join(File.expand_path('~'), 'rpmbuild', 'RPMS', 'x86_64', "slurm-#{slurm_version}.el6.x86_64.rpm")}"
end

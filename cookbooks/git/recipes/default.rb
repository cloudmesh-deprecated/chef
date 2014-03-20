#
# Cookbook Name:: git
# Recipe:: default
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright (C) 2014 FutureGrid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

git_version = node['git']['version']
git_install_dir = node['git']['install_dir']
git_download_dir = node['git']['download_dir']
git_download_url = node['git']['download_url']

packages = %w[unzip curl-devel autoconf gcc gettext-devel]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{git_download_dir}/git-#{git_version}.tar.gz" do
	source git_download_url
	mode "0644"
	owner "root"
	group "root"
	action :create_if_missing
end

directory git_install_dir do
	mode "0755"
	owner "root"
	group "root"
	recursive true
	action :create
end

script "install_git" do
	interpreter "bash"
	cwd git_download_dir
	code <<-EOH
	ls -la
	tar zxvf git-#{git_version}.tar.gz
	cd git-#{git_version}
	make configure
	./configure --prefix=#{git_install_dir}/git-#{git_version}
	make
	make install
	EOH
	creates "#{git_install_dir}/git-#{git_version}"
end

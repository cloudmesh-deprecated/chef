#
# Cookbook Name:: cookbooks/git
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
git_modulefiles_dir = node['git']['modulefiles_dir']

directory "#{git_modulefiles_dir}/git" do
	owner "root"
	group "root"
	mode "755"
	recursive true
	action :create
end

template "#{git_modulefiles_dir}/git/#{git_version}" do
	source "module_file.erb"
	mode "0644"
	owner "root"
	group "root"
	action :create
	variables(
	  :git_install_dir => git_install_dir)
end

template "#{git_modulefiles_dir}/git/.version" do
	source "module_version.erb"
	mode "0644"
	owner "root"
	group "root"
	action :create
	variables(
	  :git_version => git_version)
end

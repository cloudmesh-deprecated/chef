#
# Cookbook Name:: cookbooks/git
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

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

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

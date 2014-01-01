#
# Cookbook Name:: bigdata_mooc
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bigdata_mooc_tmp_dir = node["bigdata_mooc"]["tmp_dir"]
bigdata_mooc_repo_url = node["bigdata_mooc"]["repo_url"]
dest_dir = "/home/ipynb"

packages = %w[git rsync]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

git "#{bigdata_mooc_tmp_dir}" do
  repository "#{bigdata_mooc_repo_url}"
  reference "master"
  action :sync
end

script "install IPython notebooks" do
  interpreter "bash"
  cwd "#{bigdata_mooc_tmp_dir}"
  code <<-EOH
  rsync --ignore-existing #{bigdata_mooc_tmp_dir}/*.ipynb #{dest_dir}
  chown ipynb:ipynb #{dest_dir}/*.ipynb
  EOH
  not_if "ls -l #{dest_dir}/*.ipynb > /dev/null 2>&1"
end

#
# Cookbook Name:: cookbooks/git
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

packages = %w[unzip curl-devel autoconf gcc gettext-devel]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

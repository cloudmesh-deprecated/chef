#
# Cookbook Name:: python
# Recipe:: cython 
#
# Copyright 2012, Jonathan Klinginsmith
#
# All rights reserved - Do Not Redistribute
#

cython_version = node[:python][:cython_version]
cython_download_url = node[:python][:cython_download_url]
cython_checksum = node[:python][:cython_checksum]

python_prefix = node[:python][:prefix]
python_lib_directory = `#{node[:python][:prefix]}/bin/python -c "import distutils.sysconfig as d; print(d.get_python_lib())"`.chomp

remote_file "/tmp/Cython-#{cython_version}.tar.gz" do
  source "#{cython_download_url}"
  mode "0644"
  checksum "#{cython_checksum}"
end

execute "untar cython tarball" do
  command "tar -xzf Cython-#{cython_version}.tar.gz"
  cwd "/tmp"
  creates "/tmp/Cython-#{cython_version}"
  action :run
end

script "install cython" do
  interpreter "bash"
  user "root"
  cwd "/tmp/Cython-#{cython_version}"
  code <<-EOF
  #{python_prefix}/bin/python setup.py install
  EOF
  not_if "test -d #{python_lib_directory}/Cython"
end

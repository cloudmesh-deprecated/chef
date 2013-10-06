#
# Cookbook Name:: ipython
# Recipe:: public_notebook
#
# Copyright 2013, Jonathan Klinginsmith
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

include_recipe "ipython"
include_recipe "zeromq"

python_prefix = node["python"]["prefix"]

ipython_profile_name = node["ipython"]["profile_name"]
ipython_profile_dir = node["ipython"]["profile_dir"]
ipython_notebook_password = node["ipython"]["notebook_password"]

ipython_user = node["ipython"]["user"]
ipython_group = node["ipython"]["group"]
ipython_home_dir = node["ipython"]["home_dir"]

pip_packages = %w[jinja2 pyzmq]
pip_packages.each do |pip_package|
  execute "install #{pip_package}" do
    command "#{python_prefix}/bin/pip install #{pip_package}"
    action :run
  end
end

#####

# Create ipython group
group "#{ipython_group}" do
  action :create
end

# Create ipython user
user "#{ipython_user}" do
  comment "#{ipython_user} user"
  gid "#{ipython_group}"
  home "#{ipython_home_dir}"
  supports :manage_home => true
  shell "/bin/bash"
end

# Create ipython directory.
directory "#{File.join(ipython_home_dir, ".ipython")}" do
  owner "#{ipython_user}"
  group "#{ipython_group}"
  mode "0755"
  action :create
end

script "create ipython profile #{ipython_profile_name}" do
  interpreter "bash"
  user "#{ipython_user}"
  cwd "#{ipython_home_dir}"
  code <<-EOH
  #{python_prefix}/bin/ipython profile create #{ipython_profile_name} --ipython-dir=#{File.join(ipython_home_dir, ".ipython")}
  EOH
  creates "#{ipython_profile_dir}"
end

# Populate the ipython config file with a password.
template "#{ipython_profile_dir}/ipython_config.py" do
  source "ipython_config.py.erb"
  mode "0644"
  variables(
    :password => ipython_notebook_password
  )
end

# Create a service named "ipython-notebook"
template "/etc/init.d/ipython-notebook" do
  source "init.d.ipython-notebook.erb"
  mode "0755"
  variables(
    :dir => "#{ipython_home_dir}",
    :user => "#{ipython_user}",
    :cmd => "#{python_prefix}/bin/ipython notebook --profile #{ipython_profile_name}"
  )
end

service "ipython-notebook" do
  supports :status => true
  action [ :enable, :start ]
end

# Use HAProxy to forward port 80 requests to 8080
# IPython is running as a non-privileged user;
# therefore, cannot listen to 80.
package "haproxy" do
  action :install
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  mode "0644"
end

service "haproxy" do
  supports :status => true
  action [ :enable, :start ]
end

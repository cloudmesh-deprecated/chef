#
# Cookbook Name:: slurm
# Recipe:: create_rpm
#
# Copyright 2014, Jonathan Klinginsmith
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

slurm_version = node["slurm"]["version"]
slurm_download_url = node["slurm"]["download_url"]
slurm_download_dir = node["slurm"]["download_dir"]
slurm_checksum = node["slurm"]["checksum"]
slurm_prefix = node["slurm"]["prefix"]
slurm_sysconfdir = node["slurm"]["sysconfdir"]
slurm_version_dir = File.join(slurm_download_dir, "slurm-#{slurm_version}")

slurm_control_machine = node["slurm"]["control_machine"]
slurm_control_addr = node["slurm"]["control_addr"]

slurm_user = node["slurm"]["user"]
slurm_uid = node["slurm"]["uid"]
slurm_group = node["slurm"]["group"]
slurm_gid = node["slurm"]["gid"]

packages = %w[gcc gcc-c++ mailx make munge munge-devel munge-libs openssl-devel pam-devel perl perl-ExtUtils-MakeMaker readline-devel rpm-build]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

remote_file "#{slurm_download_dir}/slurm-#{slurm_version}.tar.bz2" do
  source "#{slurm_download_url}"
  mode "0644"
  checksum "#{slurm_checksum}"
end

execute "build slurm rpm" do
  command "rpmbuild -ta slurm-#{slurm_version}.tar.bz2"
  cwd "#{slurm_download_dir}"
  creates "#{ File.join(File.expand_path("~"), "rpmbuild", "RPMS", "x86_64", "slurm-#{slurm_version}.el6.x86_64.rpm") }"
end
#
#script "install slurm" do
#  interpreter "bash"
#  cwd "#{slurm_version_dir}"
#  code <<-EOH
#  ./configure --prefix=#{slurm_prefix}
#  make
#  make install
#  EOH
#  creates "#{slurm_prefix}/bin/squeue"
#end
#
## TODO: Determine how we want to create the munge.key file.
#cookbook_file "/etc/munge/munge.key" do
#  source "munge.key"
#  mode "0400"
#  owner "munge"
#  group "munge"
#end
#
## TODO: Determine how we want to populate NodeName values.
## Create the slurm.conf file.
#template "#{slurm_sysconfdir}/slurm.conf" do
#  source "slurm.conf.erb"
#  mode "0644"
#  variables(
#    :control_machine => slurm_control_machine,
#    :control_addr => slurm_control_addr )
#end
#
## Create the /etc/init.d/slurm file.
#template "/etc/init.d/slurm" do
#  source "init.d.slurm.erb"
#  mode "0755"
#  variables(
#    :prefix => slurm_prefix,
#    :sysconfdir => slurm_sysconfdir )
#end
#
## Create the slurm group and user.
#group "#{slurm_group}" do
#  gid "#{slurm_gid}"
#end
#
#user "#{slurm_user}" do
#  uid "#{slurm_uid}"
#  gid "#{slurm_group}"
#end
#
## Create the log directory. This is found in the slurm.conf file.
#directory "/var/log/slurm" do
#  owner "#{slurm_user}"
#  group "#{slurm_group}"
#  mode 00755
#  action :create
#end
#
#service "munge" do
#  action [ :enable, :start ]
#end
#
#service "slurm" do
#  action [ :enable, :start ]
#end

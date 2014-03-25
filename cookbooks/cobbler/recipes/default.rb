#
# Setup variables
#
server = node['cobbler']['server']
next_server = node['cobbler']['next_server']
password = node['cobbler']['password']
module_authentication = node['cobbler']['module_authentication']
module_authorization = node['cobbler']['module_authorization']

#
# Install packages
#
packages = %w[ cobbler
               cobbler-web
               pykickstart
               cman
               wget ]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

#
# Enable Services
#
enable_services = %w[
              cobblerd
              httpd
              xinetd
              ]

enable_services.each do |enable_service|
  service "#{enable_service}" do
    action [:start, :enable]
  end
end

#
# Disable Services
#
service "iptables" do
  action [:stop, :disable]
end

#
# Update /etc/xinetd.d/rsync
#
cookbook_file "/etc/xinetd.d/rsync" do
  source "rsync"
  mode 0644
  owner "root"
  group "root"
  action :create
  notifies :restart, "service[xinetd]", :immediately
end

#
# Cobbler Sync
#
execute "cobbler_sync" do
  command "cobbler sync"
  action :nothing
end

#
# Cobbler Get Loaders
#
execute "cobbler_get-loaders" do
  command "cobbler get-loaders"
  action :nothing
end

#
# Update /etc/cobbler/settings
#
template "/etc/cobbler/settings" do
  source "settings.erb"
  mode 0644
  owner "root"
  group "root"
  action :create
  variables(
    :server => server,
    :next_server => next_server,
    :password => password
  )
  notifies :restart, "service[cobblerd]", :immediately
  notifies :run, "execute[cobbler_sync]", :immediately
  notifies :run, "execute[cobbler_get-loaders]", :immediately
end

#
# Update /etc/cobbler/modules.conf
#
template "/etc/cobbler/modules.conf" do
  source "modules.conf.erb"
  mode 0644
  owner "root"
  group "root"
  action :create
  variables(
    :module_authentication => module_authentication,
    :module_authorization => module_authorization
  )
  notifies :restart, "service[cobblerd]", :immediately
  notifies :restart, "service[httpd]", :immediately
end


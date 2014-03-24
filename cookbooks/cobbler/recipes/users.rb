#
# Services
#
enable_services = %w[
              cobblerd
              httpd
              xinetd
              ]

enable_services.each do |enable_service|
  service "#{enable_service}" do
    action :nothing
  end
end

#
# Update /etc/cobbler/users.conf
#
cookbook_file "/etc/cobbler/users.conf" do
  source "users.conf.fgusers"
  mode 0644
  owner "root"
  group "root"
  action :create
  notifies :restart, "service[cobblerd]", :immediately
  notifies :restart, "service[httpd]", :immediately
end

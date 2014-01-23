# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2

default['openstack']['password'] = "OpenStackHavana"
default['openstack']['admin_password'] = node['openstack']['password']
default['openstack']['service_password'] = node['openstack']['password']
default['openstack']['mysql_admin_password'] = node['openstack']['password']
default['openstack']['mysql_password'] = node['openstack']['password']
default['openstack']['rabbit_password'] = node['openstack']['password']
default['openstack']['controller_public_address'] = "172.20.1.1"
default['openstack']['controller_admin_address'] = "192.168.1.1"
default['openstack']['controller_internal_address'] = "192.168.1.1"
default['openstack']['fixed_range'] = "10.10.1.0/24"
default['openstack']['mysql_access'] = "192.168.1.%"
default['openstack']['public_interface'] = "eth1"
default['openstack']['internal_interface'] = "eth0"

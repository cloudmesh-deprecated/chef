# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2

default['openstack']['password'] = "OpenStackHavana"
default['openstack']['admin_password'] = node['openstack']['password']
default['openstack']['service_password'] = node['openstack']['password']
default['openstack']['mysql_admin_password'] = node['openstack']['password']
default['openstack']['mysql_password'] = node['openstack']['password']
default['openstack']['rabbit_password'] = node['openstack']['password']
default['openstack']['controller_public_address'] = "10.0.2.15"
default['openstack']['controller_admin_address'] = "10.0.2.15"
default['openstack']['controller_internal_address'] = "10.0.2.15"
default['openstack']['fixed_range'] = "10.10.3.0/24"
default['openstack']['mysql_access'] = "10.0.2.%"
default['openstack']['public_interface'] = "br101"
default['openstack']['internal_interface'] = "eth0"

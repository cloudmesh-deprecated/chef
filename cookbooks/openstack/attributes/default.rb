# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2

default['openstack']['password'] = "OpenStackHavana"
default['openstack']['admin_password'] = default['openstack']['password']
default['openstack']['service_password'] = default['openstack']['password']
default['openstack']['mysql_admin_password'] = default['openstack']['password']
default['openstack']['mysql_password'] = default['openstack']['password']
default['openstack']['rabbit_password'] = default['openstack']['password']
default['openstack']['controler_public_address'] = "Esternal IP"
default['openstack']['controler_admin_address'] = "192.168.1.1"
default['openstack']['controler_internal_address'] = default['openstack']['controler_admin_address']
default['openstack']['fixed_range'] = "10.10.1.0/24"
default['openstack']['mysql_access'] = "192.168.1.%"
default['openstack']['public_interface'] = "eth1"
default['openstack']['internal_interface'] = "eth0"

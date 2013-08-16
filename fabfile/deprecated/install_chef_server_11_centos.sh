#!/bin/bash

####################################
# This script has been tested with CentOS 6.4 and Chef Server 11.0.8
#
# Verify the Chef Server version from this page - http://www.opscode.com/chef/install/. 
####################################

DOWNLOAD_URL=https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-server-11.0.8-1.el6.x86_64.rpm
RPM_NAME=chef-server-11.rpm

curl -o $RPM_NAME $DOWNLOAD_URL
yum -y localinstall $RPM_NAME
chef-server-ctl reconfigure

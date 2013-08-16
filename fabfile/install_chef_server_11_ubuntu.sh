#!/bin/bash

#DOWNLOAD_URL='https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/10.04/x86_64/chef-server_11.0.8-1.ubuntu.10.04_amd64.deb'
DOWNLOAD_URL='https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb'
PACKAGE_NAME='chef-server.deb'

cd /tmp
curl -o $PACKAGE_NAME $DOWNLOAD_URL
sudo dpkg -i $PACKAGE_NAME
sudo chef-server-ctl reconfigure

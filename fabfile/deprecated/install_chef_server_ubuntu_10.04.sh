#!/bin/bash

#########################
# Installs chef-server on Ubuntu 10.04
#
# Taken from the instructions on this page:
# http://wiki.opscode.com/display/chef/Installing+Chef+Server+on+Debian+or+Ubuntu+using+Packages
#
# Before executing this script, have the following values prepared to be entered:
#  * URL of Chef Server (e.g., http://{fqdn}:4000)
#  * Password for the AMQP user
#  * Password for the web UI
#
# You may receive a message to upgrade RabbitMQ from version 1.5.4. Click OK.
#
# To confirm installation, type in http://{fqdn}:4040 in a browser. The web UI will appear.
#########################

echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | sudo tee /etc/apt/sources.list.d/opscode.list
sudo mkdir -p /etc/apt/trusted.gpg.d
gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
gpg --export packages@opscode.com | sudo tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
sudo apt-get update
sudo apt-get install opscode-keyring # permanent upgradeable keyring
sudo apt-get -y upgrade
sudo apt-get -y install chef chef-server

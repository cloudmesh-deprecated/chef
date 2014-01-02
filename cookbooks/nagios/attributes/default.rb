# vim: tabstop=4 expandtab shiftwidth=2 softtabstop=2

# Common
default['nagios']['prefix'] = '/opt/nagios'
default['nagios']['download_dir'] = '/tmp'

# NRPE
default['nagios']['nrpe']['version'] = '2.15'
default['nagios']['nrpe']['download_url'] = 'http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz?r=http%3A%2F%2Fexchange.nagios.org%2Fdirectory%2FAddons%2FMonitoring-Agents%2FNRPE--2D-Nagios-Remote-Plugin-Executor%2Fdetails&ts=1388507791&use_mirror=hivelocity'
default['nagios']['nrpe']['allowed_hosts'] = '127.0.0.1'

# Plugins
default['nagios']['plugins']['version'] = '1.5'
default['nagios']['plugins']['download_url'] = 'https://www.nagios-plugins.org/download/nagios-plugins-1.5.tar.gz'

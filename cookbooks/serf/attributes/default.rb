default['serf']['version'] = '0.7.0'
default['serf']['download_url'] = "https://releases.hashicorp.com/serf/#{node['serf']['version']}/serf_#{node['serf']['version']}_linux_amd64.zip"
default['serf']['checksum'] = 'b239fdcd1c15fd926ff0cd10bc32a31330d1c74aba9e4d49ff83d5707ef1ba4b'
default['serf']['prefix'] = '/usr/local'
default['serf']['config_dir'] = '/etc/serf/conf.d'
default['serf']['handler_dir'] = '/etc/serf/handlers'

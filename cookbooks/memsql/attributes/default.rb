default['memsql']['version'] = '4.1.7'
default['memsql']['download_url'] = "http://download.memsql.com/memsql-ops-#{node['memsql']['version']}/memsql-ops-#{node['memsql']['version']}.tar.gz"
default['memsql']['download_dir'] = Chef::Config[:file_cache_path]
default['memsql']['checksum'] = '203b16f4d3d60b59f5d347d4d343768a126685d151b2ac60d3bd1a4e1ae72ba5'

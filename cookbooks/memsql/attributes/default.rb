default['memsql']['version'] = '4.1.7'
default['memsql']['download_url'] = "http://download.memsql.com/memsql-ops-#{node['memsql']['version']}/memsql-ops-#{node['memsql']['version']}.tar.gz"
default['memsql']['download_dir'] = Chef::Config[:file_cache_path]
default['memsql']['checksum'] = '203b16f4d3d60b59f5d347d4d343768a126685d151b2ac60d3bd1a4e1ae72ba5'
default['memsql']['bin_download_url'] = 'http://download.memsql.com/releases/latest/memsqlbin_amd64.tar.gz'
default['memsql']['bin_checksum'] = '3fee740409d1d8ed3f21b45b960d9a9244cc119ae1a59af433613b111428e526'

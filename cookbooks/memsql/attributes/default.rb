default['memsql']['version'] = '4.1.9'
default['memsql']['download_url'] = "http://download.memsql.com/memsql-ops-#{node['memsql']['version']}/memsql-ops-#{node['memsql']['version']}.tar.gz"
default['memsql']['download_dir'] = Chef::Config[:file_cache_path]
default['memsql']['checksum'] = 'f6bdf8451ce4d8cd79a555accbcbbef09eb828e0c4c12d1c632442a82739466f'
default['memsql']['bin_download_url'] = 'http://download.memsql.com/releases/latest/memsqlbin_amd64.tar.gz'
default['memsql']['bin_checksum'] = '3fee740409d1d8ed3f21b45b960d9a9244cc119ae1a59af433613b111428e526'

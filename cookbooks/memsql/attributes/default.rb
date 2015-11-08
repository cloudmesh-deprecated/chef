default['memsql']['version'] = '4.1.9'
default['memsql']['download_url'] = "http://download.memsql.com/memsql-ops-#{node['memsql']['version']}/memsql-ops-#{node['memsql']['version']}.tar.gz"
default['memsql']['download_dir'] = Chef::Config[:file_cache_path]
default['memsql']['checksum'] = 'f6bdf8451ce4d8cd79a555accbcbbef09eb828e0c4c12d1c632442a82739466f'
default['memsql']['bin_download_url'] = 'http://download.memsql.com/releases/latest/memsqlbin_amd64.tar.gz'
default['memsql']['bin_checksum'] = '2bb43d1c719a28dfdbaad7126a5301a8327299984ba6678c76e07f77306ed7ce'

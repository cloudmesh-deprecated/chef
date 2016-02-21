default['spark']['version'] = '1.6.0'
default['spark']['download_url'] = "http://ftp.wayne.edu/apache/spark/spark-#{node['spark']['version']}/spark-#{node['spark']['version']}-bin-hadoop2.6.tgz"
default['spark']['download_dir'] = Chef::Config[:file_cache_path]
default['spark']['checksum'] = '439fe7793e0725492d3d36448adcd1db38f438dd1392bffd556b58bb9a3a2601'
default['spark']['prefix'] = '/usr/local'

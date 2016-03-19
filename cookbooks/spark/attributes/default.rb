default['spark']['version'] = '1.6.1'
default['spark']['download_url'] = "http://ftp.wayne.edu/apache/spark/spark-#{node['spark']['version']}/spark-#{node['spark']['version']}-bin-hadoop2.6.tgz"
default['spark']['download_dir'] = Chef::Config[:file_cache_path]
default['spark']['checksum'] = '09f3b50676abc9b3d1895773d18976953ee76945afa72fa57e6473ce4e215970'
default['spark']['prefix'] = '/usr/local'

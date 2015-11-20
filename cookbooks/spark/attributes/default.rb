default['spark']['version'] = '1.5.2'
default['spark']['download_url'] = "http://ftp.wayne.edu/apache/spark/spark-#{node["spark"]["version"]}/spark-#{node["spark"]["version"]}-bin-hadoop2.6.tgz"
default['spark']['download_dir'] = Chef::Config[:file_cache_path]
default['spark']['checksum'] = '409c4b34f196acc5080b893b0579cda000c192fc4cc9336009395b2a559b676e'
default['spark']['prefix'] = '/usr/local'

default["epel"]["download_url"] = "http://ftp.linux.ncsu.edu/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
default["epel"]["rpm_path"] = File.join(Chef::Config[:file_cache_path], "epel-release-7-5.noarch.rpm")
default["epel"]["checksum"] = "d3b2ea818b10afdfb505f1f57fe7a0e47484b2d308b2433a5f4040a5f2021138"

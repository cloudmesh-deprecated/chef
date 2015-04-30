default["spark"]["version"] = "1.3.1"
default["spark"]["download_url"] = "http://ftp.wayne.edu/apache/spark/spark-1.3.1/spark-1.3.1-bin-hadoop2.6.tgz"
default["spark"]["download_dir"] = Chef::Config[:file_cache_path]
default["spark"]["checksum"] = "a25aaf58cfb3c64e3c77bdf9dde1a61247846d60519dd28b18d60d162d19c79a"
default["spark"]["prefix"] = "/usr/local"

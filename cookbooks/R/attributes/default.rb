default["R"]["version"] = "3.2.1"
default["R"]["download_url"] = "http://ftp.ussg.iu.edu/CRAN/src/base/R-3/R-#{node["R"]["version"]}.tar.gz"
default["R"]["download_dir"] = Chef::Config[:file_cache_path]
default["R"]["checksum"] = "d59dbc3f04f4604a5cf0fb210b8ea703ef2438b3ee65fd5ab536ec5234f4c982" 
default["R"]["prefix"] = "/usr/local"
default["R"]["configure_options"] = "--prefix=#{node["R"]["prefix"]} --with-x=no --enable-R-shlib"

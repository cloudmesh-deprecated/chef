default["R"]["version"] = "3.2.0"
default["R"]["download_url"] = "http://ftp.ussg.iu.edu/CRAN/src/base/R-3/R-#{node["R"]["version"]}.tar.gz"
default["R"]["download_dir"] = Chef::Config[:file_cache_path]
default["R"]["checksum"] = "f5ae953f18ba6f3d55b46556bbbf73441350f9fd22625402b723a2b81ff64f35"
default["R"]["prefix"] = "/usr/local"
default["R"]["configure_options"] = "--prefix=#{node["R"]["prefix"]} --with-x=no --enable-R-shlib"

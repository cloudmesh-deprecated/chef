default["zeromq"]["version"] = "4.1.3"
default["zeromq"]["download_url"] = "http://download.zeromq.org/zeromq-#{node["zeromq"]["version"]}.tar.gz"
default["zeromq"]["download_dir"] = Chef::Config[:file_cache_path]
default["zeromq"]["checksum"] = "61b31c830db377777e417235a24d3660a4bcc3f40d303ee58df082fcd68bf411"
default["zeromq"]["prefix"] = "/usr/local"

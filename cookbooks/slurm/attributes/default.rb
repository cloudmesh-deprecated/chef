default["slurm"]["version"] = "2.6.5"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = "4fc281d18e4614636e3210469c32a9670a688589fb909b3c5e2fa3721e9b5eb0"
default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["sysconfdir"] = "#{node["slurm"]["prefix"]}/etc"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

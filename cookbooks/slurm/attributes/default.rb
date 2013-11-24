default["slurm"]["version"] = "2.6.4"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = "f44a9a80c502dba9809127dc2a04069fd7c87d6b1e10824fe254b2077f9adac8"
default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["sysconfdir"] = "#{node["slurm"]["prefix"]}/etc"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

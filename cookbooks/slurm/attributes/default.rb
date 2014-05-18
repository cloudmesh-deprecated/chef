default["slurm"]["version"] = "14.03.2"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = ""
#default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["prefix"] = ""
default["slurm"]["sysconfdir"] = "#{node["slurm"]["prefix"]}/etc"
default["slurm"]["node_list"] = "node[001-010]"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

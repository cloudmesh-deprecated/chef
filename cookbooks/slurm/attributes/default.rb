default["slurm"]["version"] = "2.6.6-2"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = "7c529b3dd54589f7cf2b68780cd57c9d9da363f6fb83c6a088ceae3fbb18e1e7"
default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["sysconfdir"] = "/etc/slurm"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

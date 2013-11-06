default["slurm"]["version"] = "2.6.3"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = "3523f6866531d48061e6b4d769a17e005b7d440bb5cee6c6ab6a12518c884d23"
default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["sysconfdir"] = "#{node["slurm"]["prefix"]}/etc"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

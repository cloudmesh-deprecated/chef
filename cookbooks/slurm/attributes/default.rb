default["slurm"]["version"] = "2.6.1"
default["slurm"]["download_url"] = "http://www.schedmd.com/download/latest/slurm-#{node["slurm"]["version"]}.tar.bz2"
default["slurm"]["download_dir"] = "/tmp"
default["slurm"]["checksum"] = "d5f2ddf6330e5eb3cf902513f8ea7692231bc743952346fa30763117448924ae"
default["slurm"]["prefix"] = "/usr/local"
default["slurm"]["sysconfdir"] = "#{node["slurm"]["prefix"]}/etc"

# TODO: Determine user and group information.
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"

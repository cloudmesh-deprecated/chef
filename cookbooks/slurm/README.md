Description
===========
Installs Slurm on CentOS 6.5 and Ubuntu 14.04

Requirements
============

Attributes
==========
If no attributes are specified then Slurm is installed to /usr/local.

* `default["slurm"]["version"]` - Default Slurm version
* `default["slurm"]["download_url"]` - Slurm download url
* `default["slurm"]["download_dir"]` - Directory to download source tarball
* `default["slurm"]["checksum"]` - Slurm tarball checksum
* `default["slurm"]["prefix"]` - configure prefix
* `default["slurm"]["sysconfdir"]` - Slurm sysconfdir
* `default["slurm"]["user"]` - Slurm user account
* `default["slurm"]["uid"]` - Slurm user id 
* `default["slurm"]["group"]` - Slurm application group
* `default["slurm"]["gid"]` - Slurm group id 

Usage
=====
recipe["slurm"] - Installs Slurm from source (tested on CentOS 6.5)

recipe["slurm::package"] - Installs Slurm from .rpm or .deb packages
For CentOS 6.5
* ["slurm"]["sysconfdir"] = "/etc/slurm"

For Ubuntu 14.04
* ["slurm"]["sysconfdir"] = "/etc/slurm-llnl"

recipe["slurm::create_rpm"] - Creates .rpm files to be used by slurm::packages

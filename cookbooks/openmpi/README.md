Description
===========
Installs Open MPI on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then Open MPI is installed to /usr/local.

default["openmpi"]["version"] - Open MPI version
default["openmpi"]["download_url"] - Open MPI download url
default["openmpi"]["download_dir"] - Directory to download to
default["openmpi"]["checksum"] - Checksum of downloaded tarball
default["openmpi"]["prefix"] - configure prefix directory

Usage
=====
recipe["openmpi"]

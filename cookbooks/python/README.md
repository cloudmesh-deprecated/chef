Description
===========
Installs Python on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then Python is installed to /usr/local.

* `default["python"]["version"]` - Python version
* `default["python"]["download_url"]` - Python download url
* `default["python"]["download_dir"]` - Directory to download to
* `default["python"]["checksum"]` - Checksum of downloaded tarball
* `default["python"]["prefix"]` - configure prefix directory

Usage
=====
recipe["python"]

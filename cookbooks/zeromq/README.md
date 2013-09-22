Description
===========
Installs ZeroMQ on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then ZeroMQ is installed to /usr/local.

* `default["zeromq"]["version"]` - ZeroMQ version
* `default["zeromq"]["download_url"]` - ZeroMQ download url
* `default["zeromq"]["download_dir"]` - Directory to download to
* `default["zeromq"]["checksum"]` - Checksum of downloaded tarball
* `default["zeromq"]["prefix"]` - configure prefix directory

Usage
=====
recipe["zeromq"]

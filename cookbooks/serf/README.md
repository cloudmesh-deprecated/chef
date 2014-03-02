Description
===========
Installs Serf on CentOS 6.5

Requirements
============

Attributes
==========
If no attributes are specified then Serf is installed to /usr/local.

* `default["serf"]["version"]` - Serf version
* `default["serf"]["download_url"]` - Serf download url
* `default["serf"]["download_dir"]` - Directory to download to
* `default["serf"]["checksum"]` - Checksum of downloaded tarball
* `default["serf"]["prefix"]` - configure prefix directory

Usage
=====
recipe["serf"]

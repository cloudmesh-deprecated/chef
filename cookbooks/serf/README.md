Description
===========
Installs Serf on CentOS 7.x

Requirements
============

Attributes
==========
If no attributes are specified then Serf is installed to /usr/local.

* `default["serf"]["version"]` - Serf version
* `default["serf"]["download_url"]` - Serf download url
* `default["serf"]["checksum"]` - Checksum of downloaded tarball
* `default["serf"]["prefix"]` - Install prefix (defaults to "/usr/local")
* `default["serf"]["config_dir"]` - Directory for config files (defaults to "/etc/serf/conf.d")

Usage
=====
recipe["serf"]

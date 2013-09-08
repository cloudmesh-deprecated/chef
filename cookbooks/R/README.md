Description
===========
Installs R on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then R is installed to /usr/local.

* `default["R"]["version"]` - Default R version
* `default["R"]["download_url"]` - R download url
* `default["R"]["download_dir"]` - Directory to download source tarball
* `default["R"]["checksum"]` - R tarball checksum
* `default["R"]["prefix"]` - configure prefix

Usage
=====
recipe["R"]

Description
===========
Installs CMake on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then CMake is installed to /usr/local.

* `default["cmake"]["version"]` - CMake version
* `default["cmake"]["download_url"]` - CMake download url
* `default["cmake"]["download_dir"]` - Directory to download to
* `default["cmake"]["checksum"]` - Checksum of downloaded tarball
* `default["cmake"]["prefix"]` - configure prefix directory

Usage
=====
recipe["cmake"]

Description
===========
Installs Apache Maven on CentOS 6.5

Requirements
============

Attributes
==========
If no attributes are specified then Maven is installed to /usr/local.

* `default["maven"]["version"]` - Maven version
* `default["maven"]["download_url"]` - Maven download url
* `default["maven"]["download_dir"]` - Directory to download to
* `default["maven"]["checksum"]` - Checksum of downloaded tarball
* `default["maven"]["prefix"]` - configure prefix directory

Usage
=====
recipe["maven"]

Description
===========
Installs collectd on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then collectd is installed to /usr.

* `default["colllectd"]["version"]` - collectd version
* `default["colllectd"]["download_url"]` - collectd download url
* `default["colllectd"]["download_dir"]` - Directory to download to
* `default["colllectd"]["checksum"]` - Checksum of downloaded tarball
* `default["colllectd"]["prefix"]` - configure prefix directory

Usage
=====
recipe["colllectd"]

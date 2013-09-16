Description
===========
Installs HDF5 on CentOS 6.4

Requirements
============

Attributes
==========
If no attributes are specified then HDF5 is installed to /usr/local.

* `default["hdf5"]["version"]` - HDF5 version
* `default["hdf5"]["download_url"]` - HDF5 download url
* `default["hdf5"]["download_dir"]` - Directory to download to
* `default["hdf5"]["checksum"]` - Checksum of downloaded tarball
* `default["hdf5"]["prefix"]` - configure prefix directory

Usage
=====
recipe["hdf5"]

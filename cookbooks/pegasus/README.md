Description
===========
Installs Pegasus (http://pegasus.isi.edu/) via RPM using the Pegasus repo.
Condor must be installed separately.

Requirements
============
Currently, the recipe has been created for RHEL, Centos, and Scientific Linux.

Attributes
==========
The version can be specified; however, the cookbook has a version configured by default.
See attributes/default.rb to get the version number.

Usage
=====
{"run_list": "recipe[pegasus]"}

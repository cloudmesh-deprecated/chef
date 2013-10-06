Description
===========
Installs IPython on CentOS 6.4

Requirements
============

Attributes
==========
Installs IPython in same location as Python's `bin` dir.

* `default["ipython"]["user"]` - IPython notebook user
* `default["ipython"]["group"]` - IPython notebook group
* `default["ipython"]["home_dir"]` - IPython user home directory
* `default["ipython"]["profile_name"]` - IPython profile name to use.
* `default["ipython"]["profile_dir"]` - IPython profile directory
* `default["ipython"]["notebook_password"]` - IPython notebook password.
  See [public server](http://ipython.org/ipython-doc/stable/interactive/public_server.html) on how to generate the password hash.

Usage
=====
`recipe["ipython"]` - Installs base IPython
`recipe["ipython::public_notebook"]` - Installs a public IPython notebook.

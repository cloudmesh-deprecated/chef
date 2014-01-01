Description
===========
Installs the Big Data MOOC on CentOS 6.5

Requirements
============

Attributes
==========
If no attributes are specified then the Big Data MOOC IPython notebooks are installed to /home/ipynb under ipynb:ipynb ownership.

* `default["bigdata_mooc"]["tmp_dir"]` - The temporary directory to download the IPython notebooks.
* `default["bigdata_mooc"]["repo_url"]` - The Git repository URL for the IPython notebooks.
* `default["bigdata_mooc"]["notebook_dir"]` - The IPython notebook directory.
* `default["bigdata_mooc"]["user"]` - The user/owner of the notebook files.
* `default["bigdata_mooc"]["group"]` - The group owner of the notebook files.

Usage
=====
recipe["bigdata_mooc"]

Useful Chef Tips
################

-----

Chef Overview
#############

Opscode provides an `overview <http://docs.opscode.com/chef_overview.html>`_ of the Chef architecture and concepts. 
It contains a lot of good information.

Three elements within Chef:

- Server
- Workstation
- Node

-----

Components within Chef Client Install
#####################################

Installing Chef Client will install the following Chef-related tools:

- `chef-client <http://docs.opscode.com/chef_client.html>`_
- `chef-solo <http://docs.opscode.com/chef_solo.html>`_
- `knife <http://docs.opscode.com/knife.html>`_
- `ohai <http://docs.opscode.com/ohai.html>`_

-----

Chef Resources
##############
Chef Resources are discussed here_ and here is a `bulleted list <http://docs.opscode.com/chef/resources.html#resources>`_.

**Useful Resources:**

.. table::

   ==============  ============
   cookbook_file_  package__
   directory_      remote_file_
   execute_        script_
   group_          user_
   ==============  ============

Use the ``package`` resource instead of executing ``yum install`` or ``apt-get install``

Use the ``remote_file`` resource to download remote files (e.g., tar.gz files).

Use the ``script`` resource to execute a script (e.g., bash script).

.. _here: http://docs.opscode.com/resource.html
.. _cookbook_file: http://docs.opscode.com/resource_cookbook_file.html
.. _directory: http://docs.opscode.com/resource_directory.html
.. _execute: http://docs.opscode.com/resource_execute.html
.. _group: http://docs.opscode.com/resource_group.html
.. _package: http://docs.opscode.com/resource_package.html
.. _remote_file: http://docs.opscode.com/resource_remote_file.html
.. _script: http://docs.opscode.com/resource_script.html
.. _user: http://docs.opscode.com/resource_user.html

-----

Use of Attributes
#################
Let's say we have a cookbook named `app`. We set the attributes in the `attributes/default.rb` file.
This allows default values to be set and for values to be set at run-time.

.. code:: bash
   
   $ cd cookbooks/app
   $ cat app/attributes/default.rb
   default["app"]["version"] = "1.2.3"
   default["app"]["download_url"] = "http://www.site.url/app-1.2.3.tar.gz"
   default["app"]["checksum"] = "a995524..."
   default["app"]["prefix"] = "/usr/local"

In the recipe, reference the attributes using the `node` variable.

.. code:: bash

   $ cat app/recipes/default.rb
   ...
   app_version = node["app"]["version"]
   app_download_url = node["app"]["download_url"]
   app_checksum = node["app][:checksum"]
   app_prefix = node["app"]["prefix"]
   ...

----

Cookbook Metadata
#################

The `metadata.rb` file contains cookbook metadata.
http://docs.opscode.com/essentials_cookbook_metadata.html

.. code:: bash

   $ cat metadata.rb 
   maintainer       "John Doe"
   maintainer_email "jdoe@email.url"
   license          "Apache v2.0"
   description      "Installs/Configures app"
   long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
   version          "0.1.0"

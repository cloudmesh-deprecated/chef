Getting Started with Chef
#########################

-----

Chef Versions
#############

There are two versions of Chef:
 - Chef Solo
   
   - Does not need a Chef Server
   - Cookbook(s) must be local on the machine

 - Chef Client and Chef Server

   - Chef Client must connect to Chef Server
   - Chef Server will provide cookbook(s)

-----

Boot Instance for Chef Solo
###########################

From this slide on, everything that starts with a `$` is a command to execute 
on the command line.

.. code:: bash

   # Let's boot an Ubuntu 12.04 instance.
   $ nova boot \
   --flavor "m1.small" --image "futuregrid/ubuntu-12.04" \
   --key_name "your_key" chef-client

   $ nova list
   +--------------+-------------+--------+---------------------+
   | ID           | Name        | Status | Networks            |
   +--------------+-------------+--------+---------------------+
   | de116a91-... | chef-client | ACTIVE | private=10.35.23.12 |
   +--------------+-------------+--------+---------------------+

   # Once in ACTIVE status, get IP address from nova list command
   # and ssh on to the VM.
   $ ssh -i ~/your_key.pem root@10.35.23.12

-----

Install and Verify Chef Client
##############################

.. code:: bash

   # Install Chef
   $ curl -L https://www.opscode.com/chef/install.sh | sudo bash

   ...
   Thank you for installing Chef!
   ...

   # Verify Installation
   $ which chef-client
   /usr/bin/chef-client
   
   $ which chef-solo
   /usr/bin/chef-solo
   
   $ which knife
   /usr/bin/knife
   
   $ which ohai
   /usr/bin/ohai

-----

Chef Solo Setup
###############

.. code:: bash

   # Create the dirs for the cookbooks and roles
   $ mkdir -p /var/chef/{cookbooks,roles}

   # Create the dir for the solo.rb file.
   $ mkdir -p /etc/chef

   # Populate the solo.rb file.
   $ cat << EOL > /etc/chef/solo.rb 
   log_location       STDOUT 
   file_cache_path    "/var/chef" 
   cookbook_path      [ "/var/chef/cookbooks" ] 
   role_path          [ "/var/chef/roles" ] 
   Mixlib::Log::Formatter.show_time = true 
   EOL

-----

Chef Solo helloworld Cookbook
#############################

.. code:: bash

   $ cd /var/chef/cookbooks
   $ knife cookbook create helloworld
   ...
   ** Creating metadata for cookbook: helloworld
   $ cd helloworld/recipes/
  
.. code:: ruby

   # Add the following content to the default.rb file.
   execute "say hello" do
     command "echo 'Chef-Solo hello'"
   end

.. code:: bash

   # Create a JSON file to run the default helloworld recipe.
   # Run chef-solo and use the run list from the JSON file.
   $ echo '{ "run_list": "recipe[helloworld]" }' > ~/run_list.json
   $ chef-solo -j ~/run_list.json

   ...
       - execute echo 'Chef-Solo hello'

-----

Boot Instance for Chef Server
#############################

.. code:: bash

   # Let's boot another Ubuntu 12.04 instance.
   $ nova boot \
   --flavor "m1.small" --image "futuregrid/ubuntu-12.04" \
   --key_name "your_key" chef-server

   $ nova list
   +--------------+-------------+--------+---------------------+
   | ID           | Name        | Status | Networks            |
   +--------------+-------------+--------+---------------------+
   | 8cfe8192-... | chef-server | ACTIVE | private=10.35.23.43 |
   +--------------+-------------+--------+---------------------+

   # Once in ACTIVE status, get IP address from nova list command
   # and ssh on to the VM.
   $ ssh -i ~/your_key.pem root@10.35.23.43

-----

Install and Verify Chef Server
##############################

.. code:: bash

   $ DOWNLOAD_URL='https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb'
   $ PACKAGE_NAME='chef-server.deb'

   $ cd /tmp
   $ curl -o ${PACKAGE_NAME} ${DOWNLOAD_URL}
   $ sudo dpkg -i ${PACKAGE_NAME}
   $ sudo chef-server-ctl reconfigure

   ...
   chef-server Reconfigured!

-----

Install Chef Client on the Server
#################################

.. code:: bash

   # Let's put Chef Client on the Server as well.
   $ curl -L https://www.opscode.com/chef/install.sh | sudo bash

   $ mkdir ~/.chef
   # NOTE: Replace chef-server with your host name
   #       for the chef_server_url value.
   $ cat << EOL > ~/.chef/knife.rb 
   log_level                :info
   log_location             STDOUT
   node_name                'admin'
   client_key               '/etc/chef-server/admin.pem'
   chef_server_url          'https://chef-server'
   cache_type               'BasicFile'
   cache_options( :path => '/root/.chef/checksums' )
   EOL

   # Verify knife is setup properly
   $ knife client list
   chef-validator
   chef-webui

-----

Chef Server helloworld Cookbook
###############################

.. code:: bash

   $ mkdir -p /var/chef/{cookbooks,roles} 
   $ cd /var/chef/cookbooks
   $ knife cookbook create helloworld

   ...
   ** Creating metadata for cookbook: helloworld
   $ cd helloworld/recipes/
                 
   .. code:: ruby

   # Add the following content to the default.rb file.
   execute "say hello" do
     command "echo 'Chef-Server hello'"
   end

   $ cd /var/chef/cookbooks
   $ knife cookbook upload helloworld
   $ knife cookbook list
   helloworld   0.1.0

-----

Connect Chef Client to Server
#############################

.. code:: bash

   # NOTE: Make sure the Chef Client can ping the Chef Server host name.
   #       Get the IP address and use the name from nova boot above.
   $ echo '' >> /etc/hosts
   $ echo '10.35.23.43 chef-server.novalocal chef-server' >> /etc/hosts
   
   # Verify
   $ ping -c 1 chef-server
   PING chef-server (10.35.23.43) 56(84) bytes of data.
   ...
   --- chef-server ping statistics ---
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 0.422/0.422/0.422/0.000 ms

-----

Configure Chef Client for Server
################################

Copy the `/etc/chef-server/chef-validator.pem` on the Chef Server to
`/etc/chef/validation.pem` on the Chef Client.

.. code:: bash

   cat << EOL > /etc/chef/client.rb
   log_location             STDOUT
   node_name                'chef-client'
   chef_server_url          'https://chef-server'
   EOL

   # Notice the contents of the /etc/chef directory.
   $ ls /etc/chef/
   client.rb  solo.rb  validation.pem

   $ chef-client
   ...
   Chef Client finished, 0 resources updated

The Chef Client connected to the Chef Server.
The Chef Server registered the client and provided a client.pem file

.. code:: bash

   $ ls /etc/chef/
   client.pem  client.rb  solo.rb  validation.pem

-----

Verify Chef Setup with knife
############################

.. code:: bash

   $ mkdir ~/.chef

   $ cat << EOL > ~/.chef/knife.rb
   log_level                :info
   log_location             STDOUT
   node_name                'chef-client'
   client_key               '/etc/chef/client.pem'
   chef_server_url          'https://chef-server'
   cache_type               'BasicFile'
   cache_options( :path => '/root/.chef/checksums' )
   EOL

   # This command will display all of the nodes registered
   # with the Chef Server.
   $ knife node list
   chef-client

-----

Two Different helloworld Recipes
################################

.. code:: bash

   $ chef-solo -j ~/run_list.json 
   Starting Chef Client, version 11.6.0
   ...
   Recipe: helloworld::default
     * execute[say hello] action run
       - execute echo 'Chef-Solo hello'

   Chef Client finished, 1 resources updated
   
   $ chef-client -j ~/run_list.json 
   Starting Chef Client, version 11.6.0
   ...
   Recipe: helloworld::default
     * execute[say hello] action run
       - execute echo 'Chef-Server hello'

   Chef Client finished, 1 resources updated

Notice the difference in messages. One recipe ran from the Chef Solo local ``/var/chef/cookbook`` directory.
The other cookbook was downloaded from the Chef Server and executed.

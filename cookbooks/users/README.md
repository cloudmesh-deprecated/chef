Description
===========
Creates one or more local users based on the data stored in the "users" attribute.


Requirements
============
For Red Hat Enterprise Linux (RHEL), CentOS, and Scientific Linux (SL) platforms the epel recipe
will be run to install ruby_shadow.

A group name is required. The group recipe can be used to create this group.

See Opscode information on how to create the password in the "Password Shadow Hash" sub-section
under the User resource section (http://wiki.opscode.com/display/chef/Resources#Resources-User).

Attributes
==========
users: A list of objects (associative arrays).
       Each object contains the data needed to configure a user.
       See Usage section.

Usage
=====
This example creates one group named "jon" within the "users" group.

{"run_list": "recipe[users]",
 "users": [{"name": "jon", 
            "id": "2001",
            "group": "users", 
            "home_dir": "/home/jon",
            "shell": "/bin/bash",
            "password": "$1$RNy1FZ0135792468.."}]}

Similarly, two users "foo" and "bar":
{"run_list": "recipe[users]",
 "users": [{"name": "foo", 
            "id": "2002",
            "group": "users", 
            "home_dir": "/home/foo",
            "shell": "/bin/bash",
            "password": "$1$RNy1FZ1234567890.."},
           {"name": "bar", 
            "id": "2003",
            "group": "users", 
            "home_dir": "/home/bar",
            "shell": "/bin/bash",
            "password": "$1$RNy1FZ0987654321.."}]}

Description
===========
Creates one or more local groups based on the data stored in the "groups" attribute.

Requirements
============
The groups attribute must contain name and id values to create a group.

Attributes
==========
groups: A list of objects (associative arrays).
        Each object contains two keys: "name" and "id".
        See the Usage section.

Usage
=====
This example creates one group named "users" with a group id 2000.
{"run_list": "recipe[groups]", 
 "groups": [{"name": "users", "id": "2000"}]}

This example creates two groups: "foo" and "bar".
{"run_list": "recipe[groups]", 
 "groups": [{"name": "foo", "id": "2000"},
            {"name": "bar", "id": "2001"}]}

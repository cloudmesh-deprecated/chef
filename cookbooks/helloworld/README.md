Description
===========
This is a very simple 'Hello World' recipe to get people started with Chef.
If the recipe is excuted with no attributes then it will echo 'Hello World'.
If an attribute named 'message' is provided with a string value then the
recipe will display it.

Requirements
============
No requirements.

Attributes
==========
message: This is an optional string attribute. If not provided then 
         'Hello World' is used by default.

Usage
=====
{"run_list": "recipe[helloworld]"}
# This will output 'Hello World'

or 

{"run_list": "recipe[helloworld]",
 "message": "Second Message"}
# This will output 'Second Message'

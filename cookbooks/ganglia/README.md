Description
===========
Installs Ganglia on CentOS 6.5

Requirements
============

Attributes
==========
For `recipe["ganglia"]` the following attributes:
* `default["ganglia"]["name"]` - The name of the cluster
* `default["ganglia"]["port"]` - The port
* `default["ganglia"]["receiver_name"]` - gmetad server name

For `recipe["ganglia::receiver"] the following attribute:
* `default["ganglia"]["data_sources"]` - A hash. Each key contains a data source name (e.g., "my_cluster"). 
  Each value is a hash with the `host` and `port`. For example, `"my_cluster" => { "host" => "headnode", "port" => "8601" }`.

Usage
=====
* `recipe["ganglia"]` - for Ganglia gmond
* `recipe["ganglia::receiver"]` - for Ganglia gmetad and httpd

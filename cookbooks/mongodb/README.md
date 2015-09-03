mongodb Cookbook
================
MongoDB cookbook

Set up a MongoDB cluster based on the information found at this [page](http://docs.mongodb.org/manual/core/sharded-cluster-architectures-production/)

Requirements
------------
CentOS 7.x

Attributes
----------
e.g.
#### mongodb::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["mongodb"]["config_dbs"]</tt></td>
    <td>List</td>
    <td>List of Config Servers</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>["mongodb"]["shard_port"]</tt></td>
    <td>Int</td>
    <td>Port for Shard server</td>
    <td><tt>27017</tt></td>
  </tr>
  <tr>
    <td><tt>["mongodb"]["shard_role"]</tt></td>
    <td>String</td>
    <td>Shard server role (primary or secondary)</td>
    <td><tt>primary</tt></td>
  </tr>
</table>

Usage
-----
`mongodb::config_server` - Sets up the Config Servers. Need three of these for production setup.

`mongodb::router` - Sets up the Router. It will need a list of Config Servers via `["mongodb"]["config_dbs"]` attribute.

`mongodb::repo` - Used by other recipes to setup the Yum repo.

`mongodb::shard` - Sets up the Shard/Replica Set. One server will be the primary to initiate the replicate. The other(s) will have a secondary role. 

License and Authors
-------------------
Authors: Jonathan Klinginsmith

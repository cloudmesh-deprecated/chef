postgresql Cookbook
===================
Installs and configures Postgres 9.4 

Requirements
------------
CentOS 7.x

Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['postgresql']['download_url']</tt></td>
    <td>String</td>
    <td>URL of pgdg RPM</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['postgresql']['checksum']</tt></td>
    <td>String</td>
    <td>SHA 256 checkum of pgdg RPM</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['postgresql']['version']</tt></td>
    <td>String</td>
    <td>Postgres version</td>
    <td>9.4</td>
  </tr>
  <tr>
    <td><tt>['postgresql']['server_rpm']</tt></td>
    <td>String</td>
    <td>Name of the Postgres server RPM</td>
    <td>postgresql94-server</td>
  </tr>
</table>

Usage
-----
```json
{
  "run_list": [
    "recipe[postgresql]"
  ]
}
```

License and Authors
-------------------
Authors: Jonathan Klinginsmith

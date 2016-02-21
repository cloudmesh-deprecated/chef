spark Cookbook
==============
Apache Spark cookbook

Requirements
------------
CentOS 7.x

Attributes
----------
`spark::default` attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['spark']['download_url']</tt></td>
    <td>String</td>
    <td>URL for Spark bin tarball</td>
  </tr>
  <tr>
    <td><tt>['spark']['download_dir']</tt></td>
    <td>String</td>
    <td>Download directory for tarball</td>
  </tr>
  <tr>
    <td><tt>['spark']['checksum']</tt></td>
    <td>String</td>
    <td>SHA 256 checksum for tarball</td>
  </tr>
</table>

Usage
-----
`spark::default`

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[spark]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Jonathan Klinginsmith

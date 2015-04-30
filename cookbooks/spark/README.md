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
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['spark']['download_url']</tt></td>
    <td>String</td>
    <td>URL for Spark bin tarball</td>
    <td><tt>http://ftp.wayne.edu/apache/spark/spark-1.3.1/spark-1.3.1-bin-hadoop2.6.tgz</tt></td>
  </tr>
  <tr>
    <td><tt>['spark']['download_dir']</tt></td>
    <td>String</td>
    <td>Download directory for tarball</td>
    <td><tt>Chef::Config[:file_cache_path]</tt></td>
  </tr>
  <tr>
    <td><tt>['spark']['checksum']</tt></td>
    <td>String</td>
    <td>SHA 256 checksum for tarball</td>
    <td><tt>a25aa...</tt></td>
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

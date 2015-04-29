mesos Cookbook
==============
Apache Mesos cookbook

Requirements
------------
CentOS 7.x. This cookbook leverages Mesosphere&apos;s RPMs.

Attributes
----------
`mesos::master` attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[&quot;mesos&quot;][&quot;master_hostname&quot;]</tt></td>
    <td>String</td>
    <td>host name or private IP to be set in `/etc/mesos-master/hostname`</td>
    <td><tt>&quot;&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;mesos&quot;][&quot;repo_rpm_download_url&quot;]</tt></td>
    <td>String</td>
    <td>RPM download url</td>
    <td><tt>&quot;http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;mesos&quot;][&quot;repo_rpm_download_url&quot;]</tt></td> 
    <td>String</td>
    <td>Local location to download the RPM</td>
    <td><tt>File.join(Chef::Config[:file_cache_path], quot;mesosphere-el-repo-7-1.noarch.rpm&quot;)</tt></td>
  </tr>
</table>

Usage
-----
`mesos::master`

Example of running with:
* private IP: `10.1.2.3`
* zookeeper id: `1`
* cluster name: `dev`
* roles: `master` and `zookeeper`

The cluster name and master role are used with Chef search to find masters for this cluster.

```json
{ 
  "run_list": [
    "recipe[epel]",
    "recipe[mesos::master]"
  ],
  "mesos": 
  {
    "master_hostname": "10.1.2.3",
    "zookeeper_id": "1",
    "roles": ["master", "zookeeper"],
    "cluster_name": "dev"
  }
}
```

`mesos::slave`

Example of a slave node for cluster `dev`. Chef search will look for masters on the same cluster.

```json
{
  "run_list": [
    "recipe[epel]",
    "recipe[mesos::slave]"
  ],
  "mesos":
  {
    "roles": ["slave"],
    "cluster_name": "dev"
  }
}
```

Contributing
------------

License and Authors
-------------------
Jonathan Klinginsmith

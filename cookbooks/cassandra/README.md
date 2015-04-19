cassandra Cookbook
==================
Apache Cassandra cookbook

Requirements
------------
None

OpenJDK RPMs are leveraged for this cookbook. If one wants the Oracle JDK then this must be downloaded.

Attributes
----------
`cassandra::default` attributes:

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;broadcast_rpc_address&quot;]</tt></td>
    <td>String</td>
    <td>Broadcast RPC address - private IP or hostname</td>
    <td><tt>&quot;&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;cluster_name&quot;]</tt></td>
    <td>String</td>
    <td>Cluster name</td>
    <td><tt>&quot;Test Cluster&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;cluster_name&quot;]</tt></td>
    <td>String</td>
    <td>Configuration directory</td>
    <td><tt>&quot;/etc/cassandra/default.conf/&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;listen_address&quot;]</tt></td>
    <td>String</td>
    <td>Listen address - private IP or hostname</td>
    <td><tt>&quot;&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;rmi_server_hostname&quot;]</tt></td>
    <td>String</td>
    <td>RMI server host name - private IP or hostname</td>
    <td><tt>&quot;&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;rpc_address&quot;]</tt></td>
    <td>String</td>
    <td>RPC address</td>
    <td><tt>&quot;0.0.0.0&quot;</tt></td>
  </tr>
  <tr>
    <td><tt>[&quot;cassandra&quot;][&quot;seeds&quot;]</tt></td>
    <td>String</td>
    <td>Seeds - comma separate list of private IPs or host names.</td>
    <td><tt>&quot;&quot;</tt></td>
  </tr>
</table>

Usage
-----
cassandra::default

Include `cassandra` in your node's `run_list` and specify the address and hostname values:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cassandra]"
  ],
  "cassandra":
  {
    "broadcast_rpc_address": "10.1.2.4",
    "listen_address": "10.1.2.4",
    "rmi_server_hostname": "10.1.2.4",
    "seeds": "10.1.2.3"
  }
}
```

To verify, you can leverage the `nodetool status` command to see the node(s) added to the cluster.

Contributing
------------

License and Authors
-------------------
Authors: Jonathan Klinginsmith

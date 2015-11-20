munge Cookbook
==============
Installs munge on CentOS/RHEL

Requirements
------------


Attributes
----------


Usage
-----
#### munge::default
Just include `munge` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[munge]"
  ]
}
```

License and Authors
-------------------
Authors: Jonathan Klinginsmith

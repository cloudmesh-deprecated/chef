Description
===========
Sets up an instance to use the Extra Packages for Enterprise Linux (EPEL) repo.

Creates a new yum.repos.d file: /etc/yum.repos.d/epel.repo.

Requirements
============
Red Hat Enterprise Linux (RHEL), CentOS or Scientific Linux (SL) platform.

Attributes
==========
* `node["epel"]["download_url"]` - The download URL for the EPEL RPM.
* `node["epel"]["rpm_path"]` - The path where the EPEL will be stored.
* `node["epel"]["checksum"]` - sha265sum of the downloaded RPM

Usage
=====
{"run_list": "recipe[epel]"}

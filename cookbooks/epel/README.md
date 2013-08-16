Description
===========
Sets up an instance to use the Extra Packages for Enterprise Linux (EPEL) repo.

Creates a new rpm-gpg file: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL.
Createa a new yum.repos.d file: /etc/yum.repos.d/epel.repo.

Requirements
============
Red Hat Enterprise Linux (RHEL), CentOS or Scientific Linux (SL) platform.

Attributes
==========
None

Usage
=====
{"run_list": "recipe[epel]"}

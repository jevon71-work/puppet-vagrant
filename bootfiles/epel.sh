#!/bin/bash
#
yum remove -y -q epel-release
yum clean all
yum update -y
yum install -y -q epel-release
yum install -y -q screen bash-completion git python34
curl -O https://bootstrap.pypa.io/get-pip.py
/usr/bin/python3.4 get-pip.py

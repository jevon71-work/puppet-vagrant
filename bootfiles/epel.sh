#!/bin/bash
#
yum remove -y -q epel-release
yum clean all
yum update -y
yum install -y -q epel-release screen bash-completion

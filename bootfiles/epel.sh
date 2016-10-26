#!/bin/bash
#
yum remove -y -q epel-release
yum clean all
yum update -y
yum install -y -q epel-release
yum install -y -q screen bash-completion git python34 unzip wget tree
curl -O https://bootstrap.pypa.io/get-pip.py
/usr/bin/python3.4 get-pip.py
mkdir -p /var/staging

# Modify this section to match the latest Terraform release
wget -P /var/staging https://releases.hashicorp.com/terraform/0.7.7/terraform_0.7.7_linux_amd64.zip
mkdir -p /opt/terraform/ver_0.7.7
unzip -d /opt/terraform/ver_0.7.7 -u -o /var/staging/terraform_0.7.7_linux_amd64.zip
ln -s /opt/terraform/ver_0.7.7/terraform /opt/terraform/terraform-new

# Pull down lastest 0.6.x Terraform release - required to utilise the DHI shared Terraform code
wget -P /var/staging https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip
mkdir -p /opt/terraform/ver_0.6.16
unzip -d /opt/terraform/ver_0.6.16 -u -o /var/staging/terraform_0.6.16_linux_amd64.zip
ln -s /opt/terraform/ver_0.6.16/terraform /opt/terraform/terraform

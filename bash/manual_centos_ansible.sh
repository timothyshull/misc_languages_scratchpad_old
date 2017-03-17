#!/usr/bin/env bash

sudo yum -y install gcc
sudo yum -y install libffi-devel
sudo pip install paramiko PyYAML Jinja2 httplib2 six

git clone git://github.com/ansible/ansible.git --recursive
cd ansible/
source ./hacking/env-setup
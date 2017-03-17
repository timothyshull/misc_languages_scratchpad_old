#!/usr/bin/env bash

su - admin

sudo yum -y install readline-devel bzip2-devel sqlite-devel openssl-devel zlib-devel bzip2 sqlite gcc-c++ libffi libffi-devel

cd /tmp
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xvf Python-2.7.12.tgz
cd Python-2.7.12.tgz
./configure --prefix=/u/tools
make && make install

cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
/u/tools/bin/python2.7 get-pip.py

/u/tools/bin/pip2.7 install django django-simple-history bcrypt paramiko PyYAML Jinja2 httplib2 six pexpect netaddr dnspython
/u/tools/bin/pip2.7 install ansible==2.1

#!/bin/bash

crontab -l > /tmp/mycron
sed --in-place /resolv/d /tmp/mycron
crontab /tmp/mycron
if [[ -e /etc/resolv.conf.ori ]]; then sudo mv /etc/resolv.conf.ori /etc/resolv.conf;else service network restart;fi
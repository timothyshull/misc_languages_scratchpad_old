#!/bin/bash

crontab -l > /tmp/mycron
if [[ -e /etc/resolv.conf ]]; then sudo mv /etc/resolv.conf /etc/resolv.conf.ori;fi
echo "*/1 * * * * if [[ -e /etc/resolv.conf ]]; then mv /etc/resolv.conf /etc/resolv.conf.ori;fi" >> /tmp/mycron
crontab /tmp/mycron
#!/bin/bash

rm -f /etc/ssh/ssh_host_*
rm -rf /var/cache/yum/*
yum history new
journalctl --flush
journalctl --vacuum-size=0
rm -f /root/.bash_history
rm -f /home/install/.bash_history
find /var/log -type f -delete

#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cp /etc/hosts /etc/hosts.backup

cp update-net-hosts.sh /bin/update-net-hosts

update-net-hosts

(crontab -l 2>/dev/null; echo "@reboot /bin/update-net-hosts") | crontab -



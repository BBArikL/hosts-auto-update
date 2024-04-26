#!/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cp /etc/hosts "/etc/hosts-last.old"

cp /etc/hosts.backup /etc/hosts

TAG_VER="$(git ls-remote --tags --refs --sort="version:refname" https://github.com/StevenBlack/hosts.git | grep -E '/[0-9]+.[0-9]+.[0-9]+$' | awk -F/ 'END{print$NF}')"

curl "https://raw.githubusercontent.com/StevenBlack/hosts/$TAG_VER/hosts" >> /etc/hosts

sudo systemctl restart NetworkManager.service
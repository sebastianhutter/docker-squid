#!/bin/bash

# the local squid configuration file to be replaced / parsed
CONFIG_LOCAL="/etc/squid3/squid.conf"

# first check if the download url is set. if so try to download the file via curl
if [ -z "$CONFIG_URL" ]; then
  echo "No config url set. Will use local configuration file"
else
  echo "Config url is set. Download the configuration file"
  # now try to download the configuration file
  if [ -z "$CONFIG_USERNAME" ] || [ -z "$CONFIG_PASSWORD" ]; then
    # if no usename and password is specified
    curl "$CONFIG_URL" -o "$CONFIG_LOCAL"
    [ $? -ne 0 ] && exit 1
  else
    curl --user $CONFIG_USERNAME:$CONFIG_PASSWORD "$CONFIG_URL" -o "$CONFIG_LOCAL"
    [ $? -ne 0 ] && exit 1
  fi
fi

# run nginx
echo "Run squid"
/usr/sbin/squid3 -NYCd 1

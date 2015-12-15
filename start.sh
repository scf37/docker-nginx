#!/bin/bash

mkdir -p /data/conf
cp -rn /opt/conf/* /data/conf/

cp -r /data/conf/* /etc/nginx/

mkdir -p /data/data/proxy_temp
mkdir -p /data/logs

exec /usr/share/nginx/sbin/nginx $@
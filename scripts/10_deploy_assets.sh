#!/usr/bin/env bash
mkdir -p /opt/hmpps/proxy-scripts/
mv /tmp/assets/runtime_helper_scripts/* /opt/hmpps
mv /tmp/assets/other_files/aliases /opt/hmpps

chown -R centos /opt/hmpps



mv /tmp/assets/nginx_config_files/* /etc/nginx/

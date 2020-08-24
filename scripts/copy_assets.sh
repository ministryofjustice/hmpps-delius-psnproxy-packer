#!/usr/bin/env bash

mkdir -p /opt/hmpps/proxy-scripts/
PATH=/opt/hmpps/proxy-scripts/:$PATH
PATH=/opt/hmpps/proxy-scripts/pre-prod:$PATH
PATH=/opt/hmpps/proxy-scripts/production:$PATH
PATH=/opt/hmpps/proxy-scripts/stage:$PATH


cp -R assets/runtime_helper_scripts/* /opt/hmpps/proxy-scripts/
cp assets/nginx_config_files/* /etc/nginx/conf.d/


chown -R centos /opt/hmpps

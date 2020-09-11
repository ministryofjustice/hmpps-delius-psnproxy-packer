#!/usr/bin/env bash
mkdir -p /opt/hmpps/proxy-scripts/
mv /tmp/assets/runtime_helper_scripts/* /opt/hmpps
chown -R centos /opt/hmpps

cat << EOF >> /root/.bashrc
PATH=/opt/hmpps/proxy-scripts/:$PATH
PATH=/opt/hmpps/proxy-scripts/pre-prod:$PATH
PATH=/opt/hmpps/proxy-scripts/production:$PATH
PATH=/opt/hmpps/proxy-scripts/stage:$PATH

EOF


mv /tmp/assets/nginx_config_files/* /etc/nginx/


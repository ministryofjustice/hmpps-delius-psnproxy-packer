#!/usr/bin/env bash
mkdir -p /opt/hmpps/proxy_scripts/
mv /tmp/assets/runtime_helper_scripts/* /opt/hmpps/proxy_scripts
mv /tmp/assets/other_files/aliases /opt/hmpps

chown -R ec2-user /opt/hmpps

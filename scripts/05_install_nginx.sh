#!/usr/bin/env bash

sudo -i

sudo yum update -y
sudo yum install -y nginx

sudo systemctl enable nginx.service


# copy ca-bundle.crt which includes LetsEncrypt and other Root certs
if [ -d /etc/pki/tls/certs ]; then
    echo "/etc/pki/tls/certs already exists" ;
else
    mkdir -p /etc/pki/tls/certs
    echo "/etc/pki/tls/certs directory created"
fi

cp /tmp/assets/ssl/ca-bundle.crt /etc/pki/tls/certs/ca-bundle.crt

# copy nginx configs for IM, IAPS, SPG
#mkdir -p /etc/nginx/
#mv /tmp/assets/nginx_config_files/* /etc/nginx/

mkdir -p /etc/nginx/conf.d

# nginx core configs
cp /tmp/assets/nginx_config_files/nginx.conf /etc/nginx/nginx.conf
cp /tmp/assets/nginx_config_files/proxy_params /etc/nginx/proxy_params
cp /tmp/assets/nginx_config_files/ssl_params /etc/nginx/ssl_params

# spg-proxy-sandpit
# cp /tmp/assets/nginx_config_files/dev-conf.d/spg-proxy-sandpit-ext.conf /etc/nginx/conf.d/spg-proxy-sandpit-ext.conf
# cp /tmp/assets/nginx_config_files/dev-conf.d/spg-proxy-sandpit-int.conf /etc/nginx/conf.d/spg-proxy-sandpit-int.conf

#spg-proxy-preprod
cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-preprod-ext.conf /etc/nginx/conf.d/spg-proxy-preprod-ext.conf
cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-preprod-int.conf /etc/nginx/conf.d/spg-proxy-preprod-int.conf

#spg-proxy-production
cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-production-ext.conf /etc/nginx/conf.d/spg-proxy-production-ext.conf
cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-production-int.conf /etc/nginx/conf.d/spg-proxy-production-int.conf

#spg-proxy-staging
#cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-stage-ext.disabledconf /etc/nginx/conf.d/spg-proxy-stage-ext.disabledconf
#cp /tmp/assets/nginx_config_files/prod-conf.d/spg-proxy-stage-int.disabledconf /etc/nginx/conf.d/spg-proxy-stage-int.disabledconf

# im-proxy stage
cp /tmp/assets/nginx_config_files/dev-conf.d/im-proxy-stage.conf /etc/nginx/conf.d/im-proxy-stage.conf

# im-proxy prod
cp /tmp/assets/nginx_config_files/prod-conf.d/im-proxy.conf /etc/nginx/conf.d/im-proxy.conf

# server-names
cp /tmp/assets/nginx_config_files/prod-conf.d/server-names.conf /etc/nginx/conf.d/server-names.conf

tree /etc/nginx
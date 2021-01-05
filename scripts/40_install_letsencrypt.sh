#!/usr/bin/env bash

sudo -i

# install letsencrypt certbot-nginx
echo '*** installing epel via amazon-linux-extras..'
sudo amazon-linux-extras install -y epel 

echo '*** yum update..'
sudo yum update -y

echo '*** installing certbot-nginx..'
sudo yum install -y certbot-nginx

# copy config file for psn cert.
cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf


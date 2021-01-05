#!/usr/bin/env bash

sudo -i

# install letsencrypt certbot-nginx
sudo yum install -y epel-release
sudo yum install -y certbot-nginx
sudo yum install -y tree

cd /etc/letsencrypt
tree

# copy config file for psn cert.
# cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf


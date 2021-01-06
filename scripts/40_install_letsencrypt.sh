#!/usr/bin/env bash

sudo -i

# remove pip installed urllib3 as it conflicts with certbot
sudo pip uninstall urllib3 -y


yum reinstall -y ca-certificates python-urllib3 python-requests pyOpenSSL

# install letsencrypt certbot-nginx
sudo yum install -y epel-release
sudo yum install -y certbot-nginx
sudo yum install -y tree

certbot --help

# copy config file for psn cert.
# cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf


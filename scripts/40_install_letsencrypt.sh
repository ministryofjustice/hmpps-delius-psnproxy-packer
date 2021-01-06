#!/usr/bin/env bash

sudo -i

# remove pip installed urllib3 as it conflicts with certbot
#sudo pip uninstall urllib3 -y
#sudo yum reinstall -y ca-certificates python-urllib3 python-requests pyOpenSSL
#sudo yum install -y python-cryptography

# install letsencrypt certbot-nginx
sudo yum install -y epel-release
sudo yum install -y certbot-nginx
sudo yum install -y tree

# sudo pip uninstall -y pyopenssl
# sudo pip uninstall -y cryptography
# sudo pip install pyopenssl
# sudo pip install cryptography

certbot --help

cd /etc/
ll letsencrypt

tree /etc/letsencrypt

# copy config file for psn cert.
# cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf


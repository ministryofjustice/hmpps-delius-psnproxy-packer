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

# show certbot help to show it's installed ok (we sometimes get python errors)
certbot --help

mkdir -p /etc/letsencrypt/accounts
mkdir -p /etc/letsencrypt/archive/psn.probation.service.justice.gov.uk
mkdir -p /etc/letsencrypt/csr
mkdir -p /etc/letsencrypt/keys
mkdir -p /etc/letsencrypt/live/psn.probation.service.justice.gov.uk
mkdir -p /etc/letsencrypt/renewal
mkdir -p /etc/letsencrypt/renewal-hooks/deploy
mkdir -p /etc/letsencrypt/renewal-hooks/post
mkdir -p /etc/letsencrypt/renewal-hooks/pre

# copy config file for psn cert.
cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf

tree /etc/letsencrypt

# create a cron job to auto-renew check the SSL cert every 12 hours
cat << 'EOF' >> /etc/cron.d/letsencrypt-renew
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 */12 * * * root certbot renew --dns-route53 --non-interactive --post-hook "service nginx reload"
EOF

sudo systemctl restart crond.service

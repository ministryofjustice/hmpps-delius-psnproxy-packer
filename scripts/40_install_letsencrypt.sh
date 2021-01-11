#!/usr/bin/env bash

sudo -i

echo '========================================'
echo 'install letsencrypt certbot-nginx'
echo '========================================'
sudo yum install -y epel-release
sudo yum install -y certbot-nginx
sudo yum install -y tree

echo '========================================'
echo 'show certbot help to show its installed ok (we sometimes get python errors)'
echo '========================================'
certbot --help

echo '========================================'
echo 'creating /etc/letsencrypt folder structure'
echo '========================================'
mkdir -p /etc/letsencrypt/accounts
mkdir -p /etc/letsencrypt/archive/psn.probation.service.justice.gov.uk
mkdir -p /etc/letsencrypt/csr
mkdir -p /etc/letsencrypt/keys
mkdir -p /etc/letsencrypt/live/psn.probation.service.justice.gov.uk
dir -p /etc/letsencrypt/renewal
mkdir -p /etc/letsencrypt/renewal-hooks/deploy
mkdir -p /etc/letsencrypt/renewal-hooks/post
mkdir -p /etc/letsencrypt/renewal-hooks/pre

echo '========================================'
echo 'copy config file for psn cert.'
echo '========================================'
cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf

echo '========================================'
echo 'copy certbot cert renewal script'
echo '========================================'
mkdir -p /opt/hmpps/scripts
cp /tmp/scripts/letsencrypt-renew.sh /opt/hmpps/scripts/letsencrypt-renew.sh
chmod +x /opt/hmpps/scripts/letsencrypt-renew.sh
chown -R root:root /opt/hmpps/scripts

echo '========================================'
echo 'install the certbot route53 plugin'
echo '========================================'
pip3 install certbot-dns-route53
certbot plugins

echo '========================================'
echo 'create a cron job to auto-renew check the SSL cert every 12 hours'
echo '========================================'
cat << 'EOF' >> /etc/cron.d/letsencrypt-renew
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 */12 * * * root /opt/hmpps/scripts/letsencrypt-renew.sh
EOF

cat /etc/cron.d/letsencrypt-renew

echo '========================================'
echo 'restart crond.service'
echo '========================================'
sudo systemctl restart crond.service



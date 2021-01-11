#!/usr/bin/env bash

sudo -i

#========================================
# install letsencrypt certbot-nginx
#========================================
sudo yum install -y epel-release
sudo yum install -y certbot-nginx
sudo yum install -y tree

#========================================
# show certbot help to show it's installed ok (we sometimes get python errors)
#========================================
certbot --help

# mkdir -p /etc/letsencrypt/accounts
# mkdir -p /etc/letsencrypt/archive/psn.probation.service.justice.gov.uk
# mkdir -p /etc/letsencrypt/csr
# mkdir -p /etc/letsencrypt/keys
# mkdir -p /etc/letsencrypt/live/psn.probation.service.justice.gov.uk
# mkdir -p /etc/letsencrypt/renewal
# mkdir -p /etc/letsencrypt/renewal-hooks/deploy
# mkdir -p /etc/letsencrypt/renewal-hooks/post
# mkdir -p /etc/letsencrypt/renewal-hooks/pre

#========================================
# copy config file for psn cert.
#========================================
#cp /tmp/assets/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf /etc/letsencrypt/renewal/psn.probation.service.justice.gov.uk.conf

#========================================
# copy certbot cert renewal script
#========================================
mkdir -p /opt/hmpps/scripts
cp /tmp/scripts/letsencrypt-renew.sh /opt/hmpps/scripts/letsencrypt-renew.sh
chmod +x /opt/hmpps/scripts/letsencrypt-renew.sh
chown -R root:root /opt/hmpps/scripts

#========================================
# install the certbot route53 plugin
#========================================
pip3 install certbot-dns-route53
certbot plugins

#========================================
# create a cron job to auto-renew check the SSL cert every 12 hours
#========================================

# cat << 'EOF' >> /etc/cron.d/letsencrypt-renew
# SHELL=/bin/sh
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# 0 */12 * * * root certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email awssupportteam@digital.justice.gov.uk --domains *.psn.probation.service.justice.gov.uk
# 5 */12 * * * root certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email awssupportteam@digital.justice.gov.uk --domains *.stage.probation.service.justice.gov.uk
# EOF

cat << 'EOF' >> /etc/cron.d/letsencrypt-renew
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 */12 * * * root /opt/scripts/letsencrypt-renew.sh
EOF

#========================================
# restart service
#========================================
sudo systemctl restart crond.service



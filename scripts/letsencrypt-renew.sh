
#!/usr/bin/env bash

# This script renews LetsEncrypt Certificates for:
#   *.psn.probation.service.justice.gov.uk with Route53 DNS managed in PSN AWS Account (581911240951)
#   *.stage.probation.service.justice.gov.uk with Route53 DNS managed in delius-stage AWS Account (205048117103)
# 
# Certificate Validation is via the certbot-route53 plugin which creates a TXT record to validate domain ownership with the LetsEncrypt certbot
#
# This script:
#   - renews the *.psn.probation.service.justice.gov.uk certificate using the current Instance Profile Credentials
#   - assumes LetsEncryptRoute53ValidationRole role in the delius-stage account with the required IAM Route53 permissions 
#     to renew *.stage.probation.service.justice.gov.uk certificate 

function unassumerole {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    env | grep AWS
}

function assumerole {

    echo "*** Current IAM Role details..."
    aws sts get-caller-identity

    echo "*** Assuming role arn:aws:iam::${1}:role/LetsEncryptRoute53ValidationRole ..."
    assumedrole=$(aws sts assume-role --role-arn "arn:aws:iam::${1}:role/LetsEncryptRoute53ValidationRole" --role-session-name AWSCLI-Session)

    export AWS_ACCESS_KEY_ID=$(echo $assumedrole | jq -r '.Credentials.AccessKeyId')
    export AWS_SECRET_ACCESS_KEY=$(echo $assumedrole | jq -r '.Credentials.SecretAccessKey')
    export AWS_SESSION_TOKEN=$(echo $assumedrole | jq -r '.Credentials.SessionToken')
    env | grep AWS

    echo "*** Assumed IAM Role details..."
    aws sts get-caller-identity
}

# email to attach to cert account
email=awssupportteam@digital.justice.gov.uk

# PSN AWS Account
psnproxydomains=*.psn.probation.service.justice.gov.uk

# delius-stage AWS Account
deliusstageaccountid=205048117103
deliusstagedomains=*.stage.probation.service.justice.gov.uk

echo "------------------------------------------------------------------------------------------"
echo "run the certbot to renew/create ssl certificate for *.psn.probation.service.justice.gov.uk"
echo "------------------------------------------------------------------------------------------"
certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email $email --domains $psnproxydomains

echo "----------------------------------------------------------------------------------------------------------------"
echo "assume stage role & run the certbot to renew/create ssl certificate for *.stage.probation.service.justice.gov.uk"
echo "----------------------------------------------------------------------------------------------------------------"
unassumerole
assumerole $deliusstageaccountid
certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email $email --domains $deliusstagedomains

systemctl status nginx
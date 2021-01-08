
#!/usr/bin/env bash

# This script assumes a role in the delius-stage and delius-prod accounts with the required IAM Route53 permissions 
# to create TXT record to validate domain ownership with the LetsEncrypt certbot


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


email=awssupportteam@digital.justice.gov.uk

deliusprodaccountid=050243167760
deliusproddomains=*.probation.service.justice.gov.uk

deliusstageaccountid=205048117103
deliusstagedomains=*.stage.probation.service.justice.gov.uk

echo "--------------------------------------------------------------------------------------"
echo "assume prod role & run the certbot to renew/create ssl certificate for delius-prod"
echo "--------------------------------------------------------------------------------------"
unassumerole
assumerole $deliusprodaccountid
certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email $email --domains $deliusproddomains

echo "--------------------------------------------------------------------------------------"
echo "assume stage role & run the certbot to renew/create ssl certificate for delius-stage"
echo "--------------------------------------------------------------------------------------"
unassumerole
assumerole $deliusstageaccountid
certbot certonly --dns-route53 --non-interactive --post-hook "service nginx reload" --agree-tos --email $email --domains $deliusstagedomains

systemctl status nginx
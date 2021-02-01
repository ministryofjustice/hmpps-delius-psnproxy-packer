#!/bin/bash

#----------------------------------------------------------------------------------
# Certificates to check - LetsEncrypt
#----------------------------------------------------------------------------------
LE_PROD_CERT=/etc/letsencrypt/live/psn.probation.service.justice.gov.uk/cert.pem
LE_STAGE_CERT=/etc/letsencrypt/live/stage.probation.service.justice.gov.uk/cert.pem

#----------------------------------------------------------------------------------
# Certificates to check - SPG Self-Issued
#----------------------------------------------------------------------------------
SPG_EXT_PREPROD=/etc/pki/tls/certs/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem
SPG_EXT_PROD=/etc/pki/tls/certs/spgw-ext-psn.probation.service.justice.gov.uk.public-certificate.pem
SPG_INT_PREPROD=/etc/pki/tls/certs/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem
SPG_INT_PROD=/etc/pki/tls/certs/spgw-int-psn.probation.service.justice.gov.uk.public-certificate.pem

#----------------------------------------------------------------------------------
# Certificates expiry trigger - in seconds.
#----------------------------------------------------------------------------------
CERT_EXPIRY_SECONDS=604800

#----------------------------------------------------------------------------------
# S3 Certificate bucket root paths
#----------------------------------------------------------------------------------
S3_BUCKET_ROOT=s3://root
IM_BUCKET_ROOT=$S3_BUCKET_ROOT/im
SPG_BUCKET_ROOT=$S3_BUCKET_ROOT/spg

function get_im_certificate() {
        echo "Getting IM certificate from ${1} and copying to ${2}"
}

function get_spg_certificate() {
        echo "Getting SPG certificate from ${1} and copying to ${2}"
}

function check_certificate_expiry() {

        echo "----------------------------------------------------------"
        echo "Checking certificate expiry for:"
        echo ""    ${1}
        echo "---------------------------------------------------------"
        echo "Expiry Date: $(openssl x509 -enddate -noout -in $1)"

        if openssl x509 -checkend $2 -noout -in $1
        then
 #              echo "Certificate is good for another 7 days!"
#       else
                echo "Certificate has expired or will do so within 7 days!"

                # use the 3rd param to determine the type of certificate - IM or SPG to renew
                PREFIX=$(echo $3| cut -d'_' -f 1)
                echo $PREFIX

                case $PREFIX in
                  'IM')
                    get_im_certificate $1 $2 $IM_BUCKET_ROOT
                    ;;

                  'SPG')
                    get_spg_certificate $1 $2 $SPG_BUCKET_ROOT
                    ;;

                 *)
                        echo 'Error, could not determine the certificate type to fetch (IM / SPG)'
                        ;;
                esac

        fi
}

# Check IM, IAPS LetsEncypyt Certificates for expiration
check_certificate_expiry $LE_PROD_CERT $CERT_EXPIRY_SECONDS 'IM_PROD'
check_certificate_expiry $LE_STAGE_CERT $CERT_EXPIRY_SECONDS 'IM_STAGE'

# Check SPG Certificates for expiration
check_certificate_expiry $SPG_EXT_PREPROD $CERT_EXPIRY_SECONDS 'SPG_EXT_PREPROD'
check_certificate_expiry $SPG_EXT_PROD $CERT_EXPIRY_SECONDS 'SPG_EXT_PROD'
check_certificate_expiry $SPG_INT_PREPROD $CERT_EXPIRY_SECONDS 'SPG_INT_PREPROD'
check_certificate_expiry $SPG_INT_PROD $CERT_EXPIRY_SECONDS 'SPG_INT_PROD'


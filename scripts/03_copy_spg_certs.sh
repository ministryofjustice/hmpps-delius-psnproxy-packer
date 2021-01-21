#!/bin/bash

mkdir -p /etc/pki/tls/certs
mkdir -p /etc/pki/tls/private

# delius-prod - spg-psn-ext-tls
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/haproxy/ca.pem	/etc/pki/tls/certs/spgw-int-psn.probation.service.justice.gov.uk.public-certificate.pem
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/spg-psn-int-tls/spgw-int-psn.probation.service.justice.gov.uk.key /etc/pki/tls/private/spgw-int-psn.probation.service.justice.gov.uk.key
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/private_ca/privateca.probation.service.justice.gov.uk.public-certificate.pem /etc/pki/tls/certs/privateca.probation.service.justice.gov.uk.public-certificate.pem

# delius-prod - spg-psn-int-tls
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/spg-psn-ext-tls/spgw-ext-psn.probation.service.justice.gov.uk.public-certificate.pem /etc/pki/tls/certs/spgw-ext-psn.probation.service.justice.gov.uk.public-certificate.pem
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/spg-psn-int-tls/spgw-ext-psn.probation.service.justice.gov.uk.key /etc/pki/tls/private/spgw-ext-psn.probation.service.justice.gov.uk.key
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/private_ca/spg-ca-list-prod-Sep2020.crt /etc/pki/tls/certs/spg-ca-list-prod-Sep2020.crt
			
# delius-pre-prod - spgw-ext-psn.pre-prod
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/spg-psn-ext-tls/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem /etc/pki/tls/certs/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/spg-psn-ext-tls/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.key /etc/pki/tls/private/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.key
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/private_ca/spg-ca-list-pre-prod-and-prod-sep2020.crt /etc/pki/tls/certs/spg-ca-list-pre-prod-and-prod-sep2020.crt

# delius-pre-prod - spgw-int-psn.pre-prod
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/spg-psn-int-tls/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem /etc/pki/tls/certs/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/spg-psn-int-tls/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.key /etc/pki/tls/private/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.key
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/private_ca/privateca.pre-prod.probation.service.justice.gov.uk.public-certificate.pem /etc/pki/tls/certs/privateca.pre-prod.probation.service.justice.gov.uk.public-certificate.pem


# ssl_certificate                 /etc/pki/tls/certs/spgw-int-psn.probation.service.justice.gov.uk.public-certificate.pem;
#   ssl_certificate_key             /etc/pki/tls/private/spgw-int-psn.probation.service.justice.gov.uk.key;
#   ssl_client_certificate	        /etc/pki/tls/certs/privateca.probation.service.justice.gov.uk.public-certificate.pem;

# ssl_certificate                   /etc/pki/tls/certs/spgw-ext-psn.probation.service.justice.gov.uk.public-certificate.pem;
#   ssl_certificate_key               /etc/pki/tls/private/spgw-ext-psn.probation.service.justice.gov.uk.key;
#   ssl_client_certificate	          /etc/pki/tls/certs/spg-ca-list-prod-Sep2020.crt;



# ssl_certificate                   /etc/pki/tls/certs/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem;
#   ssl_certificate_key               /etc/pki/tls/private/spgw-ext-psn.pre-prod.probation.service.justice.gov.uk.key;
#   ssl_client_certificate            /etc/pki/tls/certs/spg-ca-list-pre-prod-and-prod-sep2020.crt;

#  ssl_certificate                   /etc/pki/tls/certs/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.public-certificate.pem;
#   ssl_certificate_key               /etc/pki/tls/private/spgw-int-psn.pre-prod.probation.service.justice.gov.uk.key;
#   ssl_client_certificate            /etc/pki/tls/certs/privateca.pre-prod.probation.service.justice.gov.uk.public-certificate.pem;







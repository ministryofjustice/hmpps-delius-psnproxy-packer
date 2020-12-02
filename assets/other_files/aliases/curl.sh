#!/usr/bin/env bash
#curls from spg-iso to spg-psn-ext (not possible in psn environment)
alias .curl.mtls.spg.from.iso.to.sandpit.spgw-ext-psn='curl --key /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-sandpit/private_ca/privateca.sandpit.probation.service.justice.gov.uk.public-certificate.pem https://spgw-ext-psn.sandpit.probation.service.justice.gov.uk:9001/POSTUB/InboundSPGProxy/1.2?wsdl -v'

#curls from spg-iso to spg-psn-int
alias .curl.mtls.spg.from.iso.to.sandpit.spgw-int-psn='curl --key /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-sandpit/private_ca/privateca.sandpit.probation.service.justice.gov.uk.public-certificate.pem https://spgw-int-psn.sandpit.probation.service.justice.gov.uk:9001/cxf/InboundSPGProxy/1.2?wsdl -v'


alias .curl.mtls.spg.from.iso.to.preprod.spgw-int-psn_prototype='curl --resolve spgw-int-psn.pre-prod.probation.service.justice.gov.uk:35.176.141.197   --key /usr/local/etc/certs/hmpps-delius-pre-prod/spg-iso-tls/spgw-ext.pre-prod.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-pre-prod/spg-iso-tls/spgw-ext.pre-prod.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-pre-prod/private_ca/privateca.pre-prod.probation.service.justice.gov.uk.public-certificate.pem https://spgw-int-psn.pre-prod.probation.service.justice.gov.uk:9001/POSTUB/InboundSPGProxy/1.2?wsdl -v'

alias .curl.mtls.spg.from.crcstub.to.preprod.spgw-int-psn_prototype='curl --resolve spgw-int-psn.pre-prod.probation.service.justice.gov.uk:35.176.141.197   --key /usr/local/etc/certs/hmpps-delius-pre-prod/parent-orgs/STUB-tls/spgw-crc-ext.pre-prod.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-pre-prod/parent-orgs/STUB-tls/spgw-crc-ext.pre-prod.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-pre-prod/private_ca/privateca.pre-prod.probation.service.justice.gov.uk.public-certificate.pem https://spgw-int-psn.pre-prod.probation.service.justice.gov.uk:9001/cxf/InboundSPGProxy/1.2?wsdl -v'


alias .curl.mtls.spg.from.iso.to.prod.spgw-int-psn_prototype='curl --resolve spgw-int-psn.probation.service.justice.gov.uk:35.176.141.197   --key /usr/local/etc/certs/hmpps-delius-prod/spg-iso-tls/spgw-ext.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-prod/spg-iso-tls/spgw-ext.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-prod/private_ca/privateca.probation.service.justice.gov.uk.public-certificate.pem https://spgw-int-psn.probation.service.justice.gov.uk:9001/POSTUB/InboundSPGProxy/1.2?wsdl -v'

alias .curl.mtls.spg.from.crcstub.to.prod.spgw-int-psn_prototype='curl --resolve spgw-int-psn.probation.service.justice.gov.uk:35.176.141.197   --key /usr/local/etc/certs/hmpps-delius-prod/parent-orgs/STUB-tls/spgw-crc-ext.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-prod/parent-orgs/STUB-tls/spgw-crc-ext.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-prod/private_ca/privateca.probation.service.justice.gov.uk.public-certificate.pem https://spgw-int-psn.probation.service.justice.gov.uk:9001/cxf/InboundSPGProxy/1.2?wsdl -v'
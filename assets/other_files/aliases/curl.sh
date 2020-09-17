alias .curl.mtls.spg.iso='curl --key /opt/spg/certs/parent-orgs/STUB-tls/${SPG_CRC_FQDN}.key --cert /opt/spg/certs/parent-orgs/STUB-tls/${SPG_CRC_FQDN}.public-certificate.pem  --cacert /opt/spg/certs/private_ca/privateca.${SPG_ENVIRONMENT_CN}.public-certificate.pem https://${SPG_ISO_FQDN}:9001/cxf/InboundSPGProxy/1.2?wsdl -v'

alias .curl.mtls.spg.iso.sandpit='curl --key /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.key --cert /usr/local/etc/certs/hmpps-delius-sandpit/spg-iso-tls/spgw-ext.sandpit.probation.service.justice.gov.uk.public-certificate.pem  --cacert /usr/local/etc/certs/hmpps-delius-sandpit/private_ca/privateca.sandpit.probation.service.justice.gov.uk.public-certificate.pem https://localhost:9001/cxf/InboundSPGProxy/1.2?wsdl -v'

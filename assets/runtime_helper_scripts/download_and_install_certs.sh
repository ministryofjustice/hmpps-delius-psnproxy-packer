#!/usr/bin/env bash


set +ex

# Create certs directory
rm -rf /usr/local/etc/certs
mkdir -p /usr/local/etc/certs

# Copy all of the certs from s3 bucket for this environment
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-prod/current/  /usr/local/etc/certs/hmpps-delius-prod --recursive
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-pre-prod/current/  /usr/local/etc/certs/hmpps-delius-pre-prod --recursive
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/official-data/hmpps-delius-stage/current/  /usr/local/etc/certs/hmpps-delius-stage --recursive
aws s3 cp s3://tf-eu-west-2-hmpps-eng-dev-certificates-private-s3bucket/unclassified-data/hmpps-delius-sandpit/current/  /usr/local/etc/certs/hmpps-delius-sandpit --recursive


#NOTE at this point we have all the private keys, and will have the equivilent of ca.pem that is used for haproxy
#if the config files point at the correct private key / certss and cafile from above, none of the below will be requirec



# Make sure we are in the certs folder
cd /usr/local/etc/certs/




#
#
#
#
## Create the haproxy server pem bundle with its private key and cert
##if [ -d "spg-iso-alt-tls" ]; then
#  #cat spg-iso-alt-tls/*.pem spg-iso-alt-tls/*.key > server.pem
#
################################ Temporary/ fix to use the real iso certs in haproxy (spgw-ext....)
################################ instead of the spg-iso-alt-tls (spgw-prototype-ext...)
################################ This depends on the ISO-LB targeting the haproxy-asg
#if [ -d "spg-iso-tls" ]; then
#  cat spg-iso-tls/*.pem spg-iso-tls/*.key > server.pem
#else
#  echo "The haproxy server folder does not exist. Abort pem bundle generation"
#  exit 1
#fi
#
## *******************************************
## Now Import public certs and CAs for each PO
## into the ca.pem
## *******************************************
#
## There should always be a private_ca and a parent-orgs/STUB-tls folder
#if [ -d "private_ca" ]; then
#  echo "Importing private_ca cert"
#  cat private_ca/privateca.*.pem > ca.pem
#else
#  echo "private_ca folder is missing. Abort generation"
#  exit 1
#fi
#
#if [ -d "parent-orgs/STUB-tls" ]; then
#  echo "Importing STUB-tls cert"
#  cat parent-orgs/STUB-tls/*.pem >> ca.pem
#fi
#
## If there are POs in this environment, there may be intermediate and root ca certs
#if [ -d "parent-orgs/CA_ROOT" ]; then
#  echo "Importing PO ROOT CA certs"
#  cat parent-orgs/CA_ROOT/*.crt >> ca.pem
#fi
#
## In CA-INTER of delius-prod there is a RAPID-SSL .cer file (Is it needed?)
#if [ -d "parent-orgs/CA_INTER" ]; then
#  echo "Importing PO Intermediate CA certs"
#  cat parent-orgs/CA_INTER/*.crt >> ca.pem
#  cat parent-orgs/CA_INTER/*.cer >> ca.pem
#fi
#
## If MTC folder exits then cat MTC cert(s) --> spg-psnppl.omnia.mtcnovo.net.pem into ca.pem
## This folder currently contains to tls certs which exist in the ISO server
## It is not clear which key they are using for TLS (import both)
#if [ -d "parent-orgs/MTC" ]; then
#  echo "Importing MTC public certs"
#  cat parent-orgs/MTC/*.pem >> ca.pem
#fi
#
## If STC folder exits then cat STC cert --> prep2.ksscrc.org.uk.pem into ca.pem
#if [ -d "parent-orgs/STC" ]; then
#  echo "Importing Seetech public certs"
#  cat parent-orgs/STC/*.pem >> ca.pem
#fi
#
## Copy the pem files
#cp ca.pem server.pem /usr/local/etc/haproxy/
#
#echo "HAProxy pem generation completed successfully"
#
#set -e
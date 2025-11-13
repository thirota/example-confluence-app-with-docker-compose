#!/bin/bash
set -e

# Conigure UPM truststore
# https://confluence.atlassian.com/upm/configuring-upm-app-signature-check-1489470544.html
# https://confluence.atlassian.com/upm/updating-atlassian-certificates-bundles-1489470540.html

TRUSTSTORE_DIR="/var/atlassian/application-data/confluence/upmconfig/truststore"

# create truststore directory
mkdir -p "$TRUSTSTORE_DIR"

# copy certificates
cp /init-certs/atlassian_mpac_root_ca_v1.crt "$TRUSTSTORE_DIR/"
cp /init-certs/atlassian_mpac_intermediate_ca_v1.crt "$TRUSTSTORE_DIR/"

# change permissions
chown -R root:root "$TRUSTSTORE_DIR"
chmod 755 "$TRUSTSTORE_DIR"
chmod 644 "$TRUSTSTORE_DIR"/*.crt


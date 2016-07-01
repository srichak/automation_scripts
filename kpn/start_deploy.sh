#!/bin/bash

set -e
echo pass | openconnect ${VPN_SERVER_IP} --authgroup=${VPN_AUTH_GROUP} --user=${VPN_USER} --no-cert-check -b --passwd-on-stdin
fab deploy -H ${SSH_USER}@${TARGET_HOST} #-i kpn_ssh_key

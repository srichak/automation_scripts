#!/bin/bash

set -e
cat pass | openconnect ${VPN_SERVER_IP} --authgroup=${VPN_AUTH_GROUP} --user=${VPN_USER} --no-cert-check -b --passwd-on-stdin
fab deploy -H ${SSH_USER}@${TARGET_HOST} -p ${SSH_USER_PASSWORD} #-i kpn_ssh_key
kill $(ps axw | grep openconnect | awk '{print$1}')

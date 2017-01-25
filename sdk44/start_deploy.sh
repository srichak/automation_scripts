#!/bin/bash

set -e

#openvpn --config client.ovpn & export OVPN_ID=$!

# cat pass | openconnect ${VPN_SERVER_IP} --user=${VPN_USER} --no-cert-check -b --passwd-on-stdin

sleep 30

if [ "${test}" = true ]; then
    echo "Testing..."
    fab ls -H ${deploy_user}@${deploy_host} -i ${deploy_keyname}
else
    echo "Deploying app"
    fab deploy -H ${deploy_user}@${deploy_host} -i ${deploy_keyname}
fi

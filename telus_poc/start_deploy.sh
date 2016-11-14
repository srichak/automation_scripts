#!/bin/bash

set -e
openvpn --auth-user-pass=pass --config client.ovpn & export OVPN_ID=$!
sleep 30

if [ "${test}" = true ]; then
    echo "Testing..."
    fab ls -H devsuser@10.10.10.130 -i telus_ssh_key
else
    echo "Deploying app"
    fab deploy -H devsuser@10.10.10.130 -i telus_ssh_key
fi

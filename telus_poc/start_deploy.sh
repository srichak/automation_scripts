#!/bin/bash

set -e
openvpn --config client.ovpn & export OVPN_ID=$!
sleep 30

if [ "${test}" = true ]; then
    echo "Testing..."
    fab ls -H ec2-user@10.10.10.130 -i telus_ssh_key
else
    echo "Deploying app"
    fab deploy -H ec2-user@10.10.10.130 -i telus_ssh_key
fi

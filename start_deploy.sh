#!/bin/bash

set -e
openvpn --auth-user-pass=pass & export OVPN_ID=$! # --config client.ovpn & export OVPN_ID=$!
sleep 30
fab deploy -H ec2-user@10.10.10.130 -i turner_dev_sandbox

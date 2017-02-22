#!/bin/bash

set -e

echo "Sending to instances command to "${SET_INSTANCES_STATUS}

if [ "${SET_INSTANCES_STATUS}" = start ]; then
    echo "Starting..."
    ./startInstances.sh
else
    echo "Stoppping..."
    ./stopInstances.sh
fi




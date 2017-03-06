#!/bin/bash -x

#set -e
echo "running: `cat /etc/hostname` `pwd`/$0"

echo "Sending to instances command to "${SET_INSTANCES_STATUS}

if [ "${SET_INSTANCES_STATUS}" = start ]; then
    echo "Starting..."
    ./startInstances.sh ;
    bash -x ./dbserviceup.sh
else
    echo "Stoppping..."
    ./dbservicedown.sh ;
     bash -x ./stopInstances.sh
fi




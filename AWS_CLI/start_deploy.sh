#!/bin/bash -x

#set -e
echo "running: `cat /etc/hostname` `pwd`/$0"

echo "Sending to instances command to "${SET_INSTANCES_STATUS}

if [ "${SET_INSTANCES_STATUS}" = start ]; then
    echo "Starting..."
    ./startDatabases.sh;
    #sleep 300;
    bash -x ./dbserviceup.sh;
    ./startInstances.sh;
else
    echo "Stoppping..."
    [ -s devopssshkey.pem ] && ./dbservicedown.sh ;
     bash -x ./stopInstances.sh
fi




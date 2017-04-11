#!/bin/bash -x

echo "Starting Ambari EC2 instances..."
./startAmbariInstances.sh
sleep 300
echo "Starting Ambari services..."
curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop HDFS via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://34.248.157.73:8080/api/v1/clusters/ava-batch/services

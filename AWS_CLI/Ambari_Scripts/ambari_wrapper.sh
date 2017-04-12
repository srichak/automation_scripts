#!/bin/bash -x

Ambari_user=${Ambari_user}
Ambari_pass=${Ambari_pass}
Ambari_Gateway_IP=${Ambari_Gateway_IP}



echo "Starting Ambari EC2 instances..."
./startAmbariInstances.sh
sleep 300
echo "Starting Ambari services..."
#curl -u $Ambari_user:$Ambari_pass -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop HDFS via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://34.248.157.73:8080/api/v1/clusters/ava-batch/services
curl -u $Ambari_user:$Ambari_pass -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop HDFS via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://$Ambari_Gateway_IP:8080/api/v1/clusters/ava-batch/services

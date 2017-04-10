#!/bin/bash
set -ex
Ambari_Vpc_Name=${Ambari_Vpc_Name}
STATE=stopped

if [ -n "$Ambari_Vpc_Name" ]; then
  for BOX in `aws ec2 describe-instances --filters "Name=tag:Vpc,Values=$Ambari_Vpc_Name" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
    echo "starting instance $BOX..";
    aws ec2 start-instances --instance-ids $BOX;
  done
#else
#    # work with all environments
#
#    for BOX in `aws ec2 describe-instances --filters "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
#        echo "starting instance $BOX..";
#        aws ec2 start-instances --instance-ids $BOX;
#    done
#
##    for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text`; do
##        echo "releasing auto-scaling group $ASG..";
##      	aws autoscaling resume-processes --auto-scaling-group-name $ASG;
##    done
fi

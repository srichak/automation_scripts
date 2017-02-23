#!/bin/bash
set -ex
CUST=${CUSTOMER_TAG}
STATE=stopped

if [ -n "$CUST" ]; then
    # work with only specified environment

    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws start-instances --instance-ids $BOX;
    done

    for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text | grep $CUST`; do
        echo "releasing auto-scaling group $ASG..";
        aws autoscaling resume-processes-processes --auto-scaling-group-name $ASG;
    done

else
    # work with all environments

    for BOX in `aws ec2 describe-instances --filters "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done

    for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text`; do
        echo "releasing auto-scaling group $ASG..";
      	aws autoscaling resume-processes-processes --auto-scaling-group-name $ASG;
    done

fi

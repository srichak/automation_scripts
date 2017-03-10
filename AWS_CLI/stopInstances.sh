#!/bin/bash
set -ex
CUST=${CUSTOMER_TAG}
STATE=running

if [ -n "$CUST" ]; then

    for customer in ${CUST//,/ }; do
        # work with only specified environment

        for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text | grep ${customer}`; do
            echo "suspending auto-scaling group $ASG..";
            aws autoscaling suspend-processes --auto-scaling-group-name $ASG;
        done

        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "stopping instance $BOX..";
            aws ec2 stop-instances --instance-ids $BOX;
        done
        
    done
    
else
    # work with all environments

    for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text`; do
        echo "suspending auto-scaling group $ASG..";
        aws autoscaling suspend-processes --auto-scaling-group-name $ASG;
    done

    for BOX in `aws ec2 describe-instances --filters "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "stopping instance $BOX..";
        aws ec2 stop-instances --instance-ids $BOX;
    done

fi

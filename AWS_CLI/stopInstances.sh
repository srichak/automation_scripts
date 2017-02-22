#!/bin/bash
set -ex
CUST=${CUSTOMER_TAG}
STATE=running

for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text | grep $CUST`; do
        echo "suspending auto-scaling group $ASG..";
                        aws autoscaling suspend-processes --auto-scaling-group-name $ASG;
                        #       aws autoscaling resume-processes --auto-scaling-group-name $ASG;
                    done

for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "stopping instance $BOX..";
                aws ec2 stop-instances --instance-ids $BOX;
                #       aws ec2 start-instances --instance-ids $BOX;
            done
STATE=running

for ASG in `aws autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].[AutoScalingGroupName]' --output=text | grep $CUST`; do
        echo "suspending auto-scaling group $ASG..";
                aws autoscaling suspend-processes --auto-scaling-group-name $ASG;
                #       aws autoscaling resume-processes --auto-scaling-group-name $ASG;
            done

            for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
                    echo "stopping instance $BOX..";
                            aws ec2 stop-instances --instance-ids $BOX;
                            #       aws ec2 start-instances --instance-ids $BOX;
                        done
                                                
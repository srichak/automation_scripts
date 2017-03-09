#!/bin/bash
set -ex
CUST=${CUSTOMER_TAG}
STATE=stopped

# start database - Galera, Cassandra, Magento - servers

if [ -n "$CUST" ]; then
    # work with only specified environment
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:Name,Values=${CUST}ansible" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:galera_master,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:galera_slave,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:magento_db,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:bookmark,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
else
    # work with all environments
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:galera_master,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:galera_slave,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:magento_db,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=$CUST" "Name=tag:bookmark,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
fi
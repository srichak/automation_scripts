#!/bin/bash
set -ex
CUST=${CUSTOMER_TAG}
STATE=stopped

# start database - Galera, Cassandra, Magento - servers

if [ -n "$CUST" ]; then
    for customer in ${CUST//,/ }; do
        # work with only specified environment
        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:Name,Values=${customer}ansible" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "starting instance $BOX..";
            aws ec2 start-instances --instance-ids $BOX;
        done
        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:galera_master,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "starting instance $BOX..";
            aws ec2 start-instances --instance-ids $BOX;
        done
        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:galera_slave,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "starting instance $BOX..";
            aws ec2 start-instances --instance-ids $BOX;
        done
        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:magento_db,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "starting instance $BOX..";
            aws ec2 start-instances --instance-ids $BOX;
        done
        for BOX in `aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:bookmark,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
            echo "starting instance $BOX..";
            aws ec2 start-instances --instance-ids $BOX;
        done
    done
else
    # work with all environments
    for BOX in `aws ec2 describe-instances --filters "Name=tag:galera_master,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:galera_slave,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:magento_db,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
    for BOX in `aws ec2 describe-instances --filters "Name=tag:bookmark,Values=tag_Role" "Name=instance-state-name,Values=$STATE" --query 'Reservations[*].Instances[*].[InstanceId]' --output text`; do
        echo "starting instance $BOX..";
        aws ec2 start-instances --instance-ids $BOX;
    done
fi
#!/bin/bash
export CUST=${CUSTOMER_TAG}

# SSH Config Generating function
sshconf() {
printf "Host $1\n\tUser ec2-user\n\tIdentityFile $3\n\tStrictHostKeyChecking=no\n\tUserKnownHostsFile =/dev/null\n\tPort 22\n\tProxyCommand ssh -W %%h:%%p -o StrictHostKeyChecking=no -i $3 ec2-user@$2\n"
}

for customer in ${CUST//,/ }; do

    # Getting bastion host IP
    bastion=`aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:Name,Values=${customer}ansible" --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].Association.PublicIp' --output text`
    # Clearing temp ssh rules
    > /tmp/ssh


    # Starting Galera cluster instances in correct order
    aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:Name,Values=${customer}galera*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
    do

        sshconf `echo $line | awk '{ print $2}'` $bastion /tmp/devopssshkey.pem >> /tmp/ssh;
        ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
    done

    # Starting Magento DB instances in correct order
    aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:Name,Values=${customer}database*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
    do
        sshconf `echo $line | awk '{ print $2}'` $bastion /tmp/devopssshkey.pem >> /tmp/ssh;
        ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
    done

    # Starting Cassandra DB instances in correct order
    aws ec2 describe-instances --filters "Name=tag:customer,Values=${customer}" "Name=tag:Name,Values=${customer}bookmark*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
    do
        sshconf `echo $line | awk '{ print $2}'` $bastion /tmp/devopssshkey.pem >> /tmp/ssh;
        ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=cassandra state=stopped" ;
    done

done

sleep 300;
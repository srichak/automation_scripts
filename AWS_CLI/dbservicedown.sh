#!/bin/bash

# SSH Config Generating function
sshconf() {
printf "Host $1\n\tUser ec2-user\n\tIdentityFile ~/.ssh/id_rsa\n\tStrictHostKeyChecking=no\n\tUserKnownHostsFile =/dev/null\n\tPort 22\n\tProxyCommand ssh -W %%h:%%p -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ec2-user@$2\n"
}

if [[ $CUST = "devops6" ]]
then
# Getting bastion host IP
bastion=`aws ec2 describe-instances --filters "Name=tag:customer,Values=devops6" "Name=tag:Name,Values=devops6ansible" --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].Association.PublicIp' --output text`

# Clearing temp ssh rules
> /tmp/ssh


# Starting Galera cluster instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops6" "Name=tag:Name,Values=devops6galera*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do

sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
sleep 300;
done

# Starting Magento DB instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops6" "Name=tag:Name,Values=devops6database*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do
sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
sleep 300;
done

# Starting Cassandra DB instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops6" "Name=tag:Name,Values=devops6bookmark*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do
sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=cassandra state=stopped" ;
sleep 300;
done
elif [[ $CUST = "devops4" ]]
then
# Getting bastion host IP
bastion=`aws ec2 describe-instances --filters "Name=tag:customer,Values=devops4" "Name=tag:Name,Values=devops4ansible" --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].Association.PublicIp' --output text`

# Clearing temp ssh rules
> /tmp/ssh


# Starting Galera cluster instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops4" "Name=tag:Name,Values=devops4galera*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do

sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
sleep 300;
done

# Starting Magento DB instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops4" "Name=tag:Name,Values=devops4database*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do
sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=mysqld state=stopped" ;
sleep 300;
done

# Starting Cassandra DB instances in correct order
aws ec2 describe-instances --filters "Name=tag:customer,Values=devops4" "Name=tag:Name,Values=devops4bookmark*" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`],NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress]' --output text | awk '$1=$1' | sed -e 's/Name\ /Name=/g' | tr '\n' ' ' | sed -e 's/\Name=/\n/g' | awk '$1=$1' | sort -rnk1 | while read line;
do
sshconf `echo $line | awk '{ print $2}'` $bastion >> /tmp/ssh;
ansible all -i "`echo $line | awk '{ print $2}'`," -b -m service -a "name=cassandra state=stopped" ;
sleep 300;
done
fi
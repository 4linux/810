#!/bin/bash
#
# Maintainer: Júlio Rangel Ballot 
# Date: 18/10/2019
#

SYSTEM="/usr/lib/systemd/system"
ETCSYSTEM="/etc/systemd/system"
ETC="/etc"

## Installing packages/dependencies/repos

echo "Updating and installing epel-release..."
yum update -y 2>/dev/null
yum install -y epel-release 2>/dev/null
yum update -y 2>/dev/null
echo "finished"

echo "Installing extra packages like VIM and Nano..."
yum install -y vim nano 2>/dev/null
echo "finished"

echo "Installing MongoDB 4.x repository..."
touch /etc/yum.repos.d/mongodb-org-4.2.repo
tee /etc/yum.repos.d/mongodb-org-4.2.repo <<EOF
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF
echo "finished"

echo "Installing MongoDB 4.2..."
yum install -y mongodb-org 2>/dev/null
echo "finished"


#echo "Creating Shard and ConfigServer files and directories..."
#mkdir -p  /var/run/mongodb-shard/ /var/lib/mongo-shard/ /var/log/mongodb-shard/
#mkdir -p  /var/run/mongodb-configsvr/ /var/lib/mongo-configsvr/ /var/log/mongodb-configsvr/

#chown mongod:mongod /var/run/mongodb-shard/ \
#                    /var/lib/mongo-shard/ \
#                    /var/log/mongodb-shard/ \
#                    /var/run/mongodb-configsvr/ \
#                    /var/lib/mongo-configsvr/ \
#                    /var/log/mongodb-configsvr/

## Copying SystemD's Services for Sharding and ConfigServer

#cp ${SYSTEM}/mongod.service  ${ETCSYSTEM}/mongod-shard.service
#cp ${SYSTEM}/mongod.service  ${ETCSYSTEM}/mongod-configsvr.service

#sed -i 's/\/var\/run\/mongodb/\/var\/run\/mongodb-shard/g' ${ETCSYSTEM}/mongod-shard.service
#sed -i 's/\/var\/lib\/mongo/\/var\/lib\/mongo-shard/g' ${ETCSYSTEM}/mongod-shard.service
#sed -i 's/\/var\/log\/mongodb/\/var\/log\/mongodb-shard/g' ${ETCSYSTEM}/mongod-shard.service
#sed -i 's/\/etc\/mongod.conf/\/etc\/mongod-shard.conf/g' ${ETCSYSTEM}/mongod-shard.service
#
#sed -i 's/\/var\/run\/mongodb/\/var\/run\/mongodb-configsvr/g' ${ETCSYSTEM}/mongod-configsvr.service
#sed -i 's/\/var\/lib\/mongo/\/var\/lib\/mongo-configsvr/g' ${ETCSYSTEM}/mongod-configsvr.service
#sed -i 's/\/var\/log\/mongodb/\/var\/log\/mongodb-configsvr/g' ${ETCSYSTEM}/mongod-configsvr.service
#sed -i 's/\/etc\/mongod.conf/\/etc\/mongod-configsvr.conf/g' ${ETCSYSTEM}/mongod-configsvr.service

## Copying configuration file

#cp ${ETC}/mongod.conf ${ETC}/mongod-configsvr.conf
#cp ${ETC}/mongod.conf ${ETC}/mongod-shard.conf
#
#sed -i 's/\/var\/run\/mongodb/\/var\/run\/mongodb-shard/g' ${ETC}/mongod-shard.conf
#sed -i 's/\/var\/lib\/mongo/\/var\/lib\/mongo-shard/g' ${ETC}/mongod-shard.conf
#sed -i 's/\/var\/log\/mongodb/\/var\/log\/mongodb-shard/g' ${ETC}/mongod-shard.conf
#
#sed -i 's/\/var\/run\/mongodb/\/var\/run\/mongodb-configsvr/g' ${ETC}/mongod-configsvr.conf
#sed -i 's/\/var\/lib\/mongo/\/var\/lib\/mongo-configsvr/g' ${ETC}/mongod-configsvr.conf
#sed -i 's/\/var\/log\/mongodb/\/var\/log\/mongodb-configsvr/g' ${ETC}/mongod-configsvr.conf
#echo "finished"
#
### Realoading SystemD daemon
#echo "systemd daemon reloading..."
#systemctl daemon-reload
#echo "finished"

## Disabling SELinux
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

## Creating /etc/hosts
cat <<EOF > /etc/hosts
127.0.0.1 localhost.localdomain localhost
192.168.100.10 mongos.example.com mongos
192.168.100.11 configsvr-01.example.com configsvr-01
192.168.100.12 configsvr-02.example.com configsvr-02
192.168.100.13 shard-01.example.com shard-01
192.168.100.14 shard-02.example.com shard-02 
192.168.100.15 shard-03.example.com shard-03
192.168.100.16 shard-04.example.com shard-04
EOF

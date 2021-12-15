#!/bin/bash

# Author: Vamsi
# Date Created: 13/11/2021
# Date Modified: 13/11/2021

# Description:
# This Script Installs jenkins from the official repo and starts it.
# If on AWS Ec2, create a security group to allow exposure of port 8080.

clear

echo "******************** Starting system update ********************"
sleep 3
echo ""
yum update -y
echo ""
sleep 3

echo "******************** Adding Jenkins repo ********************"
echo ""
sleep 4
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sleep 4
echo ""

echo "******************** Importing jenkins key ********************"
echo ""
sleep 4
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sleep 4
echo ""

echo "******************** Upgrading system ********************"
sleep 4
echo ""
yum upgrade
sleep 3
Uncomment this if you are Installing on Amazon Linux
# amazon-linux-extras install epel -y
Uncomment this if you are installing on RHEL 
yum install epel-release -y
echo ""

echo ""
if command -v daemonize &> /dev/null; then
	echo ""
	sleep 3
	echo "************** daemonize installed **************"
	echo ""
else
	echo ""
	echo "************** Installing daemonize **************"
	echo ""
	sleep 3
	yum install daemonize -y
echo ""
fi

echo "************** Installing jenkins ****************"
sleep 3
yum install jenkins -y
echo ""

echo "******************** Reloading Jenkins ********************"
sleep 3
echo ""
systemctl daemon-reload

echo "************** Starting Jenkins Service **************"
echo ""
sleep 3
systemctl start jenkins
echo ""

echo "******************** Checking jenkins status ********************"
echo ""
sleep 4
systemctl status jenkins
echo ""

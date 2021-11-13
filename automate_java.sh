#!/bin/bash

##############################################################################################
# Authors: Vamsi, Hassain
# Created: 9th November 2021
# Last Modified: 11th November 2021

# Description:
# Automates Java Installation and Configuration.
# Before running the script copy the location of the jdk file.
##############################################################################################

clear

function print_colour () {
	nc='\033[0m'
    case $1 in
        "green")color='\033[0;32m' ;;
        "red")color='\033[0;31m' ;;
        "yellow")color='\033[0;33m' ;;
	"nc")color='\033';;
	
    esac
echo -e "${color} $2 ${nc} "
}

# Checking whether user is root or not 
if [ "$UID" -ne "0" ]; then
	print_colour "red" "Try Running As Root"
	exit 1
fi

echo ""

# Checking if java directory exists
if [ -d /opt/java ]; then
	print_colour "green" "Previous Java Installion Detected Removing The Folder....."
	rm -rf /opt/java
	sleep 3
fi

echo ""

print_colour "green" "Hello! $USER, sit back and relax as I Install and Configure Java on this system i.e $HOSTNAME"

print_colour "green" "********************************************************************************************************"

# Enter the location of the .tar.gz

read -p 'Enter The Clone Dir Location: ' loc
echo ""
print_colour "green" "+++++++ Searching File..... Please Wait.... ++++++"
sleep 5
echo ""

# Code to find and copy the file to /opt
if [ -e $loc/*.tar.gz ]; then
	print_colour "green" "File found starting Installation!"
	sleep 5
	print_colour "green" "============================================================================================"
	print_colour "green"	"Copying file to /opt"
	print_colour "green" "============================================================================================="
	sleep 2
	print_colour "green" "******************************************************"
	cp $loc/*.tar.gz /opt
	print_colour "green" "*******************************************************"
	print_colour "green"	"Changing Directory to /opt"
else
	print_colour "red"	"File Not Found.. Exiting Installer"
	sleep 3
	exit
fi

sleep 3

# Code to start extraction of the .tar.gz file
if [ -e /opt/*.tar.gz ]; then
	print_colour "green" "File Found! Starting Extraction"
	sleep 2
	tar -xvf /opt/*.tar.gz -C /opt/
	print_colour "green" "=========================================================================================="
	print_colour "green" "Tar Extraction Complete!"
	print_colour "yellow" "Cleaning up directory"
	rm -rf /opt/*.tar.gz
	echo ""
	sleep 3
else
	print_colour "red" "File Not Found!"
	sleep 2
	exit
fi

sleep 4

print_colour "green" "*************************************************************************"

# Renaming the extracted directory to java
if [ -d /opt/jdk1* ]; then
	print_colour "green" "Renaming Extracted Directory To java"
	sleep 3
	mv /opt/jdk1* /opt/java
else
	print_colour "red" "No Folder With Name"
	sleep 2
	echo ""
	exit
fi

print_colour "green" "**************************************************************************"
echo ""
sleep 4

print_colour "green" "Starting Configuration of Java"
sleep 3

# Using variable for easier address substitution
java_dir=java

print_colour "green" "*************************************************************************"

echo ""

print_colour "green" "Updating Java update-alternatives"

print_colour "green" "*************************************************************************"

update-alternatives --install /usr/bin/java java /opt/$java_dir/bin/java 100 

yes 1 | update-alternatives --config java
<<<<<<< HEAD
=======
echo ""
>>>>>>> ec20c3f38969586eb6df81e5f63c11c2d92e9bcb
sleep 2
echo ""
echo ""
print_colour "green" "*************************************************************************"

print_colour "green" "Updating Javac"

print_colour "green" "*************************************************************************"

sleep 3

update-alternatives --install /usr/bin/javac javac /opt/$java_dir/bin/javac 100  
yes 1 | update-alternatives --config javac
sleep 2
echo ""
echo ""

print_colour "green" "**************************************************************************"

print_colour "green" "Updating Jar"

print_colour "green" "**************************************************************************"
sleep 3
update-alternatives --install /usr/bin/jar jar /opt/$java_dir/bin/jar 100  
sleep 1
yes 1 | update-alternatives --config jar
sleep 1
echo ""
echo ""
print_colour "green" "**************************************************************************"

print_colour "green" "Exporting Java Env Variable......."

print_colour "green" "**************************************************************************"

export JAVA_HOME=/opt/$java_dir
sleep 2
export JRE_HOME=/opt/$java_dir
sleep 2
export PATH=$PATH:/opt/$java_dir/bin:/opt/$java_dir/jre/bin
sleep 2
echo ""
print_colour "green" "==========================================================================="
print_colour "green" "Verifying Java Installation....."
print_colour "green" "============================================================================"
sleep 2
echo ""
if java -version 2>&1 >/dev/null | grep "java "; then
    print_colour "green" "Java installed."
	echo ""
    print_colour "green" "Dear $USER, Java has now been Installed and configured on this machine!"
	echo ""
else
    print_colour "red" "Java NOT installed!"

fi

# Printing java version
java -version
print_colour "green" "=============================================================================="
echo ""
sleep 5
exit 0

#!/bin/bash

# LXD Installation (if necessary)
echo "task ~~~~~~~~~~~~~ Checking LXD Installation"
lxdVersion=$(lxd --version)
if [ "$?" -eq 0 ] ; then
	echo "result ~~~~~~~~~~~ LXD already installed. Version: $lxdVersion"
else
	echo "result ~~~~~~~~~~~ LXD not already installed"
    echo "task ~~~~~~~~~~~~~ INSTALLING LXD"
	sudo snap install lxd && echo "result ~~~~~~~~~~~ LXD installed" 
fi

# LXDBR0
echo "task ~~~~~~~~~~~~~ Checking LXDBR0 Existance"
checkingLXDBR0=$(ip a | grep -q lxdbr0)
if [ $? -eq 0 ]; then
echo "result ~~~~~~~~~~~ lxdbr0 is running"
else
	echo "result ~~~~~~~~~~~ lxdbr0 not running"
	lxd init auto && echo "result ~~~~~~~~~~~ lxdbr0 created"
fi

# Container COMP2101-S22
echo "task ~~~~~~~~~~~~~ Check Container"
lxc list | grep -w "COMP2101-S22" >/dev/null
if test $? -eq 0 ; then
  echo "result ~~~~~~~~~~~ Container already exists"
  else
	echo "result > task ~~~~~~~~~~~ CREATING CONTAINER"
	lxc launch ubuntu:20.04 COMP2101-S22
    lxc exec COMP2101-S22 -- apt update
    lxc exec COMP2101-S22 -- apt upgrade
fi

# Installing Apache on COMP2101-S22
lxc exec COMP2101-S22 -- dpkg --get-selections | grep -q apache
echo "task ~~~~~~~~~~~~~ Check Apache Installation on container"
if test $? -eq 0 ; 
	then echo "result ~~~~~~~~~~~ Apache preinstalled."
else
	echo "result > task ~~~~~~~~~~~ Installing Apache"
	lxc exec COMP2101-S22 -- apt install apache2 && echo "result ~~~~~~~~~~~ Apache installed."
fi
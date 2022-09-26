#!/bin/bash

# user
userData=$(hostname) 
echo "USERDATA: $userData"
echo "-------------------------------------------"
# hostnamectl
echo "HOSTNAMECTL DATA:"
hostnamectl
echo "-------------------------------------------"
# os
os=$(hostnamectl | grep -h "Operating Sys")
echo "$os"
echo "-------------------------------------------"
# ip
echo "IP: "
ip a | grep -h "inet "
echo "-------------------------------------------"
# storage space
echo "STORAGE: "
space=$(df -h | grep "/dev/s")
echo "$space"
echo "-------------------------------------------"
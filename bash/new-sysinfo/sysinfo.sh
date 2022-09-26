#!/bin/bash

echo "Report for myvm"
echo "==============="
# username
userData=$(hostname)
echo "FQDN: $userData"
# os
os=$(hostnamectl | grep -h "Operating Sys" | awk '{printf $3 $4 $5}')
echo "Operating System name and version: $os"
# ip
ipInfo=$(ip a |grep -h "global dynamic" | awk '{print $2}')
echo "IP Address: $ipInfo"
# storage space
space=$(df -h / | grep "/dev/s" | awk '{print $4}')  
echo "Root Filesystem Free Space: $space"
echo "==============="
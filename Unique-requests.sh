#!/bin/bash

# NOTE: List of IPs that sent requests to the server in order of the most requests
# Using: change "logFile" and run "bash Unique-requests.sh"

start=$(date +%d)
end=$(date)
logFile="/var/log/httpd/domains/example.com.log"

mkdir -p ./output
cat $logFile | awk '{ print $1 }' | sort | uniq -c | sort -nr > ./output/Unique-requests-$(date +%d)-$(date +%b).txt

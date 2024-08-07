#!/bin/bash

# NOTE: The list of status codes given to the server in response to incoming requests, in the order of the most status code.
# Using: change "logFile" and run "bash unique-status-code.sh".

day=$(date +%d)
logFile="/var/log/httpd/domains/example.com.log"

mkdir -p ./output
cat $logFile | awk '{ print $9 }' | sort | uniq -c | sort -nr > ./output/unique-status-code-$day.txt

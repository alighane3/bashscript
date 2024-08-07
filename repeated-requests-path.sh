#!/bin/bash

# NOTE: Directory list of requests sent to the server in order of the most requests sent to the directory.
# Using: change "logFile" and run "bash repeated-requests-path.sh".

day=$(date +%d)
logFile="/var/log/httpd/domains/example.com.log"

mkdir -p ./output
cat $logFile | awk '{ print $7 }' | sort | uniq -c | sort -nr > ./output/repeated-requests-path-$day-.txt

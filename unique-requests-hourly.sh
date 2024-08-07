#!/bin/bash

# NOTE: A list of the number of requests sent to the server in order of time
# Using: change "logFile" and run "bash unique-requests-hourly.sh"

DTE="$(date +%d)/$(date +%b)"
FLE="./output/hourly-log-httpd-"$(date +%d)-$(date +%b)".txt"
logFile="/var/log/httpd/domains/example.com.log"

mkdir -p ./output
LOG=$(grep "$DTE" $logFile | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c)
echo -e "$LOG" > $FLE

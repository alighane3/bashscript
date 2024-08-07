#!/bin/bash

# NOTE: The list of the number of requests sent to the server in order of time from the time you specify.
# Using: change "logFile" and run "bash unique-requests-hourly-m.sh xx". ex: bash unique-requests-hourly-m.sh 05

day=$(date +%d)
month=$(date +%b)
year=$(date +%Y)
timeNow=$(date +%T)
fromTime=$1
logFile="/var/log/httpd/domains/example.com.log"

mkdir -p ./output
cat $logFile | awk '$4 >= "['$day'/'$month'/'$year':'$fromTime':00" && $4 < "['$day'/'$month'/'$year':'$timeNow'"' | awk '{ print $1 }' | sort | uniq -c | sort -nr > ./output/unique-requests-hourly-m-$month-$day.txt

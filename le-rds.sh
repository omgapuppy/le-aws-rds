#! /bin/bash

TOKEN="YOUR_LOG_TOKEN"
URL="https://js.logentries.com/v1/logs/"

while read data;

do

        curl -x POST --data "$data" $URL$TOKEN

done

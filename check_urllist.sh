#!/bin/bash
for url in $(cat urls.txt) 
do 
  if curl --output /dev/null --silent --max-time 10 --head --insecure --location --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246' "$url"; then
    echo "$url" >> urls.new
  else
    echo "URL does not exist: $url"
  fi 
done

#!/bin/sh
shuf /app/urllist.txt | head -1000 > /app/url_selection.txt
for i in $(cat /app/url_selection.txt)
do
#echo $i
#(>&2 echo $i)
curl --silent --proxy $TG_PROXY --max-time 10 --insecure --location --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246' --output /app/result $i
done

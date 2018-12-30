#!/bin/sh
echo 'Checking for urllist update...'
cd /app/symtg/
git pull
if ! cmp -s /app/urllist.txt.enc /app/symtg/urllist.txt.enc ; then
  rm /app/urllist.txt.enc
  cp /app/symtg/urllist.txt.enc /app/urllist.txt.enc
  openssl enc -aes-256-cbc -d -pass env:TG_PASSWORD -in /app/urllist.txt.enc -out /app/urllist.txt
  TG_URLS=$(cat /app/urllist.txt | wc -l)
  echo "$TG_URLS"' loaded'
fi

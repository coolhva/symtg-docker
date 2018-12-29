#!/bin/sh
cd /app/symtg/
git pull
if ! cmp -s /app/urllist.txt.enc /app/symtg/urllist.txt.enc ; then
  rm /app/urllist.txt.enc
  cp /app/symtg/urllist.txt.enc /app/urllist.txt.enc
  openssl enc -aes-256-cbc -d -pass env:TG_PASSWORD -in /app/urllist.txt.enc -out /app/urllist.txt
fi

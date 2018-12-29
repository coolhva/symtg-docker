#!/bin/sh
cat /app/motd.txt
if [ -z "$TG_PASSWORD" ]; then
  echo "Password not set, unable to decrypt urllist, exiting"
  exit 3
fi
if [ -z "$TG_PROXY" ]; then
  echo "Proxy server not set, using default of http://proxy.threatpulse.com:8080"
  export TG_PROXY="http://proxy.threatpulse.com:8080"
fi
if [ -z "$TG_INTERVAL" ]; then
  echo "Interval not set, using default of 10 minutes"
  export TG_INTERVAL="10"
fi
openssl enc -aes-256-cbc -d -pass env:TG_PASSWORD -in /app/urllist.txt.enc -out /app/urllist.txt
if  [[ $? -ne 0 ]]; then
  echo "Invalid password, exiting"
  exit 4
fi
TG_URLS=$(cat /app/urllist.txt | wc -l)
cd /app
git clone https://github.com/coolhva/symtg.git /app/symtg/
echo '*/'"$TG_INTERVAL"' * * * * /app/wss.sh' > /etc/crontabs/root
ehco '0 1 * * * /app/update.sh' >> /etc/crontabs/root
echo ''
echo 'Settings        : '
echo 'Proxy           : '"$TG_PROXY"
echo 'Interval (min)  : '"$TG_INTERVAL"
echo 'URLS            : '"$TG_URLS"
echo ''
echo Starting crond...
crond -l 5 -f

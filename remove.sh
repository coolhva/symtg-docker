#!/bin/bash
for i in $(cat ./urlexclude.txt)
do
  echo $i
  sed -i "" "/$i/d" ./urllist.txt
done

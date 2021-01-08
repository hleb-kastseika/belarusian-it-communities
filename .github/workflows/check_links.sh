#!/bin/bash

cat ../../README.md | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | while read url
do
  status=$(curl -I -L -X GET $url -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0
.4280.88 Safari/537.36' 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  if [[ "$status" -eq 200 || "$status" -eq 301 || "$status" -eq 302 || "$status" -eq 303 || "$status" -eq 999 ]] ; then
    echo "URL exists: $url - $status"
  else
    echo "URL does not exist: $url - $status"
    exit 1
  fi
  sleep .5
done

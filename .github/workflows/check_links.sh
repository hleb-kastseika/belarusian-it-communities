#!/bin/bash

cat ../../README.md | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | while read url
do
    status=$(curl -I -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36' \
        $url 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  if [[ "$status" -eq 200 || "$status" -eq 301 || "$status" -eq 302 || "$status" -eq 303 || "$status" -eq 999 ]] ; then
    echo "URL exists: $url - $status"
  else
    echo "URL does not exist: $url - $status"
    exit 1
  fi
  sleep 1
done

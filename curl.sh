#!/usr/bin/env sh

ERRORS=0

for url in $(cat endpoints.txt)
do
  echo -n "Checking $url\t"

  STATUS_CODE=$(curl \
      --output /dev/null \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
  sleep .5
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs!\033[m"
  exit 1
fi

#      --silent \


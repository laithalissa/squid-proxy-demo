# For testing we're only interested in the HTTP code
if [ "$2" == '--debug' ]; then
  curl -v $1
else
  resp=$(curl -s -o /dev/null -w "%{http_code}" $1)
  if [ "$resp" = "000" ]; then
    resp=$(curl -s -o /dev/null -w "%{http_connect}" $1)
  fi

  echo $resp
fi

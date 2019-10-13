connections=(
#  http://google.com
  https://google.com
#  http://bing.com
  https://bing.com
#  http://duckduckgo.com
  https://duckduckgo.com
)
clients=(
  http-client
  tls-client
  blocked-client
)

RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0;97m'
MAGENTA='\033[0;35m'
CYAN='\033[0;96m'



render_result() {
  if (($resp >= 200 && $resp < 400)); then
    msg="$GREEN ✔ $RESET : ($resp)"
    echo $msg
  else
    msg="$RED ✖ $RESET ($resp)"
    echo $msg
  fi
}

for connection in "${connections[@]}"; do
  printf "$CYAN[Testing connections to $connection]$RESET\n"

  for client in "${clients[@]}"; do
    printf "$MAGENTA $client ...$RESET"
    docker-compose exec $client bash ./connect.sh $connection --debug
  done
done


connections=(
  http://google.com
  https://google.com
  http://bing.com
  https://bing.com
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


print_result_line() {
  local client=${1?:Usage: print-result <client> <response_code>}
  local result=${2?:Usage: print-result <client> <response_code>}
}

print_header() {
  printf '| Host '
  for client in "${clients[@]}"; do
    printf "| $client"
  done
  printf "|"
}

print_separator() {
  for client in "${clients[@]}"; do
    printf "| --- "
  done
  printf "| --- |"
}

render_result() {
  if (($resp >= 200 && $resp < 400)); then
    msg="$GREEN ✔ $RESET : ($resp)"
    echo $msg
  else
    msg="$RED ✖ $RESET ($resp)"
    echo $msg
  fi
}

render_table_result() {
  if (($resp >= 200 && $resp < 400)); then
    echo "✔: ($resp)"
  else
    echo "✖ ($resp)"
  fi
}

results_matrix="$(print_header)\n"
results_matrix+="$(print_separator)\n"

for connection in "${connections[@]}"; do
  results_matrix+="| $connection "
  printf "$WHITE[Testing connections to $connection]$RESET\n"

  for client in "${clients[@]}"; do
    printf "$MAGENTA $client ...$RESET"
    resp=$(docker-compose exec $client bash ./connect.sh $connection)
    # docker-compose does something weird so filter out invisible chars
    resp=$(tr -dc '[[:print:]]' <<< "$resp")

    render_result "$client" "$resp"
    result_text=$(render_table_result $client $resp)
    results_matrix+="| $result_text"
  done
  results_matrix+="|\n"
done

echo $results_matrix > results.md


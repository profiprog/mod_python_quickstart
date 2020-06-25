#!/bin/bash
IMG=solargis/test
CONTAINER=test-container
PORT="${PORT:-8080}"

if [ "$1" == "exec" ]; then
  shift
  [ "$#" == 0 ] && set -- bash
  exec docker exec -it "$CONTAINER" "$@"
fi
[ "$1" == "logs" ] && exec docker logs -f "$CONTAINER"

docker stop "$CONTAINER" 2>/dev/null && docker rm "$CONTAINER" 2>/dev/null
[ "$1" == "stop" ] && exit

docker build -t "$IMG" . || exit
docker run --rm -d \
  -v "$(pwd)/service:/var/www:ro" \
  --name "$CONTAINER" \
  -p "$PORT":80 "$IMG" || exit
[ "$1" == "start" ] && exit

[ "$#" == 0 ] && set -- bash
exec docker exec -it "$CONTAINER" "$@"


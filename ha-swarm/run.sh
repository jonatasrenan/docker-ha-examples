if ! docker node ls > /dev/null 2>&1; then
  docker swarm init
fi

docker build -t web .
docker stack deploy --compose-file docker-compose.yml web

sleep 5
while true
do
  echo "curl localhost: `curl 127.0.0.1:8000 2> /dev/null`"
  sleep 1
done

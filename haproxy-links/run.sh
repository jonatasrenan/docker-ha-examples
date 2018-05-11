docker-compose up -d
docker-compose scale web=4
while true
do
  echo "curl localhost: `curl localhost 2> /dev/null`"
  sleep 1
done

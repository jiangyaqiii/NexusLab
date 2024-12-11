docker exec -d nexuslab-contain /bin/bash -c 'kill -9 $(pgrep -f "pro")'
sleep 5
docker start nexuslab-contain

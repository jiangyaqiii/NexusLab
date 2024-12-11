docker exec -d nexuslab-contain /bin/bash -c 'kill -9 $(pgrep -f "pro")'
sleep 5
docker start nexuslab-contain
docker exec -d nexuslab-contain /bin/bash -c 'curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_restart.sh |bash'



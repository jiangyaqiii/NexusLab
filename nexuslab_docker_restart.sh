if [[ $(docker ps -qf name=nexuslab-contain) ]]; then
    docker exec -d nexuslab-contain /bin/bash -c 'kill -9 $(pgrep -f "pro")'
    sleep 5
fi
docker start nexuslab-contain
docker exec -d -e proverId="$proverId" nexuslab-contain /bin/bash -c 'cd /root/.nexus && echo "$proverId">prover-id && ./prover beta.orchestrator.nexus.xyz'

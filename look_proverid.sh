# 
if [[ $(docker ps -qf name=nexuslab-container) ]]; then
    docker exec nexuslab-container /bin/bash -c 'cat /root/.nexus/prover-id'
else
    docker exec nexuslab-contain /bin/bash -c 'cat /root/.nexus/prover-id'
fi

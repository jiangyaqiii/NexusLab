docker exec -d nexuslab-contain /bin/bash -c 'kill -9 $(pgrep -f "pro")'
docker start nexuslab-contain

docker exec -d nexuslab-contain /bin/bash -e proverId="$proverId" -w /root ubuntu:22.04 /bin/bash -c "cd /root/.nexus && echo '$proverId'>prover-id && ./prover beta.orchestrator.nexus.xyz"


cd /root/.nexus
echo '$proverId'>prover-id
./prover beta.orchestrator.nexus.xyz

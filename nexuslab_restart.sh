#!/bin/bash
export proverId="${proverId}"
cd /root/.nexus
echo '$proverId'>prover-id
./prover beta.orchestrator.nexus.xyz

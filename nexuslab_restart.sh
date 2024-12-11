prover_pid=$(pgrep -f "pro")
kill -9 $prover_pid
cd "$NEXUS_HOME"
echo "$proverId" > "$PROVER_ID_FILE"
./prover beta.orchestrator.nexus.xyz

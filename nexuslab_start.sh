#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

NEXUS_HOME="$HOME/.nexus"
PROVER_ID_FILE="$NEXUS_HOME/prover-id"
SESSION_NAME="nexus-prover"
PROGRAM_DIR="$NEXUS_HOME/src/generated"
ARCH=$(uname -m)
OS=$(uname -s)
REPO_BASE="https://github.com/nexus-xyz/network-api/raw/refs/tags/0.4.2/clients/cli"

setup_directories() {
    mkdir -p "$PROGRAM_DIR"
    ln -sf "$PROGRAM_DIR" "$NEXUS_HOME/src/generated"
}

check_dependencies() {
    # 添加OpenSSL检查
    apt update
    apt install -y curl sudo
    sudo apt install -y openssl
}

download_program_files() {
    files="cancer-diagnostic fast-fib"

    for file in $files; do
        target_path="$PROGRAM_DIR/$file"
        if [ ! -f "$target_path" ]; then
            echo -e "${YELLOW}下载 $file...${NC}"
            curl -L "$REPO_BASE/src/generated/$file" -o "$target_path"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}$file 下载完成${NC}"
                chmod +x "$target_path"
            else
                echo -e "${RED}$file 下载失败${NC}"
            fi
        fi
    done
}

download_prover() {
    if [ ! -f "$NEXUS_HOME/prover" ]; then
        echo -e "${YELLOW}下载 Linux AMD64 架构 Prover...${NC}"
        curl -L "https://github.com/qzz0518/nexus-run/releases/download/v0.4.2/prover-amd64" -o "$NEXUS_HOME/prover"
        chmod +x "$NEXUS_HOME/prover"
        echo -e "${GREEN}Prover 下载完成${NC}"
    fi
}

download_files() {
    download_prover
    download_program_files
}

generate_prover_id() {
    "./prover" beta.orchestrator.nexus.xyz > tmp.txt 2>&1 &
    prover_pid=$!
    # 等待直到看到成功连接的消息
    while ! grep -q "Success! Connection complete!" tmp.txt 2>/dev/null; do
        if ! kill -0 $prover_pid 2>/dev/null; then
            break
        fi
        sleep 1
    done

    kill $prover_pid 2>/dev/null

    proverId=$(grep -o 'Your current prover identifier is [^ ]*' tmp.txt | cut -d' ' -f6)
    if [ -n "$proverId" ]; then
        echo "$proverId" > "$PROVER_ID_FILE"
        echo -e "${GREEN}已生成并保存新的 Prover ID: $proverId${NC}"
    
    rm tmp.txt
}

start_prover() {
    cd "$NEXUS_HOME"
    generate_prover_id
    # echo "$proverId" > "$PROVER_ID_FILE"
    ./prover beta.orchestrator.nexus.xyz
}

setup_directories
check_dependencies
download_files
start_prover

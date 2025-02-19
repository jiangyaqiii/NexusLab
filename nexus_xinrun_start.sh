#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

VERSION="0.5.0"

NEXUS_HOME="$HOME/.nexus"
NODE_ID_FILE="$NEXUS_HOME/node-id"
ARCH=$(uname -m)
OS=$(uname -s)

echo "\$nrconf{kernelhints} = 0;" >> /etc/needrestart/needrestart.conf
echo "\$nrconf{restart} = 'l';" >> /etc/needrestart/needrestart.conf
source ~/.bashrc

apt install -y screen

set_node_id() {
    # read -p "请输入新的 Node ID: " new_id
    if [ -n "$new_id" ]; then
        echo "$new_id" > "$NODE_ID_FILE"
        echo -e "${GREEN}Node ID 已更新${NC}"
    else
        echo -e "${RED}Node ID 不能为空${NC}"
    fi
}

setup_directories() {
    if [ ! -d "$NEXUS_HOME" ]; then
        echo -e "${YELLOW}创建 $NEXUS_HOME 目录...${NC}"
        mkdir -p "$NEXUS_HOME"
    fi
}
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y build-essential pkg-config libssl-dev git-all
sudo apt install -y protobuf-compiler
setup_directories
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.bashrc
set_node_id

screen -d -m -S nexus bash -c "curl https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/beta.sh | sh"
cd ~
rm -f nexus_xinrun_start.sh

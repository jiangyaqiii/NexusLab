#!/bin/bash

# 检查是否以 root 用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以 root 用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到 root 用户，然后再次运行此脚本。"
    exit 1
fi

echo "\$nrconf{kernelhints} = 0;" >> /etc/needrestart/needrestart.conf
echo "\$nrconf{restart} = 'l';" >> /etc/needrestart/needrestart.conf
source ~/.bashrc

# 检查并安装Docker
if ! command -v docker &> /dev/null; then
    echo "未检测到 Docker，正在安装..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo -e "n" | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    echo "Docker 已安装。"
else
    echo "Docker 已安装。"
fi

# export usertoken=1
if [[ $(docker ps -qf name=nexuslab-contain) ]]; then
    echo "已存在grass容器，停止此容器"
    docker stop 
    docker rm nexuslab-contain
fi
echo ''
echo '启动新容器'
docker run -d --name nexuslab-contain -e PATH="/root/.local/bin:$PATH" -w /root ubuntu:22.04 /bin/bash -c " apt-get update && apt-get install -y wget && wget -O nexuslab_start.sh https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_start.sh && chmod +x nexuslab_start.sh &&./nexuslab_start.sh"
rm -f nexuslab_docker.sh

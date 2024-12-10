# NexusLab

# 检查状态
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_status.sh |bash

# 启动服务

#export proverId

wget -O nexuslab_docker.sh https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_docker.sh && chmod +x nexuslab_docker.sh && ./nexuslab_docker.sh

# 查看proverId
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/look_proverid.sh |bash

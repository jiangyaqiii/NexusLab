# NexusLab

# 检查状态
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_status.sh |bash

# 启动服务

#export new_id

wget -O nexuslab_xinrun_start.sh https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_xinrun_start.sh && chmod +x nexuslab_xinrun_start.sh && ./nexuslab_xinrun_start.sh

# 查看proverId
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/look_proverid.sh |bash


# 重启（自带proverId）
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_docker_restart.sh |bash

# 容器内重启（自带proverId）
curl -s https://raw.githubusercontent.com/jiangyaqiii/NexusLab/main/nexuslab_restart.sh |bash

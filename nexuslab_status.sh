#!/bin/bash

if [[ $(docker ps -qf name=nexuslab-contain) ]]; then
    echo "nexuslab正在运行"
else
    echo "停止"
fi
#!/bin/bash
# # 安装node
source /root/.bashrc
tnvm install node-v12.15.0 && tnvm use node-v12.15.0 && node -v
# # 设置淘宝镜像
npm install -g cnpm --registry=https://registry.npm.taobao.org
tnvm install alinode-v5.15.0 && tnvm use alinode-v5.15.0 && which node
# # 安装监控和pm2
cnpm install @alicloud/agenthub -g && cnpm install pm2 -g && which pm2
# # 设置环境变量
export NODE_LOG_DIR=/tmp && export ENABLE_NODE_LOG=YES
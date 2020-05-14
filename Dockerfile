FROM codeboy/ubuntu-bash:18.04
USER root
COPY ./sources.list /etc/apt/sources.list
SHELL ["/bin/bash", "--login", "-c"]
# 更换镜像源
RUN apt-get update && \
apt-get install -y wget sudo
# 安装 Node.js 性能平台运行时
RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh --no-check-certificate | bash
RUN source /root/.bashrc && [ -s /root/.tnvm/tnvm.sh ] && source /root/.tnvm/tnvm.sh && tnvm -v && \
# 安装node
tnvm install node-v12.15.0 && tnvm use node-v12.15.0 && node -v && \
# 设置淘宝镜像
npm install -g cnpm --registry=https://registry.npm.taobao.org && \
tnvm install alinode-v5.15.0 && tnvm use alinode-v5.15.0 && which node && \
# 安装监控和pm2
npm install @alicloud/agenthub pm2 yarn -g --registry=https://registry.npm.taobao.org && which pm2 && \
# 设置环境变量
export NODE_LOG_DIR=/tmp && export ENABLE_NODE_LOG=YES
RUN source /root/.tnvm/tnvm.sh
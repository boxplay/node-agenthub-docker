FROM codeboy/ubuntu-bash:18.04
USER root
COPY ./sources.list /etc/apt/sources.list
SHELL ["/bin/bash", "--login", "-c"]
# 更换镜像源
RUN apt-get update && \
apt-get install -y wget sudo
# 安装 Node.js 性能平台运行时
ENV ALINODE_VERSION v6.0.0
ENV NODE_VERSION v14.0.0
ENV ALINODE_BIN_DIR /root/.tnvm/versions/alinode/$ALINODE_VERSION/bin

# install alinode
RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash
RUN source ~/.tnvm/tnvm.sh && tnvm -v && \
# 安装node
tnvm install node-$NODE_VERSION && tnvm use node-$NODE_VERSION && node -v && \
# 设置淘宝镜像
npm install -g cnpm --registry=https://registry.npm.taobao.org && \
tnvm install alinode-$ALINODE_VERSION && tnvm use alinode-$ALINODE_VERSION && which node && \
# 安装监控和pm2
npm install @alicloud/agenthub pm2 yarn -g --registry=https://registry.npm.taobao.org && which yarn && \
# 设置环境变量
export NODE_LOG_DIR=/tmp && export ENABLE_NODE_LOG=YES 

RUN ln -s $ALINODE_BIN_DIR/* /usr/bin && which node
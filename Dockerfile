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
RUN echo alias node=$ALINODE_BIN_DIR/node >> /root/.bashrc \
&& echo alias npm=$ALINODE_BIN_DIR/npm  >> /root/.bashrc \
&& echo alias npx=$ALINODE_BIN_DIR/npx  >> /root/.bashrc \
&& echo alias yarn=$ALINODE_BIN_DIR/yarn  >> /root/.bashrc \
&& echo alias pm2=$ALINODE_BIN_DIR/pm2  >> /root/.bashrc \
&& echo alias pm2-dev=$ALINODE_BIN_DIR/pm2-dev  >> /root/.bashrc \
&& echo alias pm2-docker=$ALINODE_BIN_DIR/pm2-docker  >> /root/.bashrc \
&& echo alias pm2-runtime=$ALINODE_BIN_DIR/pm2-runtime  >> /root/.bashrc \
&& echo alias pm2-runtime=$ALINODE_BIN_DIR/pm2-runtime  >> /root/.bashrc \
&& echo alias yarnpkg=$ALINODE_BIN_DIR/yarnpkg >> /root/.bashrc \
&& echo alias agenthub=$ALINODE_BIN_DIR/agenthub >> /root/.bashrc \
&& echo alias node-kill=$ALINODE_BIN_DIR/node-kill >> /root/.bashrc
RUN source /root/.bashrc
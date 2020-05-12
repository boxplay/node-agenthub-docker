#/bin/bash
parm=$1
export NODE_LOG_DIR=/tmp
export ENABLE_NODE_LOG=YES
DEBUG=* agenthub start config-${parm}.json
yarn && npm run build:prod
ENABLE_NODE_LOG=YES NODE_LOG_DIR=/tmp `which pm2-runtime` start ecosystem.config.js --env ${parm}
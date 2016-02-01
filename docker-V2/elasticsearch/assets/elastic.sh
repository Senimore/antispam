#!/bin/bash
NAME=elasticsearch
ES_HOME=/usr/share/$NAME
LOG_DIR=/var/log/$NAME
DATA_DIR=/var/lib/$NAME
CONF_DIR=/etc/$NAME
PID_DIR="/var/run/elasticsearch"
PID_FILE="$PID_DIR/$NAME.pid"

exec /sbin/setuser elasticsearch /usr/share/elasticsearch/bin/elasticsearch -p $PID_FILE --default.path.home=$ES_HOME --default.path.logs=$LOG_DIR --default.path.data=$DATA_DIR --default.path.conf=$CONF_DIR \
--network.bind_host 0.0.0.0 --network.publish_host _non_loopback:ipv4_  ${ELASTICSEARCH_USER_PARAMS}
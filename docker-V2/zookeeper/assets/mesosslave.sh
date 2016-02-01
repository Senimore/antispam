#!/bin/sh

echo ${MYID:-1} > /tmp/zookeeper/myid

# based on https://github.com/apache/zookeeper/blob/trunk/conf/zoo_sample.cfg
cat > /opt/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/tmp/zookeeper
clientPort=2181
server.1=${ZOOKEEPER_SERVER_1}
server.2=${ZOOKEEPER_SERVER_2}
server.3=${ZOOKEEPER_SERVER_3}

EOF


exec zkServer.sh start-foreground

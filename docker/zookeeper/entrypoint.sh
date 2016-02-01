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

# for i in $(compgen -A variable | grep -E "ZOOKEEPER_SERVER_[0-9]{1,3}"); do
#    server_id=$(echo "$i" | grep -P -o '(?<=ZOOKEEPER_SERVER_)[0-9]{1,3}')
#    server_address="${!i}"
#    echo "[$(date)][Zookeeper][server.$server_id] $server_address"
#    if [[ $(grep -ci "^server.$server_id" /opt/zookeeper/conf/zoo.cfg) -eq 1 ]]; then
#        sed -e "s/server.$server_id=.*/server.$server_id=$server_address/" -i /opt/zookeeper/conf/zoo.cfg
#    else     
#        echo "server.$server_id=$server_address" >> /opt/zookeeper/conf/zoo.cfg
#    fi
#  done



exec "$@"

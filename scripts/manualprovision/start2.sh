#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi $(docker images -q)


HOST_IP_1=192.168.56.51
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53


docker pull senimore/zoo
docker run -d \
-e MYID=2 \
-e ZOOKEEPER_SERVER_1=${HOST_IP_1}:2888:3888 \
-e ZOOKEEPER_SERVER_2=${HOST_IP_2}:2888:3888 \
-e ZOOKEEPER_SERVER_3=${HOST_IP_3}:2888:3888 \
--name=zookeeper --net host --restart=always senimore/zoo


docker pull senimore/mesosmaster
docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP_2} \
-e MESOS_IP=${HOST_IP_2} \
-e MESOS_LOG_DIR=/var/log \
-e MESOS_CLUSTER=antispam \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesos-master --net host --restart always senimore/mesosmaster


docker pull senimore/mesosslave
docker run -d \
-e MESOS_HOSTNAME=${HOST_IP_2} \
-e MESOS_IP=${HOST_IP_2} \
-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesos-slave --net host --privileged --restart always \
senimore/mesosslave


docker pull senimore/haproxy
docker run -d \
-e ZK=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxy


docker pull senimore/elastic
docker run -d \
-e ELASTICSEARCH_USER_PARAMS="--cluster.name=antispam --node.name=node10 --discovery.zen.ping.unicast.hosts ${HOST_IP_1},${HOST_IP_2},${HOST_IP_3}" \
--name=elasticsearch --net=host --restart=always senimore/elastic



docker pull senimore/logstash
docker run -d --name=logstash --restart=always -p 5044:5044 \
--hostname logstash.$(hostname) \
--env LS_ES_CONN_STR=${HOST_IP_1}:9200,${HOST_IP_2}:9200,${HOST_IP_3}:9200 senimore/logstash


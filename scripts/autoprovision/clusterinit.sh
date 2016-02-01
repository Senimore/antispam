#!/bin/bash
#Create 3 Mesos Master nodes

eval "$(./conf.sh)"

docker-machine  rm ${NAME1}
docker-machine  rm ${NAME2}
docker-machine  rm ${NAME3}
MACHINEOPTS="--engine-registry-mirror=http://${REGMIRROR} --virtualbox-hostonly-cidr ${VBOXCIDR} --driver=virtualbox"


docker-machine create --virtualbox-memory 6144 ${MACHINEOPTS} ${NAME1}
docker-machine create --virtualbox-memory 4096 ${MACHINEOPTS} ${NAME2}
docker-machine create --virtualbox-memory 4096 ${MACHINEOPTS} ${NAME3}

HOST_IP_1="$(docker-machine ip ${NAME1})"
HOST_IP_2="$(docker-machine ip ${NAME2})"
HOST_IP_3="$(docker-machine ip ${NAME3})"




echo "Master nodes IP is ${HOST_IP_1} ${HOST_IP_2} ${HOST_IP_3}"

eval "$(docker-machine env ${NAME1})"

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi $(docker images -q)



docker run -d \
-e MYID=1 \
-e ZOOKEEPER_SERVER_1=${HOST_IP_1}:2888:3888 \
-e ZOOKEEPER_SERVER_2=${HOST_IP_2}:2888:3888 \
-e ZOOKEEPER_SERVER_3=${HOST_IP_3}:2888:3888 \
--name=zookeeper --net host --restart=always senimore/zoo

docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP_1} \
-e MESOS_IP=${HOST_IP_1} \
-e MESOS_LOG_DIR=/var/log \
-e MESOS_CLUSTER=antispam \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesosmaster --net host --restart always senimore/mesosmaster

#docker run -d \
#-e MESOS_HOSTNAME=${HOST_IP_1} \
#-e MESOS_IP=${HOST_IP_1} \
#-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
#-v /sys/fs/cgroup:/sys/fs/cgroup \
#-v /var/run/docker.sock:/var/run/docker.sock \
#--name slave --net host --privileged --restart always \
#senimore/mesosslave

docker run -d \
-e MARATHON_HOSTNAME=${HOST_IP_1} \
-e MARATHON_HTTPS_ADDRESS=${HOST_IP_1} \
-e MARATHON_HTTP_ADDRESS=${HOST_IP_1} \
-e MARATHON_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MARATHON_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/marathon \
--name marathon --net host --restart always senimore/marathon

docker run -d \
-e MARATHON=${HOST_IP_1}:8080 \
-e ZK=${HOST_IP_1}:2181 \
--name=haproxymarathon --net=host --restart=always senimore/haproxymarathon

docker run -d \
-e ZK=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxy

docker run -d \
--name=elasticsearch --net host --restart=always senimore/elastic \
--cluster.name=antispam --node.name=node1 --discovery.zen.ping.unicast.hosts ${HOST_IP_1},${HOST_IP_2},${HOST_IP_3}.




docker run -d \
--net host \
--name=kibana --restart=always senimore/kibana

docker run -d --name=logstash --restart=always -p 5044:5044 \
--hostname logstash.$(hostname) \
--env LS_ES_CONN_STR=${HOST_IP_1}:9200,${HOST_IP_2}:9200,${HOST_IP_3}:9200 senimore/logstash

docker run -d \
-e CHRONOS_HOSTNAME=${HOST_IP_1} \
-e CHRONOS_HTTP_PORT=4400 \
-e CHRONOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e CHRONOS_ZK_HOSTS=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name chronos --net host --restart always senimore/chronos




eval "$(docker-machine env ${NAME2})"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker run -d \
-e MYID=2 \
-e ZOOKEEPER_SERVER_1=${HOST_IP_1}:2888:3888 \
-e ZOOKEEPER_SERVER_2=${HOST_IP_2}:2888:3888 \
-e ZOOKEEPER_SERVER_3=${HOST_IP_3}:2888:3888 \

--name=zookeeper --net host --restart=always senimore/zoo

docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP_2} \
-e MESOS_IP=${HOST_IP_2} \
-e MESOS_LOG_DIR=/var/log \
-e MESOS_CLUSTER=antispam \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesosmaster --net host --restart always senimore/mesosmaster

docker run -d \
-e MESOS_HOSTNAME=${HOST_IP_2} \
-e MESOS_IP=${HOST_IP_2} \
-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesosslave --net host --privileged --restart always \
senimore/mesosslave

docker run -d \
-e ZK=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxy


docker run -d \
--name=elasticsearch --net host --restart=always senimore/elastic \
--cluster.name=antispam --node.name=node2 --discovery.zen.ping.unicast.hosts ${HOST_IP_1},${HOST_IP_2},${HOST_IP_3}.


docker run -d --name=logstash --restart=always -p 5044:5044 \
--hostname logstash.$(hostname) \
--env LS_ES_CONN_STR=${HOST_IP_1}:9200,${HOST_IP_2}:9200,${HOST_IP_3}:9200 senimore/logstash

eval "$(docker-machine env ${NAME3})"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker run -d \
-e MYID=3 \
-e ZOOKEEPER_SERVER_1=${HOST_IP_1}:2888:3888 \
-e ZOOKEEPER_SERVER_2=${HOST_IP_2}:2888:3888 \
-e ZOOKEEPER_SERVER_3=${HOST_IP_3}:2888:3888 \
--name=zookeeper --net host --restart=always senimore/zoo

docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP_3} \
-e MESOS_IP=${HOST_IP_3} \
-e MESOS_LOG_DIR=/var/log \
-e MESOS_CLUSTER=antispam \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesosmaster --net host --restart always senimore/mesosmaster

docker run -d \
-e MESOS_HOSTNAME=${HOST_IP_3} \
-e MESOS_IP=${HOST_IP_3} \
-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesosslave --net host --privileged --restart always \
senimore/mesosslave

docker run -d \
-e ZK=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxy



docker run -d \
--name=elasticsearch --net host --restart=always senimore/elastic \
--cluster.name=antispam --node.name=node3 --discovery.zen.ping.unicast.hosts ${HOST_IP_1},${HOST_IP_2},${HOST_IP_3}.



docker run -d --name=logstash --restart=always -p 5044:5044 \
--hostname logstash.$(hostname) \
--env LS_ES_CONN_STR=${HOST_IP_1}:9200,${HOST_IP_2}:9200,${HOST_IP_3}:9200 senimore/logstash


echo "Cluster is running on hosts:  ${HOST_IP_1} ${HOST_IP_2} ${HOST_IP_3}"
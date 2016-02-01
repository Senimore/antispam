#!/bin/bash

docker stop marathon
docker rm marathon

HOST_IP_1=192.168.56.50
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53


docker run -d \
-e MARATHON_HOSTNAME=${HOST_IP_1} \
-e MARATHON_HTTPS_ADDRESS=${HOST_IP_1} \
-e MARATHON_HTTP_ADDRESS=${HOST_IP_1} \
-e MARATHON_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MARATHON_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/marathon \
--name marathon --net host --restart always senimore/marathon
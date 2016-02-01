#!/bin/bash

docker stop mesosmaster
docker rm mesosmaster

HOST_IP_1=192.168.56.50
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53

docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP_1} \
-e MESOS_IP=${HOST_IP_1} \
-e MESOS_QUORUM=2 \
-e MESOS_ZK=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesosmaster --net=host senimore/mesosmaster
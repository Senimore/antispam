#!/bin/bash

docker stop mesosmaster
docker rm mesosmaster

docker run -d \
-p 5050:5050 \
-e MESOS_HOSTNAME=${HOST_IP1} \
-e MESOS_IP=${HOST_IP1} \
-e MESOS_QUORUM=2 \
-e MESOS_ZK=zk://${HOST_IP1}:2181,${HOST_IP2}:2181,${HOST_IP3}:2181/mesos \
-e MESOS_PORT=5050 \
--name mesosmaster --net=host senimore/mesosmaster
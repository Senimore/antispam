#!/bin/bash

docker stop marathon
docker rm marathon

docker run -d \
-e MARATHON_HOSTNAME=${HOST_IP1} \
-e MARATHON_HTTPS_ADDRESS=${HOST_IP1} \
-e MARATHON_HTTP_ADDRESS=${HOST_IP1} \
-e MARATHON_MASTER=zk://${HOST_IP1}:2181,${HOST_IP2}:2181,${HOST_IP3}:2181/mesos \
-e MARATHON_ZK=zk://${HOST_IP1}:2181,${HOST_IP2}:2181,${HOST_IP3}:2181/marathon \
--name marathon --net host --restart always senimore/marathon
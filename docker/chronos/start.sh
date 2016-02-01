#!/bin/bash

docker run -d \
-e CHRONOS_HTTP_PORT=4400 \
-e CHRONOS_MASTER=zk://${HOST_IP1}:2181,${HOST_IP2}:2181,${HOST_IP3}:2181/mesos \
-e CHRONOS_ZK_HOSTS=${HOST_IP1}:2181,${HOST_IP2}:2181,${HOST_IP3}:2181 \
--name chronos --net host --restart always senimore/chronos
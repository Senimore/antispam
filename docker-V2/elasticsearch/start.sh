#!/bin/bash
docker stop elasticsearch
docker rm elasticsearch

HOST_IP_1=192.168.56.51
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53


docker run -d \
-e ELASTICSEARCH_USER_PARAMS="--cluster.name=antispam --node.name=node10 --discovery.zen.ping.unicast.hosts ${HOST_IP_1},${HOST_IP_2},${HOST_IP_3}" \
--name=elasticsearch --net=host --restart=always senimore/elastic
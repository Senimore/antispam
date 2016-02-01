#!/bin/bash

docker stop kibana
docker rm kibana

HOST_IP_1=192.168.56.51
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53


docker run -d \
-e ES_HOST=${HOST_IP_2} \
-e ES_PORT=9200 \
-p 5601:5601 \
--name=kibana --restart=always senimore/kibana

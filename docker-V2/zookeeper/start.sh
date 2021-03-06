#!/bin/bash

docker stop zookeeper
docker rm zookeper

HOST_IP_1=192.168.56.50
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53


docker run -d \
-e MYID=10 \
-e ZOOKEEPER_SERVER_1=${HOST_IP_1}:2888:3888 \
-e ZOOKEEPER_SERVER_2=${HOST_IP_2}:2888:3888 \
-e ZOOKEEPER_SERVER_3=${HOST_IP_3}:2888:3888 \
--name=zookeeper --net=host --restart=always senimore/zoo
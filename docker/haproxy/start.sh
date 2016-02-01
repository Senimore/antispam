#!/bin/bash
HOST_IP_1=192.168.56.51
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53

docker run -d \
-e ZK=${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxy
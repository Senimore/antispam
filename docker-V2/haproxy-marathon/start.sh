#!/bin/bash

docker run -d \
-e MARATHON=${HOST_IP1}:8080 \
-e ZK=${HOST_IP1}:2181 \
--name=haproxy --net=host --restart=always senimore/haproxymarathon
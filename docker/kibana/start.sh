#!/bin/bash

#docker stop kibana
#docker rm kibana

docker run -d \
--net host \
--name=kibana --restart=always senimore/kibana

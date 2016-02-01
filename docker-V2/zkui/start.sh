#!/bin/bash

docker run -d --name zkui -p 9090:9090 \
-e ZK=192.168.56.51:2181,192.168.56.52:2181,,192.168.56.53:2181 \
--restart=always senimore/zkui
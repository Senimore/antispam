#!/bin/bash
docker stop elasticsearch
docker rm elasticsearch

docker run -d \
--name=elasticsearch -p 9200:9200 -p 9300:9300 --restart=always senimore/elastic --cluster.name=antispam --node.name=node1 --discovery.zen.ping.unicast.hosts 192.168.56.52,192.168.56.53,192.168.56.51
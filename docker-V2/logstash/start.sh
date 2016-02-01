#!/bin/bash
docker stop logstash
docker rm logstash


HOST_IP_1=192.168.56.51
HOST_IP_2=192.168.56.52
HOST_IP_3=192.168.56.53

docker run -d --name=logstash --restart=always -v /var/log:/var/log -p 5044:5044 \
--hostname logstash.$(hostname) -e LS_ES_CONN_STR=${HOST_IP_1}:9200,${HOST_IP_2}:9200,${HOST_IP_3}:9200 senimore/logstash


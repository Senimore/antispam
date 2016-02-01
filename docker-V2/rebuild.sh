#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi $(docker images -q)


find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && ./build.sh" \;

if [ "$1" = "push" ]; then
docker push senimore/baseimage
docker push senimore/trusty_java8
docker push senimore/zoo
docker push senimore/mesosmaster
docker push senimore/mesosslave
docker push senimore/marathon
docker push senimore/haproxymarathon
docker push senimore/haproxy
docker push senimore/chronos
docker push senimore/elastic
docker push senimore/logstash
docker push senimore/kibana
docker push senimore/events
docker push senimore/mailscanner

else
echo "Images was not pushed!!"
fi
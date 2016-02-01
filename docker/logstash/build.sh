#!/bin/bash

docker stop logstash
docker rm logstash
docker rmi senimore/logstash

docker build -t senimore/logstash .
#!/bin/bash

function int-ip { /sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'; }


docker stop mesosslave
docker rm mesosslave

HOST_IP_1=192.168.56.67
HOST_IP_2=192.168.56.68
HOST_IP_3=192.168.56.69
HOST_SLAVE=`int-ip eth0`

echo "Starting mesos slave on ${HOST_SLAVE}"

docker run -d \
-e MESOS_HOSTNAME=${HOST_SLAVE} \
-e MESOS_IP=${HOST_SLAVE} \
-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesosslave --net host --privileged --restart always \
senimore/mesosslave


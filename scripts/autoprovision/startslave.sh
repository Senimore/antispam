#!/bin/bash

NAME1=mmas1
NAME2=mmas2
NAME3=mmas3


HOST_IP_1="$(docker-machine ip ${NAME1})"
HOST_IP_2="$(docker-machine ip ${NAME2})"
HOST_IP_3="$(docker-machine ip ${NAME3})"

SLAVE_NAME=$1

docker-machine rm ${SLAVE_NAME}

docker-machine create --virtualbox-memory 4048 --virtualbox-hostonly-cidr "192.168.56.1/24" --driver=virtualbox ${SLAVE_NAME}

SLAVE_IP="$(docker-machine ip $1)"


echo "Starting slave on  ${SLAVE_IP} "

eval "$(docker-machine env ${SLAVE_NAME})"


echo "Starting mesos slave on ${HOST_SLAVE}"

docker run -d \
-e MESOS_HOSTNAME=${SLAVE_IP} \
-e MESOS_IP=${SLAVE_IP} \
-e MESOS_MASTER=zk://${HOST_IP_1}:2181,${HOST_IP_2}:2181,${HOST_IP_3}:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name slave --net host --privileged --restart always \
senimore/mesosslave


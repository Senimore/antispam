#!/bin/bash
eval "$(./conf.sh)"

HOST_IP_1="$(docker-machine ip ${NAME1})"
HOST_IP_2="$(docker-machine ip ${NAME2})"
HOST_IP_3="$(docker-machine ip ${NAME3})"




echo "Cluster masters is running on  ${HOST_IP_1} ${HOST_IP_2} ${HOST_IP_3}"




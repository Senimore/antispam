#!/bin/bash
eval "$(./conf.sh)"
docker-machine  rm ${NAME1}
docker-machine  rm ${NAME2}
docker-machine  rm ${NAME3}





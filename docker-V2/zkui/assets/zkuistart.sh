#!/bin/bash

echo "zkServer=${ZK}" >>  /var/app/config.cfg
WORKING_DIR=/var/app
cd $WORKING_DIR

exec java -jar /var/app/zkui.jar
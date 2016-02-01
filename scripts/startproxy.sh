#!/bin/bash

docker run -d --restart=always -p 5555:5555 --name proxy \
-v /data:/var/lib/registry registry:2 /var/lib/registry/config.yml

#!/bin/bash

docker run -d \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /srv/events:/srv/events \
--name=events --restart=always senimore/events
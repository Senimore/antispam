#!/bin/bash

docker stop outrouter
docker rm outrouter

docker run -p 25:25  -v /opt/mail/spool:/var/spool/postfix  -v /root/domainkeys:/etc/opendkim/domainkeys --hostname outrouter.$(hostname) --name outrouter -d  senimore/outrouter
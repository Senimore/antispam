#!/bin/bash 

exec /usr/bin/filebeat-god -f -r / -n -p /var/run/filebeat.pid -- /usr/bin/filebeat -c /etc/filebeat/filebeat.yml
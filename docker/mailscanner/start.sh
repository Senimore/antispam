#!/bin/bash


docker run -p 25:25  -v /var/spool -v /var/log  -v /root/domainkeys:/etc/opendkim/domainkeys --hostname mailscan.$(hostname) --name mailscanner -d  senimore/mailscanner
#!/bin/bash


docker run -p 10024:10024  -v /var/spool -v /var/log  -v /root/domainkeys:/etc/opendkim/domainkeys --hostname mailscan.$(hostname) --name mailscanner -d  senimore/mailscanner2
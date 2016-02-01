#!/bin/bash 

#service postfix start

chown -R postfix:postfix /var/spool/postfix
chown -R root:root /var/spool/postfix/etc
chown -R root:root /var/spool/postfix/lib
chown -R root:root /var/spool/postfix/usr
chown -R root:root /var/spool/postfix/pid
chown  root:root /var/spool/postfix

chown -R postfix:postdrop /var/spool/postfix/public
chown -R postfix:postdrop /var/spool/postfix/maildrop

command_directory=`postconf -h command_directory`
daemon_directory=`$command_directory/postconf -h daemon_directory`

# make consistency check
$command_directory/postfix check 2>&1

# run Postfix
exec $daemon_directory/master 2>&1
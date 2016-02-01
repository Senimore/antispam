#!/bin/bash

if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=false

[program:postfix]
command=/opt/postfix.sh

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3


EOF



############
#  postfix
############
cat >> /opt/postfix.sh <<EOF
#!/bin/bash
service postfix start
service filebeat start
busybox tail -F /var/log/mail.log
EOF

chmod +x /opt/postfix.sh


#############
#  opendkim
#############

if [[ -z "$(find /etc/opendkim/domainkeys -iname *.private)" ]]; then
  exit 0
fi
cat >> /etc/supervisor/conf.d/supervisord.conf <<EOF

[program:opendkim]
command=/usr/sbin/opendkim -f
EOF
# /etc/postfix/main.cf
postconf -e milter_protocol=2
postconf -e milter_default_action=accept
postconf -e smtpd_milters=inet:localhost:12301
postconf -e non_smtpd_milters=inet:localhost:12301

cat >> /etc/opendkim.conf <<EOF
AutoRestart             Yes
AutoRestartRate         10/1h
UMask                   002
Syslog                  yes
SyslogSuccess           Yes
LogWhy                  Yes

Canonicalization        relaxed/simple

ExternalIgnoreList      refile:/etc/opendkim/TrustedHosts
InternalHosts           refile:/etc/opendkim/TrustedHosts
KeyTable                refile:/etc/opendkim/KeyTable
SigningTable            refile:/etc/opendkim/SigningTable

Mode                    sv
PidFile                 /var/run/opendkim/opendkim.pid
SignatureAlgorithm      rsa-sha256

UserID                  opendkim:opendkim

Socket                  inet:12301@localhost
EOF
cat >> /etc/default/opendkim <<EOF
SOCKET="inet:12301@localhost"
EOF

cat >> /etc/opendkim/TrustedHosts <<EOF
127.0.0.1
localhost
*.$maildomain
EOF
cat >> /etc/opendkim/KeyTable <<EOF
bridge._domainkey.$maildomain $maildomain:bridge:$(find /etc/opendkim/domainkeys -iname *.private)
EOF
cat >> /etc/opendkim/SigningTable <<EOF
*@$maildomain bridge._domainkey.$maildomain
EOF
chown opendkim:opendkim $(find /etc/opendkim/domainkeys -iname *.private) /etc/opendkim/domainkeys

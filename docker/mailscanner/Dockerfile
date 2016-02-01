FROM ubuntu:trusty
MAINTAINER senimore@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen ru_RU ru_RU.UTF-8 && dpkg-reconfigure locales


RUN apt-get update -qq && \
    apt-get -y install supervisor postfix opendkim opendkim-tools curl busybox wget rsync dnsutils apt-transport-https && \
    mkdir /opt/mailscanner

ADD assets/ /opt

RUN /opt/mailscan/mailscanner.sh 

RUN cp /opt/mailscan/mailscanner /etc/default/mailscanner && \
    cp /opt/mailscan/MailScanner.conf /etc/MailScanner/MailScanner.conf  && \
    rm -rf /etc/postfix && \
    cp -R /opt/postfix /etc/postfix &&\
    chown -R postfix /var/spool/postfix && \
    postmap /etc/postfix/relay_domains &&\
    postmap /etc/postfix/transport_maps
    
RUN echo "10 * * * * root /bin/bash /opt/clamav/updateclamav.sh  > /dev/null" >> /etc/crontab &&\
    echo "loadplugin Mail::SpamAssassin::Plugin::DCC" >>/etc/spamassassin/v310.pre

RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list && \
    apt-get update && \
    sudo apt-get install filebeat 

RUN rm -rf /etc/filebeat &&\
    cp  -R /opt/filebeat /etc/filebeat

RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.


VOLUME /var/spool
VOLUME /var/log



# Run
CMD cron;/opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf;busybox tail -F /var/log/mail.log
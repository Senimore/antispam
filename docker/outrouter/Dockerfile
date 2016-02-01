FROM ubuntu:trusty
MAINTAINER senimore@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen ru_RU ru_RU.UTF-8 && dpkg-reconfigure locales


RUN apt-get update -qq && \
    apt-get -y install supervisor postfix opendkim opendkim-tools apt-transport-https curl busybox

ADD assets/ /opt


RUN rm -rf /etc/postfix && \
    cp -R /opt/postfix /etc/postfix &&\
    chown -R postfix /var/spool/postfix && \
    postmap /etc/postfix/relay_domains &&\
    postmap /etc/postfix/transport_maps
    

RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list && \
    apt-get update && \
    sudo apt-get install filebeat 

RUN rm -rf /etc/filebeat &&\
    cp  -R /opt/filebeat /etc/filebeat

RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.


VOLUME /opt/mail/spool:/var/spool

expose 25

# Run
CMD cron;/opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf;busybox tail -F /var/log/mail.log
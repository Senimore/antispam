FROM senimore/baseimage
MAINTAINER senimore@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list 

RUN apt-get update -qq && \
    apt-get -y install supervisor postfix opendkim opendkim-tools curl busybox wget rsync dnsutils filebeat

ADD assets/ /opt

RUN /opt/mailscan/mailscanner.sh

RUN cp /opt/mailscan/mailscanner /etc/default/mailscanner && \
    rm -rf /etc/postfix && \
    cp -R /opt/postfix /etc/postfix &&\
    rm -rf /etc/spamassassin && \
    cp -R /opt/spamassassin /etc/spamassassin &&\
    rm -rf /etc/MailScanner && \
    cp -R /opt/MailScanner /etc/MailScanner &&\
    rm -rf /etc/filebeat &&\
    cp  -R /opt/filebeat /etc/filebeat


RUN chown -R postfix /var/spool/postfix && \
    postmap /etc/postfix/relay_domains &&\
    postmap /etc/postfix/transport_maps


RUN mkdir /etc/service/postfix
ADD assets/startup/postfix.sh /etc/service/postfix/run

RUN mkdir /etc/service/mailscanner
ADD assets/startup/mailscanner.sh /etc/service/mailscanner/run

RUN mkdir /etc/service/filebeat
ADD assets/startup/filebeat.sh /etc/service/filebeat/run


RUN echo "10 * * * * root /bin/bash /opt/clamav/updateclamav.sh  > /dev/null" >> /etc/crontab


RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.


VOLUME /var/spool
VOLUME /var/log
EXPOSE 10024

CMD ["/sbin/my_init"]
FROM senimore/baseimage
MAINTAINER senimore@gmail.com

RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list 

RUN apt-get update -qq && \
    apt-get -y install postfix filebeat

ADD assets/ /opt


RUN rm -rf /etc/postfix && \
    cp -R /opt/postfix /etc/postfix &&\
    chown -R postfix /var/spool/postfix && \
    postmap /etc/postfix/relay_domains &&\
    postmap /etc/postfix/transport_maps

RUN rm -rf /etc/filebeat &&\
    cp  -R /opt/filebeat /etc/filebeat



RUN mkdir /etc/service/postfix
ADD assets/startup/postfix.sh /etc/service/postfix/run


RUN mkdir /etc/service/filebeat
ADD assets/startup/filebeat.sh /etc/service/filebeat/run


RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.


VOLUME /opt/mail/spool:/var/spool

expose 25


CMD ["/sbin/my_init"]

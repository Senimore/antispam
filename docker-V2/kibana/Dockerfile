FROM senimore/baseimage
MAINTAINER senimore@gmail.com

RUN curl -fL https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz | tar xzf - -C /opt && \
mv /opt/kibana-4.3.1-linux-x64 /opt/kibana

ADD assets/kibana.yml /opt/kibana/config/

RUN mkdir /etc/service/kibana
ADD assets/kibanastart.sh /etc/service/kibana/run


EXPOSE 5601

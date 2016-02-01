FROM senimore/baseimage
MAINTAINER senimore@gmail.com

RUN apt-get update && apt-get install -y curl gcc libpcre3-dev libssl-dev make python3 python3-pip

RUN curl -fL http://www.haproxy.org/download/1.5/src/haproxy-1.5.14.tar.gz | tar xzf - -C /usr/src && \
cd /usr/src/haproxy-1.5.14 && \
make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 && \
make install && \
cd .. && \
rm -rf /usr/src/haproxy-1.5.14

RUN pip3 install kazoo

RUN mkdir -p /etc/haproxy

ENV HAPROXY_PEM /etc/haproxy/site.pem

RUN mkdir /etc/service/haproxy
ADD assets/haproxymar.sh /etc/service/haproxy/run
ADD assets/init.py /etc/service/haproxy

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD ["/sbin/my_init"]




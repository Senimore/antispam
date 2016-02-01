FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN curl -fL http://apache.mirror.digitalpacific.com.au/zookeeper/stable/zookeeper-3.4.6.tar.gz | tar xzf - -C /opt && \
mv /opt/zookeeper-3.4.6 /opt/zookeeper

VOLUME /tmp/zookeeper

RUN mkdir /etc/service/mesosslave
ADD assets/mesosslave.sh /etc/service/mesosslave/run


ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zookeeper/bin


EXPOSE 2181 2888 3888


CMD ["/sbin/my_init"]


FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install mesos

CMD ["/usr/sbin/mesos-master"]

ENV MESOS_WORK_DIR /tmp/mesos

RUN mkdir /etc/service/mesosmaster
ADD assets/mesosmaster.sh /etc/service/mesosmaster/run


VOLUME /tmp/mesos

RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.

EXPOSE 5050

CMD ["/sbin/my_init"]


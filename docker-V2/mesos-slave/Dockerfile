FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
    apt-get update && \
    apt-get -y install mesos

    # http://docs.docker.com/installation/ubuntulinux/
RUN curl -fLsS https://get.docker.com/ | sh


RUN mkdir /etc/service/mesosslave
ADD assets/mesosslave.sh /etc/service/mesosslave/run

ENV MESOS_WORK_DIR /tmp/mesos
ENV MESOS_CONTAINERIZERS docker,mesos

# https://mesosphere.github.io/marathon/docs/native-docker.html
ENV MESOS_EXECUTOR_REGISTRATION_TIMEOUT 10mins

VOLUME /tmp/mesos


CMD ["/sbin/my_init"]

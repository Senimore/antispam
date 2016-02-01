FROM senimore/trusty_java8


RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install mesos

CMD ["/usr/sbin/mesos-master"]

ENV MESOS_WORK_DIR /tmp/mesos

VOLUME /tmp/mesos

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

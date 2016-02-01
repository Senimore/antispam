FROM senimore/trusty_java8


RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install chronos mesos && \
apt-get -y autoclean && apt-get -y autoremove

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

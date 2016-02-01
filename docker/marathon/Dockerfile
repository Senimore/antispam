FROM senimore/trusty_java8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install marathon mesos

CMD ["marathon", "--no-logger"]

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

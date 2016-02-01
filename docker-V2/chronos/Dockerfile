FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install chronos mesos 

RUN mkdir /etc/service/chronos
ADD /assets/entrypoint.sh /etc/service/chronos/run

RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.

EXPOSE 4400


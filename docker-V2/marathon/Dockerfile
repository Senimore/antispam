FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get -y install marathon mesos


RUN mkdir /etc/service/marathon
ADD assets/startmarathon.sh /etc/service/marathon/run

RUN apt-get clean && apt-get -y autoremove &&\
    rm -rf /var/lib/apt/lists/*.

EXPOSE 8080

CMD ["/sbin/my_init"]

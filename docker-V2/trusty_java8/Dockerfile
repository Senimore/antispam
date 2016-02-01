FROM senimore/baseimage
MAINTAINER senimore@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen ru_RU ru_RU.UTF-8 && dpkg-reconfigure locales &&\
    apt-get update && apt-get -y upgrade && apt-get -y install software-properties-common && add-apt-repository ppa:webupd8team/java -y && apt-get update &&\
    (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && apt-get install -y oracle-java8-installer oracle-java8-set-default curl&&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  &&\
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $JAVA_HOME/bin:$PATH


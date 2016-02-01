FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN sudo rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - &&\
    echo "deb http://packages.elastic.co/logstash/2.1/debian stable main" > /etc/apt/sources.list.d/elastic.list &&\
    apt-get update &&\
    sudo apt-get -y install logstash python-pip

RUN pip install elasticsearch-curator

# Configure environment
COPY src/ /

RUN mkdir /etc/service/logstash
ADD assets/logstash.sh /etc/service/logstash/run

EXPOSE 5044 

VOLUME /var/log:/var/log

CMD ["/sbin/my_init"]

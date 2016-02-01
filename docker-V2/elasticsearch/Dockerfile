FROM senimore/trusty_java8
MAINTAINER senimore@gmail.com

RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

RUN apt-get update && sudo apt-get -y install elasticsearch python-pip

RUN pip install elasticsearch-curator

RUN mkdir /etc/service/elasticsearch
ADD assets/elastic.sh /etc/service/elasticsearch/run

RUN mkdir -p /etc/my_init.d
ADD /assets/elasticboot.sh /etc/my_init.d/elasticboot.sh

ENV MARVEL_SUPPORT=false

EXPOSE 9200
EXPOSE 9300

VOLUME /var/log/elasticsearch
VOLUME /var/lib/elasticsearch

CMD ["/sbin/my_init"]


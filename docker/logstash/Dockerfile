# Docker file to create Logstash container.
FROM senimore/trusty_java8

RUN sudo rm -rf /var/lib/apt/lists/*
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - &&\
    echo "deb http://packages.elastic.co/logstash/2.1/debian stable main" > /etc/apt/sources.list.d/elastic.list &&\
    apt-get update &&\
    sudo apt-get install logstash
    

RUN apt-get -y install python-pip &&\ 
    pip install elasticsearch-curator

# Configure environment
COPY src/ /


EXPOSE 5044 

VOLUME /var/log:/var/log

ENTRYPOINT ["/usr/local/bin/logstash.sh"]
CMD [""]

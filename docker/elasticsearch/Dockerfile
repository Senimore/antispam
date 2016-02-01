FROM senimore/trusty_java8


# elasticsearch

ENV ES_VERSION=2.1.1

RUN \
    mkdir -p /opt/elasticsearch && \
    cd /opt/elasticsearch && \
    curl -O https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-$ES_VERSION.tar.gz && \
    tar zxvf elasticsearch-${ES_VERSION}.tar.gz -C /opt/elasticsearch --strip-components=1 && \
    rm -f elasticsearch-${ES_VERSION}.tar.gz && \
    useradd elasticsearch && \
    chown -R elasticsearch:elasticsearch /opt/elasticsearch && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update && \
    apt-get install -y python-pip && \
    apt-get autoclean &&\
    apt-get autoremove &&\
    pip install elasticsearch-curator

COPY assets /

ENV MARVEL_SUPPORT=false

EXPOSE 9200
EXPOSE 9300


VOLUME /opt/elasticsearch/data
VOLUME /opt/elasticsearch/logs


ENTRYPOINT ["/boot.sh"]


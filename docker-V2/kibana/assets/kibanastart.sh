#!/bin/sh

ES_HOST=${ES_HOST:-localhost}
ES_PORT=${ES_PORT:-9200}

echo "elasticsearch.url: "http://${ES_HOST}:${ES_PORT}"" >> /opt/kibana/config/kibana.yml

exec /opt/kibana/bin/kibana

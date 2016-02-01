#!/bin/sh

ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-localhost}
ELASTICSEARCH_PORT=${ELASTICSEARCH_PORT:-9200}

if [ $ELASTICSEARCH_HOST = gateway ]; then
    ELASTICSEARCH_HOST=`ip route | grep ^default | awk '{print $3}'`
fi

sed -i "s/^elasticsearch_url: .*/elasticsearch_url: \"http:\/\/$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT\"/" /opt/kibana/config/kibana.yml

exec "$@"

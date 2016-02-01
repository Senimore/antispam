
docker run -d \
-e ES_HOST=elasticseachhost \
-e ES_PORT=9200 \
-p 5601:5601 \
--name=kibana --restart=always mesoscloud/kibana:4.1.2-ubuntu-14.04
```

# kibana

[![Join the chat at https://gitter.im/mesoscloud/kibana](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mesoscloud/kibana?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Kibana

https://www.elastic.co/products/kibana

## CentOS

[![](https://badge.imagelayers.io/mesoscloud/kibana:4.1.2-centos-7.svg)](https://imagelayers.io/?images=mesoscloud/kibana:4.1.2-centos-7)

e.g.

```
docker run -d \
--name=kibana --net=host --restart=always mesoscloud/kibana:4.1.2-centos-7
```

```
docker run -d \
-e ELASTICSEARCH_HOST=gateway \
-p 5601:5601 \
--name=kibana --restart=always mesoscloud/kibana:4.1.2-centos-7
```

## Ubuntu

[![](https://badge.imagelayers.io/mesoscloud/kibana:4.1.2-ubuntu-14.04.svg)](https://imagelayers.io/?images=mesoscloud/kibana:4.1.2-ubuntu-14.04)

e.g.

```
docker run -d \
--name=kibana --net=host --restart=always mesoscloud/kibana:4.1.2-ubuntu-14.04
```

```
docker run -d \
-e ELASTICSEARCH_HOST=gateway \
-p 5601:5601 \
--name=kibana --restart=always mesoscloud/kibana:4.1.2-ubuntu-14.04
```

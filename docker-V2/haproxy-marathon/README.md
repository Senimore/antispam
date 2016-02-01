# haproxy-marathon

[![Join the chat at https://gitter.im/mesoscloud/haproxy-marathon](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mesoscloud/haproxy-marathon?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

The purpose of this image is to generate HAProxy config using Marathon as a data source and storing the resulting config in ZooKeeper.  This allows a dedicated container to run haproxy, monitor ZooKeeper for config changes and reload haproxy when config has been updated.

See https://github.com/mesoscloud/haproxy

## Python

[![](https://badge.imagelayers.io/mesoscloud/haproxy-marathon:0.2.1.svg)](https://imagelayers.io/?images=mesoscloud/haproxy-marathon:0.2.1)

e.g.

```
docker run -d \
-e MARATHON=node-1:8080 \
-e ZK=node-1:2181 \
--name=haproxy --net=host --restart=always mesoscloud/haproxy-marathon:0.2.1
```

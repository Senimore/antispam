
docker run -d \
-e MARATHON_HOSTNAME=ip.address \
-e MARATHON_HTTPS_ADDRESS=ip.address \
-e MARATHON_HTTP_ADDRESS=ip.address \
-e MARATHON_MASTER=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
-e MARATHON_ZK=zk://node-1:2181,node-2:2181,node-3:2181/marathon \
--name marathon --net host --restart always mesoscloud/marathon:0.11.0-ubuntu-15.04
```

Set environment variable `SECRET` to enable framework authentication.

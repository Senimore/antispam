docker run -d \
-e MESOS_HOSTNAME=ip.address \
-e MESOS_IP=ip.address \
-e MESOS_QUORUM=2 \
-e MESOS_ZK=zk://node-1:2181,node-2:2181,node-3:2181/mesos \
--name mesos-master --net host --restart always mesoscloud/mesos-master:0.24.1-ubuntu-14.04
```

Set environment variable `SECRET` to enable framework and slave authentication.

FROM senimore/trusty_java8


WORKDIR /var/app

ADD assets/zkui-*.jar /var/app/zkui.jar
ADD assets/config.cfg /var/app/config.cfg

RUN mkdir /etc/service/zkui
ADD assets/zkuistart.sh /etc/service/zkui/run


CMD ["/sbin/my_init"]

#ENTRYPOINT [ "java", "-jar", "/var/app/zkui.jar" ]

EXPOSE 9090

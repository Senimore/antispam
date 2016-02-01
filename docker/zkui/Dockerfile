FROM senimore/trusty_java8


WORKDIR /var/app

ADD assets/zkui-*.jar /var/app/zkui.jar
ADD assets/config.cfg /var/app/config.cfg

ENTRYPOINT [ "java", "-jar", "/var/app/zkui.jar" ]

EXPOSE 9090

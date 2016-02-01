FROM senimore/trusty_java8

RUN curl -fL https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz | tar xzf - -C /opt && \
mv /opt/kibana-4.3.1-linux-x64 /opt/kibana

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/kibana/bin

CMD ["kibana"]

EXPOSE 5601

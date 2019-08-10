FROM debian:jessie

ENV cpu_arch=amd64

RUN apt-get update -y && \
    apt-get install -y sysbench && \
    apt-get clean

CMD ["/usr/bin/sysbench"]

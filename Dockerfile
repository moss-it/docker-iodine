FROM debian:8
MAINTAINER Thiago Almeida <thiagoalmeidasa@gmail.com>


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get install -y \
        net-tools bridge-utils iodine iptables openssh-server && \

# Clean up
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
        apt-get autoremove -y && \
        apt-get clean


RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/authorized_keys2

RUN mkdir -p /opt/iodine
ADD start.sh /opt/iodine/start.sh

WORKDIR /opt/iodine

EXPOSE 53/udp

CMD ["sh", "/opt/iodine/start.sh"]

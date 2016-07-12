FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    apt-get install openvpn -y

COPY client.ovpn ./
COPY pass ./
COPY turner_dev_sandbox ./

EXPOSE 1194

RUN mkdir /script

VOLUME /script

CMD ["/script/run.sh"]

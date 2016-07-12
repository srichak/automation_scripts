FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    apt-get install openvpn -y

WORKDIR /keyz

COPY client.ovpn ./
COPY pass ./
COPY turner_dev_sandbox ./

EXPOSE 1194

VOLUME /script

ENTRYPOINT ["/script/run.sh"]

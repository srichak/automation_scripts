FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    apt-get install openvpn -y

WORKDIR /keyz

COPY client.ovpn ./
COPY pass ./
COPY start_deploy.sh ./
COPY fabfile.py ./
COPY requirements.txt ./
COPY turner_dev_sandbox ./

RUN chmod +x start_deploy.sh

RUN pip install -r requirements.txt

EXPOSE 1194

# CMD openvpn --config client.ovpn # --script-security 2 --up /keyz/start_deploy.sh

ENTRYPOINT ["./start_deploy.sh"]

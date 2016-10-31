FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    apt-get install openvpn openconnect -y

WORKDIR /keyz

COPY pass ./
COPY start_deploy.sh ./
COPY fabfile.py ./
COPY requirements.txt ./
COPY kpn_ssh_key ./

COPY dist.tar.gz ./

RUN chmod +x start_deploy.sh

RUN pip install -r requirements.txt

EXPOSE 1194

ENTRYPOINT ["./start_deploy.sh"]

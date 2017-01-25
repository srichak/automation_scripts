FROM debian:jessie

RUN apt-get update && apt-get install -y wget

RUN wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
RUN echo "deb http://build.openvpn.net/debian/openvpn/release/2.3 jessie main" > /etc/apt/sources.list.d/openvpn-aptrepo.list

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    apt-get install openvpn openconnect -y

WORKDIR /keyz

#COPY client.ovpn ./
COPY start_deploy.sh ./
#COPY pass ./
COPY fabfile.py ./
COPY requirements.txt ./
COPY sdk44_ssh_key ./

COPY app.tar.gz ./

RUN chmod +x start_deploy.sh

RUN pip install -r requirements.txt

EXPOSE 1194

# CMD openvpn --config client.ovpn # --script-security 2 --up /keyz/start_deploy.sh

ENTRYPOINT ["./start_deploy.sh"]

FROM ubuntu:latest

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip openssh-client ansible && \
    pip install --upgrade pip awscli

WORKDIR /tmp

COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY start_deploy.sh ./
COPY stopInstances.sh ./
COPY startInstances.sh ./
COPY startDatabases.sh ./
COPY test.sh ./
COPY dbservicedown.sh ./
COPY dbserviceup.sh ./
COPY devopssshkey.pem ./
COPY ansible.cfg /etc/ansible/ansible.cfg

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""
ENV AWS_DEFAULT_OUTPUT=""

RUN chmod +x start_deploy.sh
RUN chmod +x stopInstances.sh
RUN chmod +x startInstances.sh
RUN chmod +x startDatabases.sh
RUN chmod +x dbservicedown.sh ./
RUN chmod +x dbserviceup.sh ./
RUN chmod 600 devopssshkey.pem
RUN chmod 644 /etc/ansible/ansible.cfg

ENTRYPOINT ["./start_deploy.sh"]
#ENTRYPOINT ["./stopInstances.sh"]
#ENTRYPOINT ["./test.sh"]

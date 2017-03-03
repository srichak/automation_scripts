FROM ubuntu:latest

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    pip install awscli 

WORKDIR /tmp

COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY start_deploy.sh ./
COPY stopInstances.sh ./
COPY startInstances.sh ./
COPY test.sh ./
COPY dbservicedown.sh ./
COPY dbserviceup.sh ./
COPY devops6sshkey.pem ./
COPY devops4sshkey.pem ./

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""
ENV AWS_DEFAULT_OUTPUT=""

RUN chmod +x start_deploy.sh
RUN chmod +x stopInstances.sh
RUN chmod +x startInstances.sh
RUN chmod 600 devops6sshkey.pem
RUN chmod 600 devops4sshkey.pem

ENTRYPOINT ["./start_deploy.sh"]
#ENTRYPOINT ["./stopInstances.sh"]
#ENTRYPOINT ["./test.sh"]

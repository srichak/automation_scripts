FROM ubuntu:latest

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
    pip install awscli 

WORKDIR /tmp

COPY start_deploy.sh ./
COPY stopInstances.sh ./
COPY requirements.txt ./
COPY test.sh ./

#ENV TERM=xterm
RUN chmod +x start_deploy.sh

RUN pip install -r requirements.txt

#ENTRYPOINT ["./start_deploy.sh"]
#ENTRYPOINT ["./stopInstances.sh"]
ENTRYPOINT ["./test.sh"]
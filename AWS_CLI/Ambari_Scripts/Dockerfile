FROM ubuntu:latest

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip openssh-client ansible curl && \
    pip install --upgrade pip awscli

WORKDIR /tmp

COPY startAmbariInstances.sh ./
COPY ambari_wrapper.sh ./

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""
ENV AWS_DEFAULT_OUTPUT=""

RUN chmod +x startAmbariInstances.sh && chmod +x ambari_wrapper.sh

ENTRYPOINT ["./ambari_wrapper.sh"]
#ENTRYPOINT ["./stopInstances.sh"]
#ENTRYPOINT ["./test.sh"]

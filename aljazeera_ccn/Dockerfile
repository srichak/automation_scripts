FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip   

WORKDIR /tmp

COPY start_deploy.sh ./
COPY fabfile.py ./
COPY aljazeera_dev_key ./
COPY requirements.txt ./

COPY app.tar.gz ./

RUN chmod +x start_deploy.sh

RUN pip install -r requirements.txt

ENTRYPOINT ["./start_deploy.sh"]

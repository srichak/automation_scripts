FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
	pip install sonarqube-api
	
COPY sonar_get_data.sh /
CMD chmod +x sonar_get_data.sh
ENTRYPOINT /sonar_get_data.sh

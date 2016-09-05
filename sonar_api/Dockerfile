FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
	pip install sonarqube-api
	
COPY sonar_get_data.py /

CMD chmod +x sonar_get_data.py
CMD python sonar_get_data.py
#ENTRYPOINT /sonar_get_data.py

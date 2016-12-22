FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y --fix-missing python python-dev python-pip && \
	  pip install sonarqube-api && \
    apt-get install -y vim


COPY sonar_get_data.py /
COPY report_new.html /

CMD chmod +x sonar_get_data.py
RUN sed -i "77s/.*/        return '{}{}{}'.format(self._host, self._base_path, endpoint)/" /usr/local/lib/python2.7/dist-packages/sonarqube_api/api.py
CMD python sonar_get_data.py
#CMD /bin/sh -c "while true; do echo hello world; sleep 1; done"

#ENTRYPOINT /sonar_get_data.py

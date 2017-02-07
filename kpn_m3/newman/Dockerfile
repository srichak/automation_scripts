FROM debian:jessie

RUN apt-get clean && apt-get update
RUN apt-get install -y curl 
RUN	curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN	npm install newman --global

RUN newman run -h
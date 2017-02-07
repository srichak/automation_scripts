FROM debian:jessie

RUN apt-get clean && apt-get upgrade && apt-get update && \
	apt-get install curl \
	curl -s https://deb.nodesource.com/setup_6.x | -E bash – \
    apt-get install -y nodejs \
	npm install newman --global

RUN newman run -h
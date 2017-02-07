FROM debian:jessie

RUN apt-get clean && apt-get update && \
	apt-get install curl \
	curl https://deb.nodesource.com/setup_6.x | -E bash – \
    apt-get install -y nodejs \
	npm install newman --global

RUN newman run -h
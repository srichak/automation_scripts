FROM debian:jessie

RUN apt-get clean && apt-get update && \
    apt-get install -y curl && \
	curl -sL https://deb.nodesource.com/setup_6.x | bash – && \
    apt-get install -y nodejs && \
	npm install newman --global

RUN newman run -h
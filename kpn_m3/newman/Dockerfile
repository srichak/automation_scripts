FROM debian:jessie

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash – \
    sudo apt-get install -y nodejs \
	npm install newman --global

RUN newman run -h
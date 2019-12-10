FROM ubuntu

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install curl -y gcc -y autoconf -y make -y automake -y libpng-dev -y nasm -y git -y

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install nodejs -y
RUN node -v && npm -v

WORKDIR headless-cms
RUN npm install
RUN npm run build

RUN npm install pm2 -g
WORKDIR /root
RUN pm2 init
RUN mv /headless-cms/ecosystem.config.js /root
#RUN pm2 start ecosystem.config.js

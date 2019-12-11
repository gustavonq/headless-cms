#FROM ubuntu
FROM node:9.11.2-slim
RUN apt-get gcc -y autoconf -y make -y automake -y libpng-dev -y nasm -y

WORKDIR headless-cms
COPY ./ /headless-cms/

RUN node -v && npm -v
RUN npm install
RUN npm run build

#RUN apt-get update -y && apt-get upgrade -y
#RUN apt-get install curl -y gcc -y autoconf -y make -y automake -y libpng-dev -y nasm -y git -y

#RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
#RUN apt-get install nodejs -y
#RUN node -v && npm -v

#WORKDIR headless-cms
#RUN npm install
#RUN npm run build

RUN npm install pm2 -g
RUN pm2 init
RUN pm2 start ecosystem.config.js
#RUN mv /headless-cms/ecosystem.config.js /root
#RUN pm2 start ecosystem.config.js

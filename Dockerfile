FROM node:latest
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install gcc -y autoconf -y make -y automake -y libpng-dev -y nasm -y

#copiando arquivos, clonados do git, do host para o container 
WORKDIR headless-cms
COPY ./ /headless-cms/

#baixando dependências e buildando o app Admin
RUN node -v && npm -v
RUN npm install
RUN npm run build

#instalando e iniciando PM2 para gestão dos processos node
RUN npm install pm2 -g
WORKDIR /root
RUN pm2 init
RUN mv /headless-cms/ecosystem.config.js /root

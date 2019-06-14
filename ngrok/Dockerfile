FROM ubuntu:latest

ARG NGROK_AUTHTOKEN

RUN apt-get update && apt-get install unzip

WORKDIR /root

ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip ./ngrok.zip

RUN unzip ./ngrok.zip

RUN chmod +x ./ngrok

RUN ./ngrok authtoken ${NGROK_AUTHTOKEN}

CMD ./ngrok http 80

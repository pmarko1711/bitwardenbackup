FROM node:13-alpine3.11
WORKDIR /app
LABEL Name=bitwardenbackup Version=0.0.1
RUN apk add bash && apk add gnupg && npm install -g @bitwarden/cli
COPY launch_script.sh .
VOLUME /output
CMD ["bash", "launch_script.sh"]

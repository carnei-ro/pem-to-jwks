FROM node:alpine
RUN npm install -g pem-jwk ; apk add --no-cache jq

COPY ./convert.sh /convert.sh

ENTRYPOINT [ "/convert.sh" ]

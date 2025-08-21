FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache curl bash

# Install tileserver-gl
RUN npm install -g tileserver-gl

WORKDIR /data

COPY config.json /data/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
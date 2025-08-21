FROM maptiler/tileserver-gl

USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /data

COPY config.json /data/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tileserver-gl", "--config", "/data/config.json", "--bind", "0.0.0.0"]
FROM maptiler/tileserver-gl

# Copy config.json ke container
WORKDIR /data
COPY config.json /data/config.json

# Expose port (Railway otomatis handle)
EXPOSE 8080

CMD ["--config", "/data/config.json", "--bind", "0.0.0.0"]

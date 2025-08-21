FROM maptiler/tileserver-gl

# Install curl
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set working dir
WORKDIR /data

# Copy config.json ke container
COPY config.json /data/config.json

# Download MBTiles dari Google Cloud Storage
RUN curl -L -o indonesia1.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia1.mbtiles && \
    curl -L -o indonesia2.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia2.mbtiles && \
    curl -L -o indonesia3.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia3.mbtiles

# Expose port (Railway otomatis handle)
EXPOSE 8080

# Jalankan tileserver-gl
CMD ["--config", "/data/config.json", "--bind", "0.0.0.0"]

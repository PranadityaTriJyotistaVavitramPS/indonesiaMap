#!/bin/sh
set -e

# Download tiles if not already downloaded
if [ ! -f /data/indonesia1.mbtiles ]; then
  echo "Downloading indonesia1.mbtiles..."
  curl -L -o /data/indonesia1.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia1.mbtiles
fi

if [ ! -f /data/indonesia2.mbtiles ]; then
  echo "Downloading indonesia2.mbtiles..."
  curl -L -o /data/indonesia2.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia2.mbtiles
fi

if [ ! -f /data/indonesia3.mbtiles ]; then
  echo "Downloading indonesia3.mbtiles..."
  curl -L -o /data/indonesia3.mbtiles https://storage.googleapis.com/my-tiles-bucket/indonesia3.mbtiles
fi

echo "Contents of /data folder:"
ls -lh /data

# Just pass through to CMD
exec "$@"
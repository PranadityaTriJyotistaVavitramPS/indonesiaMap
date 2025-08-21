#!/bin/sh
set -e

# Download tiles first
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

# Find tileserver-gl
echo "Searching for tileserver-gl..."
find / -name "tileserver-gl" -type f 2>/dev/null || echo "tileserver-gl not found"

# Try common locations
if [ -f "/usr/local/bin/tileserver-gl" ]; then
    exec /usr/local/bin/tileserver-gl --config /data/config.json --bind 0.0.0.0
elif [ -f "/usr/bin/tileserver-gl" ]; then
    exec /usr/bin/tileserver-gl --config /data/config.json --bind 0.0.0.0
elif [ -f "/usr/src/app/node_modules/.bin/tileserver-gl" ]; then
    exec /usr/src/app/node_modules/.bin/tileserver-gl --config /data/config.json --bind 0.0.0.0
else
    echo "Error: tileserver-gl not found in any known location"
    exit 1
fi
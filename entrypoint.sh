#!/bin/bash
set -e

# Download tiles if not already downloaded
download_tile() {
    local filename=$1
    local url=$2
    
    if [ ! -f "/data/${filename}" ]; then
        echo "Downloading ${filename}..."
        curl -L -o "/data/${filename}" "${url}"
        
        # Verify download was successful
        if [ ! -f "/data/${filename}" ]; then
            echo "ERROR: Failed to download ${filename}"
            exit 1
        fi
    else
        echo "${filename} already exists"
    fi
    
    # Set proper permissions
    chmod 644 "/data/${filename}"
    echo "Verified ${filename} (size: $(du -h "/data/${filename}" | cut -f1))"
}

# Download all tiles
download_tile "indonesia1.mbtiles" "https://storage.googleapis.com/my-tiles-bucket/indonesia1.mbtiles"
download_tile "indonesia2.mbtiles" "https://storage.googleapis.com/my-tiles-bucket/indonesia2.mbtiles"
download_tile "indonesia3.mbtiles" "https://storage.googleapis.com/my-tiles-bucket/indonesia3.mbtiles"

echo "=== FINAL VERIFICATION ==="
echo "Contents of /data folder:"
ls -la /data

echo "File permissions:"
ls -la /data/*.mbtiles

echo "File sizes:"
du -h /data/*.mbtiles

# Test if Node.js can access the files
echo "=== TESTING NODE FILE ACCESS ==="
node -e "
const fs = require('fs');
const files = ['indonesia1.mbtiles', 'indonesia2.mbtiles', 'indonesia3.mbtiles'];
files.forEach(file => {
    const path = '/data/' + file;
    try {
        const stats = fs.statSync(path);
        console.log('✓ Node can access:', path, '- Size:', stats.size, 'bytes');
    } catch (error) {
        console.error('✗ Node cannot access:', path, '- Error:', error.message);
    }
});
"

echo "=== CHECKING TILESERVER CONFIG ==="
cat /data/config.json

echo "=== STARTING TILESERVER ==="
exec "$@"
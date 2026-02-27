#!/bin/bash
set -e

echo "📥 Mattermost downloading..."
MATTERMOST_VERSION="9.11.3"

# Download Mattermost
wget -q https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz

echo "📦 Extraction..."
tar -xzf mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz

# Create necessary directories for Mattermost
mkdir -p ./mattermost/data
mkdir -p ./mattermost/logs

echo "📝 Configuration de Mattermost..."
# Save the default config file for later use
cp ./mattermost/config/config.json ./mattermost/config/config.defaults.json

echo "✅ Mattermost setup completed."
chmod +x ./mattermost/bin/mattermost

# Clean up the downloaded archive
rm -f mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz


#!/bin/bash
set -euo pipefail

command -v ngrok &>/dev/null && echo "[ngrok] already installed" && exit 0

echo "[ngrok] installing..."
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null

echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list >/dev/null

sudo apt-get update -qq
sudo apt-get install -y ngrok
echo "[ngrok] done"

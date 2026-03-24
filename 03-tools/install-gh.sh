#!/bin/bash
set -euo pipefail

command -v gh &>/dev/null && echo "[gh] already installed ($(gh --version | head -1))" && exit 0

echo "[gh] installing..."
(type -p wget >/dev/null || (sudo apt-get update -qq && sudo apt-get install -y wget))

sudo mkdir -p -m 755 /etc/apt/keyrings
TMP_KEY="$(mktemp)"
wget -nv -O "$TMP_KEY" https://cli.github.com/packages/githubcli-archive-keyring.gpg
sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg < "$TMP_KEY" >/dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
rm -f "$TMP_KEY"

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt-get update -qq
sudo apt-get install -y gh
echo "[gh] done"

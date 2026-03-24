#!/bin/bash
set -euo pipefail

command -v aws &>/dev/null && echo "[aws-cli] already installed ($(aws --version 2>/dev/null | cut -d' ' -f1))" && exit 0

echo "[aws-cli] installing v2..."
TMP_DIR="$(mktemp -d)"
curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "$TMP_DIR/awscliv2.zip"
unzip -q "$TMP_DIR/awscliv2.zip" -d "$TMP_DIR"
sudo "$TMP_DIR/aws/install"
rm -rf "$TMP_DIR"
echo "[aws-cli] done"

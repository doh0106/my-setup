#!/bin/bash
set -euo pipefail

command -v gemini &>/dev/null && echo "[gemini] already installed" && exit 0

export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

command -v npm &>/dev/null || { echo "[gemini] npm not found — run 02-runtime/install-nvm.sh first"; exit 1; }

echo "[gemini] installing..."
npm install -g @google/gemini-cli
echo "[gemini] done"

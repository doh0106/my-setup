#!/bin/bash
set -euo pipefail

command -v claude &>/dev/null && echo "[claude-code] already installed ($(claude --version 2>/dev/null))" && exit 0

export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

command -v npm &>/dev/null || { echo "[claude-code] npm not found — run 02-runtime/install-nvm.sh first"; exit 1; }

echo "[claude-code] installing..."
npm install -g @anthropic-ai/claude-code
echo "[claude-code] done"

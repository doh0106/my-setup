#!/bin/bash
set -euo pipefail

NVM_VERSION="v0.40.1"
NODE_VERSION="22"

[ -s "$HOME/.nvm/nvm.sh" ] && echo "[nvm] already installed" && exit 0

echo "[nvm] installing ${NVM_VERSION} + Node.js ${NODE_VERSION}..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash

export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install "$NODE_VERSION"
echo "[nvm] done (node $(node -v))"

#!/bin/bash
set -euo pipefail

command -v acli &>/dev/null && echo "[acli] already installed" && exit 0

echo "[acli] installing..."
curl -sSLO "https://acli.atlassian.com/linux/latest/acli_linux_amd64/acli"
chmod +x ./acli
sudo mv ./acli /usr/local/bin/acli
echo "[acli] done"

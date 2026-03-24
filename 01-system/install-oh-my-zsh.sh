#!/bin/bash
set -euo pipefail

[ -d "$HOME/.oh-my-zsh" ] && echo "[oh-my-zsh] already installed" && exit 0

echo "[oh-my-zsh] installing..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "[oh-my-zsh] done"

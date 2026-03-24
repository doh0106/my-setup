#!/bin/bash
set -euo pipefail

PACKAGES=(
  # editor
  vim
  # build tools
  build-essential make gcc
  # file search & view
  bat fd-find
  # network
  iproute2 traceroute dnsutils iputils-ping nmap
  # shell & navigation
  autojump
  # utilities
  xclip lsof unzip manpages-dev
  # monitoring
  iotop
)

MISSING=()
for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" &>/dev/null || MISSING+=("$pkg")
done

[ ${#MISSING[@]} -eq 0 ] && echo "[apt-extras] all packages already installed" && exit 0

echo "[apt-extras] installing ${#MISSING[@]} packages: ${MISSING[*]}"
sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends "${MISSING[@]}"
sudo rm -rf /var/lib/apt/lists/*
echo "[apt-extras] done"

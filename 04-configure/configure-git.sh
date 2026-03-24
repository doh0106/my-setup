#!/bin/bash
set -euo pipefail

echo "[git] configuring..."

# aliases
git config --global alias.st status
git config --global alias.co checkout

# pager
git config --global core.pager cat

# git-lfs
git config --global filter.lfs.required true
git config --global filter.lfs.clean "git-lfs clean -- %f"
git config --global filter.lfs.smudge "git-lfs smudge -- %f"
git config --global filter.lfs.process "git-lfs filter-process"

# user info (skip if already set)
if [ -z "$(git config --global user.name 2>/dev/null)" ]; then
  echo "[git] user.name not set — configure manually: git config --global user.name \"Your Name\""
fi
if [ -z "$(git config --global user.email 2>/dev/null)" ]; then
  echo "[git] user.email not set — configure manually: git config --global user.email \"you@example.com\""
fi

echo "[git] done"

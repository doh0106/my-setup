#!/bin/bash
set -euo pipefail

REQUIRED_MOUNTS=(
  "$HOME/.claude:Claude Code 설정/스킬"
  "$HOME/.sops:SOPS age 키"
  "$HOME/.config/gh:GitHub CLI 인증"
  "$HOME/.aws:AWS CLI 인증"
)

echo "[mounts] checking host mounts..."
ALL_OK=1

for entry in "${REQUIRED_MOUNTS[@]}"; do
  dir="${entry%%:*}"
  desc="${entry##*:}"
  if [ -d "$dir" ]; then
    echo "  ok  $dir ($desc)"
  else
    echo "  MISSING  $dir ($desc)"
    ALL_OK=0
  fi
done

[ "$ALL_OK" -eq 1 ] && echo "[mounts] all mounted" && exit 0
echo "[mounts] some mounts missing — check devcontainer.json mounts config"
exit 1

#!/bin/bash
set -euo pipefail

ZSHRC="$HOME/.zshrc"

[ -f "$ZSHRC" ] || { echo "[zshrc] ~/.zshrc not found — run install-oh-my-zsh.sh first"; exit 1; }

append_if_missing() {
  local marker="$1"
  local content="$2"
  if grep -qF "$marker" "$ZSHRC" 2>/dev/null; then
    return 1
  fi
  echo "$content" >> "$ZSHRC"
  return 0
}

CHANGED=0

# uv environment
if append_if_missing '.local/bin/env' '
# uv
source $HOME/.local/bin/env'; then
  CHANGED=1
fi

# pip alias
if append_if_missing "alias pip=" '
alias pip="uv pip"'; then
  CHANGED=1
fi

# nvm
if append_if_missing 'NVM_DIR' '
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'; then
  CHANGED=1
fi

# jira helper alias
if [ -f "$HOME/.claude/jira-helper.sh" ]; then
  if append_if_missing "alias jira=" '
alias jira="~/.claude/jira-helper.sh"'; then
    CHANGED=1
  fi
fi

[ "$CHANGED" -eq 0 ] && echo "[zshrc] already configured" && exit 0
echo "[zshrc] done"

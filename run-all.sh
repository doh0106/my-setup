#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

OPTIONAL_SCRIPTS=(
  "install-ngrok.sh"
  "install-gemini.sh"
)

usage() {
  echo "Usage: $0 [--all] [--skip SCRIPT_NAME]..."
  echo ""
  echo "Options:"
  echo "  --all              Include optional scripts (ngrok, gemini)"
  echo "  --skip NAME        Skip a specific script (e.g. --skip install-acli.sh)"
  echo "  --only PHASE       Run only a specific phase (e.g. --only 03-tools)"
  echo ""
  echo "Phases: 01-system → 02-runtime → 03-tools → 04-configure → 05-verify"
}

INCLUDE_OPTIONAL=false
SKIP_LIST=()
ONLY_PHASE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)      INCLUDE_OPTIONAL=true; shift ;;
    --skip)     SKIP_LIST+=("$2"); shift 2 ;;
    --only)     ONLY_PHASE="$2"; shift 2 ;;
    --help|-h)  usage; exit 0 ;;
    *)          echo "Unknown option: $1"; usage; exit 1 ;;
  esac
done

is_skipped() {
  local script_name
  script_name="$(basename "$1")"

  for skip in "${SKIP_LIST[@]+"${SKIP_LIST[@]}"}"; do
    [ "$skip" = "$script_name" ] && return 0
  done

  if [ "$INCLUDE_OPTIONAL" = false ]; then
    for opt in "${OPTIONAL_SCRIPTS[@]}"; do
      [ "$opt" = "$script_name" ] && return 0
    done
  fi

  return 1
}

FAILED=()

for phase_dir in "$SCRIPT_DIR"/[0-9]*; do
  [ -d "$phase_dir" ] || continue

  phase_name="$(basename "$phase_dir")"

  if [ -n "$ONLY_PHASE" ] && [ "$phase_name" != "$ONLY_PHASE" ]; then
    continue
  fi

  echo ""
  echo "========== ${phase_name} =========="

  for script in "$phase_dir"/*.sh; do
    [ -f "$script" ] || continue

    if is_skipped "$script"; then
      echo "[skip] $(basename "$script")"
      continue
    fi

    echo ""
    if ! bash "$script"; then
      FAILED+=("$script")
      echo "[FAIL] $script"
    fi
  done
done

echo ""
echo "========== summary =========="
if [ ${#FAILED[@]} -eq 0 ]; then
  echo "all scripts completed successfully"
else
  echo "${#FAILED[@]} script(s) failed:"
  for f in "${FAILED[@]}"; do
    echo "  - $f"
  done
  exit 1
fi

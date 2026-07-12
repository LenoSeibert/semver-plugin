#!/usr/bin/env bash

set -u

PLUGIN_NAME="semver-plugin"
MARKETPLACE_NAME="semver-plugin-local"
CACHE_ROOT="${XDG_CACHE_HOME:-${HOME}/.cache}/${PLUGIN_NAME}-local"
TARGET="${1:-all}"

usage() {
  cat <<'EOF'
Remove the local source installation from coding-agent harnesses.

Usage:
  scripts/uninstall-local.sh [all|codex|claude|gemini|copilot]
EOF
}

case "$TARGET" in
  all|codex|claude|gemini|copilot) ;;
  -h|--help) usage; exit 0 ;;
  *) printf 'Unknown harness: %s\n' "$TARGET" >&2; usage >&2; exit 2 ;;
esac

run_if_available() {
  local executable="$1"
  shift

  if ! command -v "$executable" >/dev/null 2>&1; then
    printf 'Skipping %s: command not found.\n' "$executable"
    return
  fi

  printf '+ '
  printf '%q ' "$executable" "$@"
  printf '\n'
  "$executable" "$@" || printf 'Warning: command did not remove an existing entry.\n' >&2
}

remove_codex() {
  run_if_available codex plugin remove "$PLUGIN_NAME@$MARKETPLACE_NAME"
  run_if_available codex plugin marketplace remove "$MARKETPLACE_NAME"
}

remove_claude() {
  run_if_available claude plugin uninstall "$PLUGIN_NAME@$MARKETPLACE_NAME" --scope local
  run_if_available claude plugin marketplace remove "$MARKETPLACE_NAME" --scope local
}

remove_gemini() {
  run_if_available gemini extensions uninstall "$PLUGIN_NAME"
}

remove_copilot() {
  run_if_available copilot plugin uninstall "$PLUGIN_NAME@$MARKETPLACE_NAME"
  run_if_available copilot plugin marketplace remove "$MARKETPLACE_NAME"
}

case "$TARGET" in
  codex) remove_codex ;;
  claude) remove_claude ;;
  gemini) remove_gemini ;;
  copilot) remove_copilot ;;
  all)
    remove_codex
    remove_claude
    remove_gemini
    remove_copilot
    ;;
esac

rm -rf "$CACHE_ROOT"

printf '\nLocal %s installation removed.\n' "$TARGET"

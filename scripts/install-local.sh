#!/usr/bin/env bash

set -euo pipefail

PLUGIN_NAME="semver-plugin"
MARKETPLACE_NAME="semver-plugin-local"
ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CACHE_ROOT="${XDG_CACHE_HOME:-${HOME}/.cache}/${PLUGIN_NAME}-local"
TARGET="${1:-all}"
DRY_RUN=false

usage() {
  cat <<'EOF'
Install or update the current source tree in local coding-agent harnesses.

Usage:
  scripts/install-local.sh [all|codex|claude|gemini|copilot] [--dry-run]

The script includes tracked, modified, and untracked source files. Codex,
Claude Code, and Copilot receive an isolated local marketplace named
semver-plugin-local. Gemini CLI links directly to this repository.
EOF
}

for argument in "$@"; do
  case "$argument" in
    all|codex|claude|gemini|copilot) TARGET="$argument" ;;
    --dry-run) DRY_RUN=true ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown argument: %s\n' "$argument" >&2; usage >&2; exit 2 ;;
  esac
done

run() {
  printf '+ '
  printf '%q ' "$@"
  printf '\n'
  if [[ "$DRY_RUN" == false ]]; then
    "$@"
  fi
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Required command not found: %s\n' "$1" >&2
    exit 1
  fi
}

prepare_snapshot() {
  local destination="$CACHE_ROOT/$1"
  local cachebuster

  require_command node
  require_command tar
  cachebuster="local-$(date -u +%Y%m%d-%H%M%S)"

  rm -rf "$destination"
  mkdir -p "$destination"
  (
    cd "$ROOT_DIR"
    tar \
      --exclude=.git \
      --exclude='*.zip' \
      -cf - .
  ) | tar -xf - -C "$destination"

  node - "$destination" "$MARKETPLACE_NAME" "$cachebuster" <<'NODE'
const fs = require("fs");
const path = require("path");

const [root, marketplaceName, cachebuster] = process.argv.slice(2);

function updateJson(relativePath, update) {
  const file = path.join(root, relativePath);
  const data = JSON.parse(fs.readFileSync(file, "utf8"));
  update(data);
  fs.writeFileSync(file, `${JSON.stringify(data, null, 2)}\n`);
}

updateJson(".codex-plugin/plugin.json", (manifest) => {
  manifest.version = `${manifest.version.split("+")[0]}+codex.${cachebuster}`;
});

for (const marketplacePath of [
  ".agents/plugins/marketplace.json",
  ".claude-plugin/marketplace.json",
  ".github/plugin/marketplace.json",
]) {
  updateJson(marketplacePath, (marketplace) => {
    marketplace.name = marketplaceName;
    for (const plugin of marketplace.plugins ?? []) {
      if (marketplacePath === ".agents/plugins/marketplace.json") {
        plugin.source = { source: "local", path: "./plugins/semver-plugin" };
      }
    }
  });
}
NODE

  if [[ "$1" == codex ]]; then
    mkdir -p "$destination/plugins"
    ln -s .. "$destination/plugins/$PLUGIN_NAME"
  fi

  printf '%s\n' "$destination"
}

install_codex() {
  local snapshot
  require_command codex
  snapshot="$(prepare_snapshot codex)"
  run codex plugin remove "$PLUGIN_NAME@$MARKETPLACE_NAME" || true
  run codex plugin marketplace remove "$MARKETPLACE_NAME" || true
  run codex plugin marketplace add "$snapshot"
  run codex plugin add "$PLUGIN_NAME@$MARKETPLACE_NAME"
}

install_claude() {
  local snapshot
  require_command claude
  snapshot="$(prepare_snapshot claude)"
  run claude plugin uninstall "$PLUGIN_NAME@$MARKETPLACE_NAME" --scope local || true
  run claude plugin marketplace remove "$MARKETPLACE_NAME" --scope local || true
  run claude plugin marketplace add "$snapshot" --scope local
  run claude plugin install "$PLUGIN_NAME@$MARKETPLACE_NAME" --scope local
}

install_gemini() {
  require_command gemini
  run gemini extensions uninstall "$PLUGIN_NAME" || true
  run gemini extensions link "$ROOT_DIR" --consent
}

install_copilot() {
  local snapshot
  require_command copilot
  snapshot="$(prepare_snapshot copilot)"
  run copilot plugin uninstall "$PLUGIN_NAME@$MARKETPLACE_NAME" || true
  run copilot plugin marketplace remove "$MARKETPLACE_NAME" || true
  run copilot plugin marketplace add "$snapshot"
  run copilot plugin install "$PLUGIN_NAME@$MARKETPLACE_NAME"
}

case "$TARGET" in
  codex) install_codex ;;
  claude) install_claude ;;
  gemini) install_gemini ;;
  copilot) install_copilot ;;
  all)
    install_codex
    install_claude
    install_gemini
    install_copilot
    ;;
esac

printf '\nLocal %s installation complete. Start a new harness session to test it.\n' "$TARGET"

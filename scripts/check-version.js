#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");
const versionPath = path.join(root, "VERSION");
const manifestPaths = [
  ".codex-plugin/plugin.json",
  ".github/plugin/plugin.json",
  ".claude-plugin/plugin.json",
  "gemini-extension.json",
];
const codexManifestPath = ".codex-plugin/plugin.json";
const codexMarketplacePath = ".agents/plugins/marketplace.json";
const hooksPath = "hooks/hooks.json";

const semverPattern =
  /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|[0-9A-Za-z-]*[A-Za-z-][0-9A-Za-z-]*)(?:\.(?:0|[1-9]\d*|[0-9A-Za-z-]*[A-Za-z-][0-9A-Za-z-]*))*))?(?:\+([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?$/;

function readVersion() {
  return fs.readFileSync(versionPath, "utf8").trim();
}

function readJson(relativePath) {
  const fullPath = path.join(root, relativePath);
  return JSON.parse(fs.readFileSync(fullPath, "utf8"));
}

const version = readVersion();
const errors = [];

if (!semverPattern.test(version)) {
  errors.push(`VERSION must be strict SemVer 2.0.0, got "${version}".`);
}

for (const manifestPath of manifestPaths) {
  const manifest = readJson(manifestPath);

  if (manifest.version !== version) {
    errors.push(
      `${manifestPath} has version "${manifest.version}", expected "${version}".`,
    );
  }
}

const codexManifest = readJson(codexManifestPath);
const codexMarketplace = readJson(codexMarketplacePath);
const hooksConfig = readJson(hooksPath);
const codexEntry = codexMarketplace.plugins?.find(
  (plugin) => plugin.name === codexManifest.name,
);

if (codexManifest.name !== "semver-plugin") {
  errors.push(`${codexManifestPath} must use the plugin name "semver-plugin".`);
}

if (codexManifest.skills !== "./skills/") {
  errors.push(`${codexManifestPath} must expose skills from "./skills/".`);
}

// Codex auto-detects hooks/hooks.json at the plugin root, so the manifest
// must not repeat the hooks path (declaring it would be redundant).
if (Object.hasOwn(codexManifest, "hooks")) {
  errors.push(
    `${codexManifestPath} must not declare a hooks path; Codex auto-detects hooks/hooks.json.`,
  );
}

for (const eventName of ["SessionStart", "SubagentStart"]) {
  const commands = (hooksConfig.hooks?.[eventName] ?? []).flatMap(
    (entry) => entry.hooks ?? [],
  );

  if (commands.length === 0) {
    errors.push(`${hooksPath} must declare a ${eventName} hook.`);
  }

  for (const hook of commands) {
    if (!hook.command?.includes("CODEX_PLUGIN_ROOT")) {
      errors.push(`${hooksPath} ${eventName} must support CODEX_PLUGIN_ROOT.`);
    }

    if (!hook.commandWindows?.includes("CODEX_PLUGIN_ROOT")) {
      errors.push(
        `${hooksPath} ${eventName} Windows command must support CODEX_PLUGIN_ROOT.`,
      );
    }
  }
}

if (!codexEntry) {
  errors.push(
    `${codexMarketplacePath} must contain an entry for "${codexManifest.name}".`,
  );
} else {
  if (!codexEntry.source?.source || !codexEntry.source.url) {
    errors.push(`${codexMarketplacePath} must declare the plugin Git source.`);
  }

  if (!codexEntry.policy?.installation || !codexEntry.policy?.authentication) {
    errors.push(`${codexMarketplacePath} must declare the installation policy.`);
  }

  if (!codexEntry.category) {
    errors.push(`${codexMarketplacePath} must declare the plugin category.`);
  }
}

if (errors.length > 0) {
  for (const error of errors) {
    console.error(`version check failed: ${error}`);
  }

  process.exit(1);
}

console.log(`version check passed: ${version}`);

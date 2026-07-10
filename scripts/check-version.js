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

if (errors.length > 0) {
  for (const error of errors) {
    console.error(`version check failed: ${error}`);
  }

  process.exit(1);
}

console.log(`version check passed: ${version}`);

# SemVer Rules

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://semver.org/) [![CC BY 3.0](https://img.shields.io/badge/Rules-CC%20BY%203.0-lightgrey.svg)](LICENSES/CC-BY-3.0.txt)

![Abstract illustration of three connected version milestones](assets/semver-rules-hero.png)

> Portable plugin for coding agents that applies the official
> [Semantic Versioning 2.0.0](https://semver.org/) specification when planning
> and reviewing releases.

---

## 📋 Table of Contents

- [Use case and problem solved](#-use-case-and-problem-solved)
- [Languages](#-languages)
- [Features](#-features)
- [Supported harnesses](#-supported-harnesses)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project automation](#-project-automation)
- [License and attribution](#-license-and-attribution)

---

## 🎯 Use case and problem solved

Use this plugin when an agent needs to decide whether a set of changes should
produce a `major`, `minor`, `patch`, or no release, especially during release
planning, pull request review, changelog preparation, or version audits.

It solves a common release problem: version bumps are often chosen from commit
labels, gut feeling, or the size of a diff. SemVer instead depends on the
declared public API and compatibility impact. The plugin keeps that rule in
front of the agent, helps inspect the actual changes, and makes the release
recommendation easier to justify.

---

## 🌐 Languages

English is the canonical README. Translations are provided in five of the
world's most widely spoken first languages:

[🇺🇸 English](README.md) · [🇨🇳 中文（简体）](docs/README.zh-CN.md) · [🇪🇸 Español](docs/README.es.md) · [🇮🇳 हिन्दी](docs/README.hi.md) · [🇧🇷 Português (Brasil)](docs/README.pt-BR.md)

---

## ✨ Features

| Skill | Description |
| --- | --- |
| `semver` | Chooses the next version and validates version syntax and precedence |
| `semver-review` | Reviews changes and recommends `major`, `minor`, `patch`, or no release |
| Hooks | Session- and subagent-start hooks load a concise rules reminder without external dependencies beyond the host's Node.js runtime |

---

## 🔌 Supported harnesses

| Harness | Integration |
| --- | --- |
| **Codex** | manifest, skills, and hooks |
| **Claude Code** | manifest, skills, and hooks |
| **Gemini CLI** | extension, context, skills, and session hook |
| **GitHub Copilot CLI** | plugin, skills, and hooks |
| **OpenCode / Cursor** | portable instructions through `AGENTS.md` |

---

## 📦 Installation

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Open `/hooks`, review and authorize the hooks, then start a new conversation.

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

By default the plugin is installed at the user level. To choose where it
applies, pass `--scope`:

```sh
claude plugin install semver-plugin@semver-plugin --scope user     # all your projects (default)
claude plugin install semver-plugin@semver-plugin --scope project  # shared via .claude/settings.json
claude plugin install semver-plugin@semver-plugin --scope local    # this machine only (.claude/settings.local.json)
```

The interactive `/plugin` menu also lets you pick the scope at install time.

Run `/reload-plugins` or start a new session.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Restart the Gemini session. To develop from a local clone, run
`gemini extensions link .`.

### GitHub Copilot CLI

Marketplace installs are the forward-compatible path. Direct repository installs
still work today, but Copilot warns that they are deprecated:

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode and Cursor

These harnesses discover `AGENTS.md` in the project. Clone the repository and
copy or link the file without overwriting existing instructions:

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /path/to/project/AGENTS.md
```

> **💡 Tip:** If the project already has an `AGENTS.md`, incorporate the SemVer
> section manually.

---

## 🚀 Usage

After installation, try:

- *"What should the next version be after these changes?"*
- *"Review this diff according to SemVer."*
- *"Order these versions with pre-releases."*

> **ℹ️ Note:** The plugin follows SemVer 2.0.0. npm, Cargo, PEP 440, or other
> ecosystem conventions apply only when explicitly requested.

---

## 🤖 Project automation

This repository keeps the release version in [`VERSION`](VERSION). The same
version must appear in the Codex, Claude Code, and GitHub Copilot plugin
manifests. CI runs `node scripts/check-version.js` on pull requests and pushes
to `main` or `dev`.

When `dev` changes, the promotion workflow validates the version and prints a
compare link for opening a `dev` to `main` pull request. It does not create or
merge pull requests automatically.

When `main` changes, the release workflow validates the version, creates the
GitHub tag `vX.Y.Z`, builds `semver-plugin-X.Y.Z.zip`, and publishes a GitHub
Release. `VERSION` remains strict SemVer without the leading `v`.

---

## 📄 License and attribution

The plugin's original code and documentation are licensed under the
[MIT License](LICENSE). The Semantic Versioning 2.0.0 rules incorporated or
adapted here are attributed to Tom Preston-Werner and are available under
[CC BY 3.0](LICENSES/CC-BY-3.0.txt). See [NOTICE](NOTICE) for the required
attribution and source link.

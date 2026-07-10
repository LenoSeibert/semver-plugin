# SemVer Rules

Portable plugin for coding agents that applies the official
[Semantic Versioning 2.0.0](https://semver.org/) specification when planning
and reviewing releases.

## Languages

English is the canonical README. Translations are provided in five of the
world's most widely spoken first languages:

- [English](README.md)
- [中文（简体）](docs/README.zh-CN.md)
- [Español](docs/README.es.md)
- [हिन्दी](docs/README.hi.md)
- [Português (Brasil)](docs/README.pt-BR.md)

## Features

- `semver`: chooses the next version and validates version syntax and
  precedence.
- `semver-review`: reviews changes and recommends `major`, `minor`, `patch`,
  or no release.
- Session- and subagent-start hooks load a concise rules reminder without
  external dependencies beyond the host's Node.js runtime.

## Supported harnesses

| Harness | Integration |
| --- | --- |
| Codex | manifest, skills, and hooks |
| Claude Code | manifest, skills, and hooks |
| Gemini CLI | extension, context, skills, and session hook |
| GitHub Copilot CLI | plugin, skills, and hooks |
| OpenCode and Cursor | portable instructions through `AGENTS.md` |

## Installation

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

Run `/reload-plugins` or start a new session.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Restart the Gemini session. To develop from a local clone, run
`gemini extensions link .`.

### GitHub Copilot CLI

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

If the project already has an `AGENTS.md`, incorporate the SemVer section
manually.

## Usage

After installation, try:

- “What should the next version be after these changes?”
- “Review this diff according to SemVer.”
- “Order these versions with pre-releases.”

The plugin follows SemVer 2.0.0. npm, Cargo, PEP 440, or other ecosystem
conventions apply only when explicitly requested.

## License and attribution

The plugin's original code and documentation are licensed under the
[MIT License](LICENSE). The Semantic Versioning 2.0.0 rules incorporated or
adapted here are attributed to Tom Preston-Werner and are available under
[CC BY 3.0](LICENSES/CC-BY-3.0.txt). See [NOTICE](NOTICE) for the required
attribution and source link.

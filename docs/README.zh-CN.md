# SemVer 规则

[![License: MIT](https://img.shields.io/badge/%E8%AE%B8%E5%8F%AF%E8%AF%81-MIT-yellow.svg)](../LICENSE) [![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://semver.org/) [![CC BY 3.0](https://img.shields.io/badge/%E8%A7%84%E5%88%99-CC%20BY%203.0-lightgrey.svg)](../LICENSES/CC-BY-3.0.txt)

![三个相连版本里程碑的抽象插图](../assets/semver-rules-hero.png)

> 这是一个适用于编程代理的便携式插件；它在规划和审查发布时应用官方的
> [Semantic Versioning 2.0.0](https://semver.org/) 规范。

[🇺🇸 English](../README.md) · [🇪🇸 Español](README.es.md) · [🇮🇳 हिन्दी](README.hi.md) · [🇧🇷 Português (Brasil)](README.pt-BR.md)

---

## 📋 目录

- [使用场景和解决的问题](#-使用场景和解决的问题)
- [功能](#-功能)
- [支持的环境](#-支持的环境)
- [安装](#-安装)
- [使用](#-使用)
- [许可证和署名](#-许可证和署名)

---

## 🎯 使用场景和解决的问题

当代理需要判断一组变更应该发布为 `major`、`minor`、`patch`，还是不发布新版本时，
可以使用这个插件。它特别适合发布规划、pull request 审查、changelog 准备和版本审计。

它解决的是常见的发布判断问题：版本升级经常根据 commit 标签、直觉或 diff 大小来决定。
但 SemVer 关注的是已声明的公共 API 以及兼容性影响。这个插件会让代理始终围绕这条规则
判断，帮助检查真实变更，并让发布建议更容易解释。

---

## ✨ 功能

| Skill | 描述 |
| --- | --- |
| `semver` | 选择下一个版本，并验证版本语法和优先级 |
| `semver-review` | 审查变更，并建议 `major`、`minor`、`patch` 或不发布新版本 |
| Hooks | 会话和子代理启动 hook 会加载简明的规则提示；除宿主提供的 Node.js 外，无需外部依赖 |

---

## 🔌 支持的环境

| 环境 | 集成方式 |
| --- | --- |
| **Codex** | 清单、skills 和 hooks |
| **Claude Code** | 清单、skills 和 hooks |
| **Gemini CLI** | 扩展、上下文、skills 和会话 hook |
| **GitHub Copilot CLI** | 插件、skills 和 hooks |
| **OpenCode / Cursor** | 通过 `AGENTS.md` 提供可移植指令 |

---

## 📦 安装

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

打开 `/hooks`，审核并授权 hooks，然后开始新对话。

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

运行 `/reload-plugins`，或开始新会话。

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

重启 Gemini 会话。从本地克隆开发时，运行 `gemini extensions link .`。

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode 和 Cursor

这些环境会发现项目中的 `AGENTS.md`。克隆仓库后复制或链接该文件，且不要覆盖已有指令：

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /path/to/project/AGENTS.md
```

> **💡 提示：** 如果项目已有 `AGENTS.md`，请手动合并 SemVer 部分。

---

## 🚀 使用

安装后，可以尝试：

- *"这些变更后的下一个版本应是什么？"*
- *"根据 SemVer 审查这个 diff。"*
- *"给这些带预发布版本的版本号排序。"*

> **ℹ️ 注意：** 插件遵循 SemVer 2.0.0。仅在明确请求时才应用 npm、Cargo、PEP 440
> 或其他生态系统的惯例。

---

## 📄 许可证和署名

插件原创代码和文档采用 [MIT 许可证](../LICENSE)。此处包含或改编的
Semantic Versioning 2.0.0 规则署名 Tom Preston-Werner，并采用
[CC BY 3.0](../LICENSES/CC-BY-3.0.txt)。所需署名和来源链接见 [NOTICE](../NOTICE)。

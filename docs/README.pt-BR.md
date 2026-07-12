# Regras SemVer

[![License: MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-yellow.svg)](../LICENSE) [![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://semver.org/) [![CC BY 3.0](https://img.shields.io/badge/Regras-CC%20BY%203.0-lightgrey.svg)](../LICENSES/CC-BY-3.0.txt)

![Ilustração abstrata de três marcos de versão conectados](../assets/semver-rules-hero.png)

> Plugin portátil para agentes de código que aplica a especificação oficial
> [Semantic Versioning 2.0.0](https://semver.org/) ao planejar e revisar releases.

[🇺🇸 English](../README.md) · [🇨🇳 中文（简体）](README.zh-CN.md) · [🇪🇸 Español](README.es.md) · [🇮🇳 हिन्दी](README.hi.md)

---

## 📋 Sumário

- [Caso de uso e problema resolvido](#-caso-de-uso-e-problema-resolvido)
- [Recursos](#-recursos)
- [Harnesses compatíveis](#-harnesses-compatíveis)
- [Instalação](#-instalação)
- [Atualização](#-atualização)
- [Uso](#-uso)
- [Automação do projeto](#-automação-do-projeto)
- [Licença e atribuição](#-licença-e-atribuição)

---

## 🎯 Caso de uso e problema resolvido

Use este plugin quando um agente precisar decidir se um conjunto de mudanças
deve gerar uma release `major`, `minor`, `patch` ou nenhuma release,
especialmente em planejamento de release, revisão de pull request, preparação
de changelog ou auditoria de versões.

Ele resolve um problema comum de release: o incremento de versão muitas vezes é
escolhido por rótulos de commit, intuição ou tamanho do diff. SemVer depende da
API pública declarada e do impacto de compatibilidade. O plugin mantém essa
regra em foco para o agente, ajuda a inspecionar as mudanças reais e torna a
recomendação de release mais fácil de justificar.

---

## ✨ Recursos

| Skill | Descrição |
| --- | --- |
| `semver` | Escolhe a próxima versão e valida sintaxe e precedência |
| `semver-review` | Revisa mudanças e recomenda `major`, `minor`, `patch` ou nenhuma release |
| Hooks | Hooks no início de sessão e de subagente carregam um lembrete conciso das regras, sem dependências externas além do Node.js do host |

---

## 🔌 Harnesses compatíveis

| Harness | Integração |
| --- | --- |
| **Codex** | manifesto nativo, marketplace, skills e hooks |
| **Claude Code** | manifesto, skills e hooks |
| **Gemini CLI** | extensão, contexto, skills e hook de sessão |
| **GitHub Copilot CLI** | plugin, skills e hooks |
| **OpenCode / Cursor** | instruções portáteis por `AGENTS.md` |

---

## 📦 Instalação

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Abra `/hooks`, revise e autorize os hooks e inicie uma nova tarefa no Codex.

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

Por padrão o plugin é instalado no nível do usuário. Para escolher onde ele
se aplica, use `--scope`:

```sh
claude plugin install semver-plugin@semver-plugin --scope user     # todos os seus projetos (padrão)
claude plugin install semver-plugin@semver-plugin --scope project  # compartilhado via .claude/settings.json
claude plugin install semver-plugin@semver-plugin --scope local    # apenas esta máquina (.claude/settings.local.json)
```

O menu interativo `/plugin` também permite escolher o escopo na instalação.

Execute `/reload-plugins` ou abra uma nova sessão.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Reinicie a sessão do Gemini. Para desenvolver a partir de um clone local, use
`gemini extensions link .`.

### GitHub Copilot CLI

Instalações via marketplace são o caminho compatível com o futuro. A instalação
direta pelo repositório ainda funciona hoje, mas o Copilot avisa que ela está
obsoleta:

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode e Cursor

Esses harnesses encontram `AGENTS.md` no projeto. Clone o repositório e copie
ou vincule o arquivo sem sobrescrever instruções existentes:

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /caminho/do/projeto/AGENTS.md
```

> **💡 Dica:** Se o projeto já tiver `AGENTS.md`, incorpore manualmente a seção
> do SemVer.

---

## 🔄 Atualização

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Reexecutar os comandos de instalação atualiza o marketplace e busca a versão
mais recente. Reautorize os hooks em `/hooks` se solicitado e inicie uma nova tarefa.

### Claude Code

```sh
claude plugin marketplace update semver-plugin
claude plugin update semver-plugin@semver-plugin
```

Execute `/reload-plugins` ou abra uma nova sessão.

### Gemini CLI

```sh
gemini extensions update semver-plugin
```

Use `gemini extensions update --all` para atualizar todas as extensões
instaladas. Reinicie a sessão do Gemini depois.

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

Reexecutar o comando de instalação busca a versão mais recente.

### OpenCode e Cursor

Atualize o repositório e copie o arquivo novamente, preservando edições locais:

```sh
git -C semver-plugin pull
cp semver-plugin/AGENTS.md /caminho/do/projeto/AGENTS.md
```

> **💡 Dica:** Se você mesclou a seção do SemVer em um `AGENTS.md` existente,
> reconcilie as mudanças manualmente em vez de sobrescrever.

---

## 🚀 Uso

Após instalar, tente:

- *"Qual deve ser a próxima versão depois destas mudanças?"*
- *"Revise este diff segundo SemVer."*
- *"Ordene estas versões com pre-releases."*

> **ℹ️ Nota:** O plugin segue SemVer 2.0.0. Convenções de npm, Cargo, PEP 440
> ou de outros ecossistemas só se aplicam quando forem solicitadas explicitamente.

---

## 🤖 Automação do projeto

Este repositório mantém a versão de release em [`VERSION`](../VERSION). A mesma
versão deve aparecer nos manifests dos plugins para Codex, Claude Code e GitHub
Copilot. O CI executa `node scripts/check-version.js` em pull requests e pushes
para `main` ou `dev`.

Quando `dev` muda, o workflow de promoção valida a versão e imprime um link de
comparação para abrir um pull request de `dev` para `main`. Ele não cria nem faz
merge de pull requests automaticamente.

Quando `main` muda, o workflow de release valida a versão, cria a tag GitHub
`vX.Y.Z`, gera `semver-plugin-X.Y.Z.zip` e publica uma GitHub Release. O arquivo
`VERSION` continua usando SemVer estrito, sem o `v` inicial.

---

## 📄 Licença e atribuição

O código e a documentação originais do plugin usam a [Licença MIT](../LICENSE).
As regras de Semantic Versioning 2.0.0 incorporadas ou adaptadas têm autoria de
Tom Preston-Werner e usam [CC BY 3.0](../LICENSES/CC-BY-3.0.txt). Consulte o
[NOTICE](../NOTICE) para atribuição e link da fonte.

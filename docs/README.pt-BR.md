# Regras SemVer

Plugin portátil para agentes de código que aplica a especificação oficial
[Semantic Versioning 2.0.0](https://semver.org/) ao planejar e revisar releases.

[English](../README.md) · [中文（简体）](README.zh-CN.md) · [Español](README.es.md) · [हिन्दी](README.hi.md)

## Recursos

- `semver`: escolhe a próxima versão e valida sintaxe e precedência.
- `semver-review`: revisa mudanças e recomenda `major`, `minor`, `patch` ou
  nenhuma release.
- Hooks no início de sessão e de subagente carregam um lembrete conciso das
  regras, sem dependências externas além do Node.js do host.

## Harnesses compatíveis

| Harness | Integração |
| --- | --- |
| Codex | manifesto, skills e hooks |
| Claude Code | manifesto, skills e hooks |
| Gemini CLI | extensão, contexto, skills e hook de sessão |
| GitHub Copilot CLI | plugin, skills e hooks |
| OpenCode e Cursor | instruções portáteis por `AGENTS.md` |

## Instalação

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Abra `/hooks`, revise e autorize os hooks e inicie uma nova conversa.

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

Execute `/reload-plugins` ou abra uma nova sessão.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Reinicie a sessão do Gemini. Para desenvolver a partir de um clone local, use
`gemini extensions link .`.

### GitHub Copilot CLI

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

Se o projeto já tiver `AGENTS.md`, incorpore manualmente a seção do SemVer.

## Uso

Após instalar, tente:

- “Qual deve ser a próxima versão depois destas mudanças?”
- “Revise este diff segundo SemVer.”
- “Ordene estas versões com pre-releases.”

O plugin segue SemVer 2.0.0. Convenções de npm, Cargo, PEP 440 ou de outros
ecossistemas só se aplicam quando forem solicitadas explicitamente.

## Licença e atribuição

O código e a documentação originais do plugin usam a [Licença MIT](../LICENSE).
As regras de Semantic Versioning 2.0.0 incorporadas ou adaptadas têm autoria de
Tom Preston-Werner e usam [CC BY 3.0](../LICENSES/CC-BY-3.0.txt). Consulte o
[NOTICE](../NOTICE) para atribuição e link da fonte.

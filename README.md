# SemVer Rules

Plugin portátil para agentes de código que aplica a especificação oficial
[Semantic Versioning 2.0.0](https://semver.org/) ao planejar e revisar releases.

## Recursos

- `semver`: escolhe o próximo número de versão e valida versões/predecência.
- `semver-review`: revisa mudanças e recomenda `major`, `minor`, `patch` ou
  nenhuma release.
- hooks de início de sessão e subagente: carregam um lembrete curto das regras
  sem exigir dependências externas além do Node.js usado pelo host.

## Harnesses suportados

| Harness | Integração |
| --- | --- |
| Codex | manifesto, skills e hooks |
| Claude Code | manifesto, skills e hooks |
| Gemini CLI | extensão, contexto, skills e hook de sessão |
| GitHub Copilot CLI | plugin, skills e hooks |
| OpenCode e Cursor | instruções portáteis via `AGENTS.md` |

## Instalação

Enquanto o [repositório](https://github.com/LenoSeibert/semver-plugin) estiver
privado, autentique o GitHub antes de instalar (`gh auth login` seguido de
`gh auth setup-git`) e confirme que sua conta tem acesso. Depois que ele se
tornar público, essa etapa deixa de ser necessária.

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Abra `/hooks`, revise e autorize os hooks, e inicie uma nova conversa.

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

Reinicie a sessão do Gemini CLI. Para desenvolvimento a partir de um clone
local, use `gemini extensions link .`.

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode e Cursor

Esses harnesses descobrem `AGENTS.md` no projeto. Baixe o repositório e copie
ou vincule o arquivo sem sobrescrever instruções já existentes:

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /caminho/do/projeto/AGENTS.md
```

Se o projeto já tiver `AGENTS.md`, incorpore a seção de SemVer manualmente.

## Uso

Depois da instalação, tente:

- “Qual deve ser a próxima versão depois destas mudanças?”
- “Revise este diff segundo SemVer.”
- “Ordene estas versões com pre-releases.”

O plugin segue SemVer 2.0.0; convenções específicas de npm, Cargo, PEP 440 ou
outros ecossistemas só se aplicam quando forem explicitamente solicitadas.

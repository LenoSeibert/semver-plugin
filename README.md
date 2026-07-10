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

## Uso

Instale o diretório como plugin local, aprove os hooks em `/hooks` e tente:

- “Qual deve ser a próxima versão depois destas mudanças?”
- “Revise este diff segundo SemVer.”
- “Ordene estas versões com pre-releases.”

Instalação local por harness:

```sh
# Gemini CLI
gemini extensions link .

# GitHub Copilot CLI, depois de publicar o repositório
copilot plugin install OWNER/REPO
```

Codex e Claude Code usam seus manifestos nativos. Para OpenCode ou Cursor,
copie ou vincule `AGENTS.md` no projeto que deve seguir estas regras; ambos
descobrem esse arquivo nativamente.

O plugin segue SemVer 2.0.0; convenções específicas de npm, Cargo, PEP 440 ou
outros ecossistemas só se aplicam quando forem explicitamente solicitadas.

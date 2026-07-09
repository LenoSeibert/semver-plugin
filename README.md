# SemVer Rules

Plugin para Codex que aplica a especificação oficial [Semantic Versioning
2.0.0](https://semver.org/) ao planejar e revisar releases.

## Recursos

- `semver`: escolhe o próximo número de versão e valida versões/predecência.
- `semver-review`: revisa mudanças e recomenda `major`, `minor`, `patch` ou
  nenhuma release.
- hooks de início de sessão e subagente: carregam um lembrete curto das regras
  sem exigir dependências externas além do Node.js usado pelo host.

## Uso

Instale o diretório como plugin local, aprove os hooks em `/hooks` e tente:

- “Qual deve ser a próxima versão depois destas mudanças?”
- “Revise este diff segundo SemVer.”
- “Ordene estas versões com pre-releases.”

O plugin segue SemVer 2.0.0; convenções específicas de npm, Cargo, PEP 440 ou
outros ecossistemas só se aplicam quando forem explicitamente solicitadas.

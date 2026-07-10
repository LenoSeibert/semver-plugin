# Reglas SemVer

![Ilustración abstracta de tres hitos de versión conectados](../assets/semver-rules-hero.png)

Plugin portátil para agentes de programación que aplica la especificación
oficial [Semantic Versioning 2.0.0](https://semver.org/) al planificar y revisar
versiones.

[English](../README.md) · [中文（简体）](README.zh-CN.md) · [हिन्दी](README.hi.md) · [Português (Brasil)](README.pt-BR.md)

## Caso de uso y problema que resuelve

Use este plugin cuando un agente necesite decidir si un conjunto de cambios debe
generar una versión `major`, `minor`, `patch` o ninguna publicación,
especialmente durante la planificación de versiones, la revisión de pull
requests, la preparación del changelog o las auditorías de versiones.

Resuelve un problema común de publicación: el incremento de versión suele
elegirse por etiquetas de commits, intuición o tamaño del diff. SemVer depende
de la API pública declarada y del impacto en la compatibilidad. El plugin
mantiene esa regla presente para el agente, ayuda a inspeccionar los cambios
reales y facilita justificar la recomendación de publicación.

## Funciones

- `semver`: elige la siguiente versión y valida la sintaxis y la precedencia.
- `semver-review`: revisa cambios y recomienda `major`, `minor`, `patch` o no
  publicar una versión.
- Los hooks de inicio de sesión y subagente cargan un recordatorio breve sin
  dependencias externas aparte de Node.js del host.

## Entornos compatibles

| Entorno | Integración |
| --- | --- |
| Codex | manifiesto, skills y hooks |
| Claude Code | manifiesto, skills y hooks |
| Gemini CLI | extensión, contexto, skills y hook de sesión |
| GitHub Copilot CLI | plugin, skills y hooks |
| OpenCode y Cursor | instrucciones portátiles mediante `AGENTS.md` |

## Instalación

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Abra `/hooks`, revise y autorice los hooks y luego inicie una conversación nueva.

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

Ejecute `/reload-plugins` o inicie una sesión nueva.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Reinicie la sesión de Gemini. Para desarrollar desde un clon local, ejecute
`gemini extensions link .`.

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode y Cursor

Estos entornos detectan `AGENTS.md` en el proyecto. Clone el repositorio y copie
o enlace el archivo sin sobrescribir instrucciones existentes:

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /ruta/al/proyecto/AGENTS.md
```

Si el proyecto ya tiene un `AGENTS.md`, incorpore manualmente la sección SemVer.

## Uso

Después de instalarlo, pruebe:

- “¿Cuál debe ser la próxima versión después de estos cambios?”
- “Revisa este diff según SemVer.”
- “Ordena estas versiones con versiones preliminares.”

El plugin sigue SemVer 2.0.0. Las convenciones de npm, Cargo, PEP 440 u otros
ecosistemas solo se aplican cuando se solicitan explícitamente.

## Licencia y atribución

El código y la documentación originales del plugin están bajo la
[Licencia MIT](../LICENSE). Las reglas de Semantic Versioning 2.0.0 incorporadas
o adaptadas se atribuyen a Tom Preston-Werner y están bajo
[CC BY 3.0](../LICENSES/CC-BY-3.0.txt). Consulte [NOTICE](../NOTICE) para la
atribución y el enlace de origen.

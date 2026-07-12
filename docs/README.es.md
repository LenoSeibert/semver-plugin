# Reglas SemVer

[![License: MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg)](../LICENSE) [![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://semver.org/) [![CC BY 3.0](https://img.shields.io/badge/Reglas-CC%20BY%203.0-lightgrey.svg)](../LICENSES/CC-BY-3.0.txt)

![Ilustración abstracta de tres hitos de versión conectados](../assets/semver-rules-hero.png)

> Plugin portátil para agentes de programación que aplica la especificación
> oficial [Semantic Versioning 2.0.0](https://semver.org/) al planificar y revisar
> versiones.

[🇺🇸 English](../README.md) · [🇨🇳 中文（简体）](README.zh-CN.md) · [🇮🇳 हिन्दी](README.hi.md) · [🇧🇷 Português (Brasil)](README.pt-BR.md)

---

## 📋 Tabla de contenidos

- [Caso de uso y problema que resuelve](#-caso-de-uso-y-problema-que-resuelve)
- [Funciones](#-funciones)
- [Entornos compatibles](#-entornos-compatibles)
- [Instalación](#-instalación)
- [Actualización](#-actualización)
- [Uso](#-uso)
- [Automatización del proyecto](#-automatización-del-proyecto)
- [Licencia y atribución](#-licencia-y-atribución)

---

## 🎯 Caso de uso y problema que resuelve

Use este plugin cuando un agente necesite decidir si un conjunto de cambios debe
generar una versión `major`, `minor`, `patch` o ninguna publicación,
especialmente durante la planificación de versiones, la revisión de pull
requests, la preparación del changelog o las auditorías de versiones.

Resuelve un problema común de publicación: el incremento de versión suele
elegirse por etiquetas de commits, intuición o tamaño del diff. SemVer depende
de la API pública declarada y del impacto en la compatibilidad. El plugin
mantiene esa regla presente para el agente, ayuda a inspeccionar los cambios
reales y facilita justificar la recomendación de publicación.

---

## ✨ Funciones

| Skill | Descripción |
| --- | --- |
| `semver` | Elige la siguiente versión y valida la sintaxis y la precedencia |
| `semver-review` | Revisa cambios y recomienda `major`, `minor`, `patch` o no publicar una versión |
| Hooks | Los hooks de inicio de sesión y subagente cargan un recordatorio breve sin dependencias externas aparte de Node.js del host |

---

## 🔌 Entornos compatibles

| Entorno | Integración |
| --- | --- |
| **Codex** | manifiesto nativo, marketplace, skills y hooks |
| **Claude Code** | manifiesto, skills y hooks |
| **Gemini CLI** | extensión, contexto, skills y hook de sesión |
| **GitHub Copilot CLI** | plugin, skills y hooks |
| **OpenCode / Cursor** | instrucciones portátiles mediante `AGENTS.md` |

---

## 📦 Instalación

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Abra `/hooks`, revise y autorice los hooks y luego inicie una nueva tarea en Codex.

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

De forma predeterminada, el plugin se instala a nivel de usuario. Para elegir
dónde se aplica, use `--scope`:

```sh
claude plugin install semver-plugin@semver-plugin --scope user     # todos sus proyectos (predeterminado)
claude plugin install semver-plugin@semver-plugin --scope project  # compartido vía .claude/settings.json
claude plugin install semver-plugin@semver-plugin --scope local    # solo esta máquina (.claude/settings.local.json)
```

El menú interactivo `/plugin` también permite elegir el alcance al instalar.

Ejecute `/reload-plugins` o inicie una sesión nueva.

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Reinicie la sesión de Gemini. Para desarrollar desde un clon local, ejecute
`gemini extensions link .`.

### GitHub Copilot CLI

Las instalaciones mediante marketplace son la ruta compatible a futuro. La
instalación directa desde el repositorio todavía funciona hoy, pero Copilot
advierte que está obsoleta:

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

> **💡 Consejo:** Si el proyecto ya tiene un `AGENTS.md`, incorpore manualmente
> la sección SemVer.

---

## 🔄 Actualización

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

Volver a ejecutar los comandos de instalación actualiza el marketplace y obtiene
la versión más reciente. Vuelva a autorizar los hooks en `/hooks` si se le solicita e inicie una nueva tarea.

### Claude Code

```sh
claude plugin marketplace update semver-plugin
claude plugin update semver-plugin@semver-plugin
```

Ejecute `/reload-plugins` o inicie una sesión nueva.

### Gemini CLI

```sh
gemini extensions update semver-plugin
```

Use `gemini extensions update --all` para actualizar todas las extensiones
instaladas. Reinicie la sesión de Gemini después.

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

Volver a ejecutar el comando de instalación obtiene la versión más reciente.

### OpenCode y Cursor

Actualice el repositorio y vuelva a copiar el archivo, preservando las ediciones
locales:

```sh
git -C semver-plugin pull
cp semver-plugin/AGENTS.md /ruta/al/proyecto/AGENTS.md
```

> **💡 Consejo:** Si fusionó la sección SemVer en un `AGENTS.md` existente,
> reconcilie los cambios manualmente en lugar de sobrescribir.

---

## 🚀 Uso

Después de instalarlo, pruebe:

- *"¿Cuál debe ser la próxima versión después de estos cambios?"*
- *"Revisa este diff según SemVer."*
- *"Ordena estas versiones con versiones preliminares."*

> **ℹ️ Nota:** El plugin sigue SemVer 2.0.0. Las convenciones de npm, Cargo,
> PEP 440 u otros ecosistemas solo se aplican cuando se solicitan explícitamente.

---

## 🤖 Automatización del proyecto

Este repositorio mantiene la versión de publicación en [`VERSION`](../VERSION).
La misma versión debe aparecer en los manifiestos de los plugins para Codex,
Claude Code y GitHub Copilot. CI ejecuta `node scripts/check-version.js` en pull
requests y pushes a `main` o `dev`.

Cuando cambia `dev`, el workflow de promoción valida la versión e imprime un
enlace de comparación para abrir un pull request de `dev` a `main`. No crea ni
fusiona pull requests automáticamente.

Cuando cambia `main`, el workflow de release valida la versión, crea la etiqueta
de GitHub `vX.Y.Z`, genera `semver-plugin-X.Y.Z.zip` y publica una GitHub
Release. El archivo `VERSION` sigue usando SemVer estricto, sin la `v` inicial.

---

## 📄 Licencia y atribución

El código y la documentación originales del plugin están bajo la
[Licencia MIT](../LICENSE). Las reglas de Semantic Versioning 2.0.0 incorporadas
o adaptadas se atribuyen a Tom Preston-Werner y están bajo
[CC BY 3.0](../LICENSES/CC-BY-3.0.txt). Consulte [NOTICE](../NOTICE) para la
atribución y el enlace de origen.

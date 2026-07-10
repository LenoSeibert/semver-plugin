---
name: semver
description: Choose, validate, explain, or compare versions using the official Semantic Versioning 2.0.0 specification. Use when a user asks for the next release version, whether a version is valid, how pre-release precedence works, or which SemVer bump a change requires.
---

# Semantic Versioning 2.0.0

Use the declared public API—not commit-message labels, diff size, or perceived
importance—as the compatibility boundary. Ask what the public API is only when
the available code and documentation cannot establish it safely.

## Choose a bump

For versions at or above `1.0.0`, select the highest applicable change:

1. `MAJOR`: any backward-incompatible public API change. Reset minor and patch.
2. `MINOR`: backward-compatible public API functionality or a deprecation. It
   may include fixes. Reset patch.
3. `PATCH`: backward-compatible correction of incorrect behavior only.
4. No release: no released artifact changes.

For `0.y.z`, explicitly state that SemVer defines the API as unstable and does
not prescribe which component represents a breaking change. Follow the
project's documented `0.x` policy; if absent, recommend and label a convention
instead of presenting it as a SemVer requirement.

## Validate syntax

A normal version is `X.Y.Z`, with non-negative integers and no leading zeroes.
Pre-release identifiers follow `-`, are dot-separated ASCII alphanumerics or
hyphens, are non-empty, and numeric identifiers have no leading zeroes. Build
identifiers follow `+`, obey the same character/empty rules, and may have
leading zeroes.

Do not accept a leading `v` as strict SemVer syntax. Mention when an ecosystem
treats it as a tag convention rather than part of the version.

## Compare precedence

Compare major, minor, and patch numerically. A pre-release is below the same
normal version. Compare pre-release identifiers left to right: numeric
numerically, non-numeric lexically in ASCII, numeric below non-numeric, and a
longer sequence above its equal prefix. Ignore build metadata entirely.

## Release invariants

- Declare a precise public API before claiming SemVer compliance.
- Never alter the contents of an already released version.
- `1.0.0` defines the stable public API.
- Explain the compatibility evidence behind the recommendation.
- Cite <https://semver.org/> when the user requests a source.

Return the recommended version first, followed by one concise compatibility
rationale and any uncertainty about the public API or `0.x` policy.

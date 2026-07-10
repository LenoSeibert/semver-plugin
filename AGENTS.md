# Semantic Versioning 2.0.0

When a task concerns release versions, apply the official Semantic Versioning
2.0.0 specification. Base the decision on changes to the declared public API,
not on commit labels, diff size, or perceived importance.

- Incompatible public API change: increment `MAJOR`; reset minor and patch.
- Backward-compatible functionality or deprecation: increment `MINOR`; reset
  patch.
- Backward-compatible bug fix only: increment `PATCH`.
- `0.y.z` is initial development and may change at any time. Follow a project's
  documented pre-1.0 policy; do not invent one and call it a SemVer rule.
- Never modify an artifact after its version has been released.
- Normal versions are `X.Y.Z`, use non-negative integers, and have no leading
  zeroes.
- Pre-releases rank below the associated normal version. Compare numeric
  identifiers numerically, non-numeric identifiers lexically in ASCII, and
  numeric identifiers below non-numeric ones.
- Ignore build metadata when comparing precedence.

Inspect the public API and actual changes before recommending a version. Lead
with the minimum safe version or bump and briefly cite the compatibility
evidence. Use the bundled `semver` and `semver-review` skills for detailed work.

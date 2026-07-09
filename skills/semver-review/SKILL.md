---
name: semver-review
description: Review a diff, changelog, pull request, or release plan for Semantic Versioning 2.0.0 compliance and recommend the minimum safe version bump. Use for release reviews, breaking-change checks, changelog audits, and version-bump verification.
---

# SemVer Release Review

Inspect the public API definition and the actual changes. Include documented
interfaces such as libraries, CLIs, protocols, file formats, configuration,
schemas, and observable behavior when consumers can depend on them.

## Review

1. Identify the current released version and public API boundary.
2. List consumer-visible changes, separating incompatible changes,
   backward-compatible features/deprecations, fixes, and internal-only work.
3. Select the highest required bump using SemVer 2.0.0.
4. Verify that lower components reset, the proposed version has not already
   been released, and pre-release/build labels are valid when used.
5. Flag uncertainty when compatibility cannot be established from evidence.

Do not downgrade a bump because a break seems small, optional, or easy to
migrate. Do not upgrade a bump merely because the implementation diff is
large. Under `0.y.z`, report that SemVer permits arbitrary change and evaluate
the repository's documented pre-1.0 policy separately.

## Output

Lead with `Recommendation: <version or bump>`. Then give only evidence-backed
findings, highest severity first, with file locations when reviewing a repo.
End with missing evidence or `No SemVer blockers found.`

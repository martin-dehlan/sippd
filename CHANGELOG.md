# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) with a
trailing build number (`MAJOR.MINOR.PATCH+BUILD`), per
[`RULES/11`](./.claude/RULES/11_versioning_commits.md).

Each release includes a **Security** subsection identifying any vulnerabilities
fixed in that release (or stating "none"). Vulnerabilities are reported per
[SECURITY.md](./SECURITY.md).

## [Unreleased]

### Added

- Project hardening for the OpenSSF Best Practices passing badge: Apache-2.0
  relicense, `CONTRIBUTING.md`, `docs/INTERFACE.md`, this changelog, PR
  template, OpenSSF Scorecard + dependency-vulnerability scanning workflows,
  and stricter analyzer settings.

### Security

- None.

## [0.1.23+30] — 2026-06-01

First documented release. Earlier history (≤ `0.1.22`) lives in the git log;
this changelog starts here. Continuously shipped to TestFlight (iOS) and Play
Internal (Android).

### Added

- Wine ranking with photos, tags, price, and venue/region tagging via GPS.
- Local-first sync — Drift (SQLite) is the on-device source of truth;
  Supabase syncs in the background with an image-upload retry outbox.
- Canonical wine identity layer (Phase 1) — server-side catalog +
  fuzzy-match "same wine?" prompt routes cross-user features through one id.
- Private groups with shared wine lists and ratings.
- Group tastings v2 — upcoming / active / concluded lifecycle, inline
  rating, recap, share cards, and realtime sync across attendees.
- Taste-match — confidence-tiered match-%, taste compass (Style-DNA axes),
  and shared-bottles, gated for Pro on friend profiles.
- Wine Moments — journal entity decoupled from ratings, with companions,
  shared moments, and a mosaic / bento UI.
- Stats — unified average rating across personal / group / tasting, plus
  top-regions visualisations.
- Wine vs. wine compare.
- Internationalisation — 7 locales (en, de, es, it, fr, pt, nl).
- Deep links (`io.sippd://`) and `https://sippd.xyz` universal links.
- Push notifications via Firebase Cloud Messaging.
- Paywall infrastructure (analytics + RevenueCat + group gate).

### Security

- 2026-05 security baseline: pre-prod data wipe, Supabase migrations squashed
  to a clean 3-file baseline, two-pass RLS audit, secret rotation, text-column
  input caps, and MIME / size caps on storage buckets.
- Local cache reads scoped to the current authenticated uid (#106).
- gitleaks runs as a pre-commit hook and a CI workflow; Dependabot opens
  weekly dependency PRs.

[Unreleased]: https://github.com/martin-dehlan/sippd/compare/v0.1.23...HEAD
[0.1.23+30]: https://github.com/martin-dehlan/sippd/releases/tag/v0.1.23

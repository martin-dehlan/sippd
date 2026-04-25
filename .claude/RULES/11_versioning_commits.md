# Versioning, Commits & Branches

**TL;DR:** Semver `MAJOR.MINOR.PATCH+BUILD`. Conventional Commits. Feature work on `feat/<name>` branches with PR. Trivial fixes direct to `main`. Push after every commit.

---

## Version policy

Pattern: `MAJOR.MINOR.PATCH+BUILD` in `pubspec.yaml`.

| Bump | When |
|------|------|
| MAJOR | Breaking changes. First prod release with paywall = `1.0.0`. |
| MINOR | New feature batch (paywall sprint = `0.2.0`, share-cards = `0.3.0`, etc). |
| PATCH | Bug fixes within a version, no new features. |
| BUILD | `+1` per store upload (TestFlight / Play Internal). Always increment. |

Bump version only when the feature batch is **shipped to a store**, not at the start of work.

---

## Conventional Commits

Format: `type(scope): subject`

| Type | When |
|------|------|
| `feat` | New functionality. |
| `fix` | Bug fix. |
| `refactor` | Code change, no behavior change. |
| `chore` | Build, deps, tooling. |
| `docs` | Docs / comments only. |
| `style` | Formatting / visual tweaks (no logic). |
| `test` | Test changes only. |

Rules:
- Subject ≤ 60 chars, lowercase, no trailing period.
- Imperative voice ("add x", not "added x" / "adds x").
- Scope = feature dir or area (`auth`, `wines`, `analytics`, `paywall`, `android`, `router`).

---

## Commit cadence

- One logical change per commit. No big dumps.
- Group related file edits when they form one concept (e.g. controller + its codegen + its UI consumer).
- Don't mix unrelated changes in one commit. Separate concerns = separate commits.

---

## Branch & PR flow

Public OSS — keep history visible and reviewable.

| Change kind | Where |
|-------------|-------|
| Feature work | `feat/<short-name>` branch → PR |
| Bug fix that needs review | `fix/<short-name>` branch → PR |
| Trivial fix (typo, dep bump, single-line) | direct to `main` |
| Docs / policy update | `docs/<short-name>` branch → PR |

PR rules:
- One self-contained concept per PR.
- Title = the merge commit message after squash (Conventional Commits format).
- Body = summary + test plan.
- Squash-merge to keep `main` linear and readable.

---

## Pre-push checklist

Before `git push`:
1. `flutter analyze` — no new errors (info-level pre-existing OK).
2. `dart run build_runner build --delete-conflicting-outputs` — succeeds if any annotated files changed.
3. Manual smoke test of the changed flow on simulator/device.
4. Commit message follows Conventional Commits.

---

## Push policy

- Push after every commit. Don't accumulate local commits — keeps remote in sync, easier to revert.
- Never `--force` to `main`.
- Never skip hooks (`--no-verify`).

---

## Current sprint

- Phase 2a — paywall infrastructure (analytics + RevenueCat + group-gate).
- Bumps to `0.2.0` only when first store-upload of paywall ships.

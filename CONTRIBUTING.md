# Contributing to Sippd

Thanks for considering a contribution. Sippd is a small project with a
single maintainer, but contributions are welcome. This guide describes how
to file issues, propose changes, and what an acceptable contribution looks
like.

## Code of Conduct

Be respectful and constructive. Harassment, discrimination, or abusive
behaviour is not tolerated. Report conduct concerns to `contact@sippd.xyz`.

## Reporting issues

- **Security vulnerabilities** — do **not** open a public issue. Follow
  [SECURITY.md](./SECURITY.md) and email `security@sippd.xyz`.
- **Bugs** — open a GitHub issue with steps to reproduce, expected vs.
  actual behaviour, your device / OS, and the app version (`Settings → About`
  or `pubspec.yaml` `version:`).
- **Feature requests** — open an issue describing the user need. Acceptance
  is judged on user value and roadmap fit.

## Proposing changes

1. Fork the repo and create a topic branch from `main`. Branch naming follows
   [`RULES/11`](./.claude/RULES/11_versioning_commits.md):
   - `feat/<short-name>` for features
   - `fix/<short-name>` for bug fixes that need review
   - `docs/<short-name>` for documentation
   - Trivial fixes (typo, single-line, dep bump) may go straight to `main`.
2. Make your change following the conventions below.
3. Add or update tests (see **Testing policy**).
4. Run the local checks (see below).
5. Open a pull request against `main`. Reference any related issue, describe
   the change and the reasoning, and fill in the PR template checklist.
6. The maintainer reviews and **squash-merges** to keep `main` linear.

## Conventions

Sippd has a documented convention set under [`CLAUDE.md`](./CLAUDE.md) and
[`.claude/RULES/`](./.claude/RULES/). The essentials:

- **Architecture** — `Domain (pure Dart) → Data → Controller (Riverpod) →
  Presentation`. Domain is pure Dart (no Flutter / Riverpod imports). See
  [`RULES/01`](./.claude/RULES/01_core_architecture.md).
- **Feature-first layout** — each feature is self-contained under
  `lib/features/<feature>/{domain,data,controller,presentation}`.
- **File naming** — `name.type.dart` (e.g. `wine.model.dart`). See
  [`RULES/02`](./.claude/RULES/02_file_naming_conventions.md).
- **State** — Riverpod with code-gen (`@riverpod`); all providers for a
  feature in one `feature.provider.dart`. See
  [`RULES/05`](./.claude/RULES/05_riverpod_patterns.md).
- **Responsive UI** — no fixed spacing/font sizes; derive from `MediaQuery`.
  See [`RULES/03`](./.claude/RULES/03_responsive_ui_rules.md).
- **Errors** — funnel through `AppError`; `AsyncValue.guard` in controllers.
  See [`RULES/07`](./.claude/RULES/07_error_handling.md).
- **Comments and identifiers in English.** User-facing strings go through
  the ARB localisation files in `lib/l10n/`.

### Commit messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short summary
```

- `type` ∈ `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`, `ci`.
- Subject ≤ 60 chars, lowercase, imperative ("add x", not "added x"), no
  trailing period.
- `scope` is the feature dir or area (`wines`, `auth`, `groups`, `tastings`,
  `paywall`, `android`, `router`).
- Use the body for the *why* when it isn't obvious from the diff.

We encourage signing off your commits with `git commit -s` (adds a
`Signed-off-by:` line, [DCO](https://developercertificate.org/) style) to
assert you have the right to submit the contribution. It's not enforced by a
bot today, but it's appreciated.

## Local setup and checks

```bash
# One-time: install the git hooks (gitleaks pre-commit, untracked-dart pre-push)
bash scripts/install-git-hooks.sh

# Install dependencies
flutter pub get          # Flutter SDK 3.41.x / Dart 3.x

# Generate code after touching any annotated source (Freezed/Riverpod/Drift)
dart run build_runner build --delete-conflicting-outputs

# Before opening a PR — the same checks CI runs:
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

If you change the Drift schema or Supabase migrations, bump `schemaVersion`
and add a `MigrationStrategy` (see
[`RULES/04`](./.claude/RULES/04_drift_database_rules.md)).

## Testing policy

Every pull request that adds user-visible behaviour or a new repository /
use-case method **must include at least one widget or unit test exercising
the new path**. Bug fixes **must include a regression test** that fails before
the fix and passes after. PRs that don't meet this bar are sent back unless
the reviewer explicitly waives it (with a reason recorded in the PR body).

The full test strategy — the UC-driven widget tests, the per-flow
integration tests, and what manual smoke testing covers — is in
[`.claude/RULES/10_testing_rules.md`](./.claude/RULES/10_testing_rules.md).

Tests run automatically on every push and PR via
[`.github/workflows/ci.yml`](./.github/workflows/ci.yml) (`flutter test`,
`flutter analyze`, format check, codegen-sync check).

## Pull request requirements

- The description explains the change and links any related issue.
- The PR-template checklist is filled in (including the tests box).
- All CI checks pass (format, analyze, codegen-sync, test, secret scan).
- The maintainer reviews before merge; PRs are squash-merged.

## License

By contributing, you agree that your contributions are licensed under the
[Apache License 2.0](./LICENSE). The Sippd brand is not covered by that
license — see [TRADEMARKS.md](./TRADEMARKS.md).

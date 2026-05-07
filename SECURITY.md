# Security policy

Sippd is a small-team project, but security reports get the same
priority as any production bug. Thank you for taking the time to
report responsibly.

## Reporting a vulnerability

If you believe you've found a security issue — anything from RLS
bypass on the Supabase backend to a credential leak in the app
binary, a deep-link hijack vector, or unsafe handling of user
content — please **do not open a public GitHub issue**.

Email the details to **security@sippd.xyz**. Please include:

- A clear description of the issue and the affected component
  (Flutter app, Supabase migration / RPC, share-card flow, etc.)
- Reproduction steps with concrete inputs where applicable
- The version / commit you tested against
- Optionally, a suggested fix or mitigation

You'll get an acknowledgement within **3 business days**. We'll
follow up with a triage outcome (accepted / not-a-vuln / duplicate)
and a rough timeline for the fix. Coordinated disclosure is
preferred — we'll work with you on a public-disclosure date once a
fix has shipped.

## Scope

In scope:

- The mobile app source under `lib/`
- Supabase migrations, RLS policies, and SECURITY DEFINER RPCs
  under `supabase/migrations/`
- The deep-link / universal-link surface
- Auth, account-deletion, and data-export flows

Out of scope:

- Vulnerabilities in third-party services we depend on (Supabase,
  Firebase, RevenueCat, PostHog, Apple/Google sign-in). Please
  report those upstream.
- Issues that require physical device access or root/jailbreak
- Social-engineering of operators
- Theoretical brute-force attacks on rate-limited endpoints

## Recognition

We don't run a bounty programme yet, but we're happy to credit
researchers in release notes and follow up with a thank-you. If
that's something you'd like, mention it in the report.

# Roadmap Moderation Runbook

Community feature requests (sippd.xyz/roadmap) are **gated**: every submission lands
`moderation_status = 'pending'` and is invisible to the public until approved.
v1 moderation is manual via the Supabase dashboard (SQL editor) running as the
service role, which bypasses RLS.

Schema: `supabase/migrations/20260605120000_feature_requests_board.sql` +
`20260605130000_feature_requests_moderation.sql`.

## Visibility model

| moderation_status | Public board | Submitter | Votable |
|-------------------|:------------:|:---------:|:-------:|
| `pending`         | hidden       | sees own  | no      |
| `approved`        | shown        | sees own  | yes     |
| `rejected`        | hidden       | sees own  | no      |

`status` (`open`/`planned`/`in_progress`/`shipped`) is the **roadmap lifecycle** and
only matters once a row is `approved`. A fresh approval defaults to `status='open'`
(backlog / vote list); move it onto the timeline by setting `planned` etc.

## Queue: what's waiting

```sql
select id, title, body, author_id, created_at
from public.feature_requests
where moderation_status = 'pending'
order by created_at;
```

## Approve

```sql
update public.feature_requests
set moderation_status = 'approved'
where id = '<request-uuid>';
```

## Reject (hide, keep for audit)

```sql
update public.feature_requests
set moderation_status = 'rejected'
where id = '<request-uuid>';
```

## Move an approved idea along the roadmap

```sql
update public.feature_requests
set status = 'planned'   -- or 'in_progress' | 'shipped'
where id = '<request-uuid>'
  and moderation_status = 'approved';
```

## Hard delete (spam / abuse)

```sql
delete from public.feature_requests where id = '<request-uuid>';
-- votes cascade away automatically
```

## Guardrails already enforced by the DB

- Title 3–120 chars, not whitespace-only; body ≤ 2000 chars (CHECK constraints).
- One submission per author per trailing 24h (BEFORE INSERT trigger
  `feature_requests_rate_limit`).
- Votes only on `approved` requests; one vote per user per request.
- RLS: a row is readable only if `approved` OR `author_id = auth.uid()`.

## Promote schema to prod

Dev (`dfxiixccxxvjarnbloyx`) first, verify, then prod (`ungvhpffjhnojessifri`):

```bash
supabase db push   # CLI is linked to prod
```

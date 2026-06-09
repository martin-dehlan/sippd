-- get_unseen_badges didn't return current/target, so the unlock celebration
-- couldn't show the "N / N" the user just completed (e.g. First Sip 1/1).
-- An unseen badge is always earned, so current = target = the criterion gte.

create or replace function public.get_unseen_badges()
returns jsonb
language sql
stable security definer
set search_path = public
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
    'badge_id', d.id, 'category', d.category, 'tier', d.tier,
    'title', d.title, 'description', d.description, 'icon', d.icon,
    'earned', true,
    'current', (d.criterion ->> 'gte')::int,
    'target', (d.criterion ->> 'gte')::int,
    'earned_at', ub.earned_at
  ) order by ub.earned_at), '[]'::jsonb)
  from public.user_badges ub
  join public.badge_definitions d on d.id = ub.badge_id
  where ub.user_id = auth.uid() and ub.seen_at is null and d.is_active;
$$;

grant execute on function public.get_unseen_badges() to authenticated;

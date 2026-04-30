-- Tier 3 manual merge. Collapses two canonical_wine rows into one
-- by repointing every wines row from the loser canonical onto the
-- winner. Wipes match decisions referencing the loser so callers
-- don't end up with orphan "different" verdicts against a canonical
-- that no longer exists. Loser row is deleted at the end.
--
-- Authorization: caller must own at least one wines row pointing at
-- either canonical, so a random user can't reshape strangers'
-- collections. SECURITY DEFINER because the wines update + canonical
-- delete need elevated privileges to bypass RLS write paths.

create or replace function public.merge_canonical_wines(
  p_loser_id  uuid,
  p_winner_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_caller uuid := auth.uid();
begin
  if v_caller is null then
    raise exception 'auth required';
  end if;
  if p_loser_id = p_winner_id then
    raise exception 'cannot merge a canonical with itself';
  end if;
  if not exists (select 1 from public.canonical_wine where id = p_loser_id) then
    raise exception 'loser canonical not found';
  end if;
  if not exists (select 1 from public.canonical_wine where id = p_winner_id) then
    raise exception 'winner canonical not found';
  end if;
  if not exists (
    select 1 from public.wines
    where canonical_wine_id in (p_loser_id, p_winner_id)
      and user_id = v_caller
  ) then
    raise exception 'caller has no wine pointing at either canonical';
  end if;

  -- Repoint every wines row from loser to winner. Group / tasting /
  -- ratings rows reference wines.id, so updating the FK on wines is
  -- enough — ratings view recomputes against the new canonical.
  update public.wines
     set canonical_wine_id = p_winner_id
   where canonical_wine_id = p_loser_id;

  -- Drop any decisions tied to the loser. Re-prompting against the
  -- winner is cleaner than dragging stale "different" verdicts onto
  -- the merged identity.
  delete from public.canonical_wine_match_decisions
   where candidate_canonical_id = p_loser_id;

  delete from public.canonical_wine where id = p_loser_id;
end;
$$;

grant execute on function public.merge_canonical_wines(uuid, uuid) to authenticated;

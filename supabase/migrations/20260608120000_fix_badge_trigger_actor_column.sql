-- FIX (critical): tg_evaluate_badges_for_actor referenced NEW.created_by,
-- which throws `record "new" has no field "created_by"` on every table that
-- only has user_id (wines, group_wine_ratings, tasting_ratings). PL/pgSQL
-- errors on a missing record field even inside coalesce, so this broke ALL
-- inserts/updates on those tables — e.g. no wine could sync to the server.
--
-- Read the actor through to_jsonb(NEW) so a column that doesn't exist on the
-- triggering table yields null instead of a hard error.

create or replace function public.tg_evaluate_badges_for_actor()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor uuid;
begin
  v_actor := coalesce(
    (to_jsonb(NEW) ->> 'user_id')::uuid,
    (to_jsonb(NEW) ->> 'created_by')::uuid
  );
  if v_actor is not null then
    -- Cheap: evaluate only inserts badges the user doesn't already have.
    perform public.evaluate_user_badges(v_actor);
  end if;
  return NEW;
end;
$$;

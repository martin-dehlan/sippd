-- Make the badge trigger fail-safe: badge evaluation runs on every wine /
-- rating insert+update, so if evaluate_user_badges ever throws on some edge
-- case it would break the underlying write (the app's core action) for all
-- users. Swallow any error inside the trigger so the write always succeeds —
-- worst case badges silently don't update, never "can't add a wine".

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
    begin
      perform public.evaluate_user_badges(v_actor);
    exception
      when others then
        -- Never let badge evaluation break the underlying insert/update.
        null;
    end;
  end if;
  return NEW;
end;
$$;

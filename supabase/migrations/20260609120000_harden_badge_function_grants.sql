-- Advisor follow-up: lock down SECURITY DEFINER functions left PUBLIC-executable.
-- _badge_metrics has no auth.uid() gate, so PUBLIC execute leaked any user's
-- aggregate metrics — revoke it (called only internally by the definer-owned
-- evaluate/progress functions). User-facing ones keep their authenticated grant;
-- drop the PUBLIC default so anon can't call them.
revoke all on function public._badge_metrics(uuid) from public;
revoke all on function public.tg_evaluate_badges_for_actor() from public;
revoke all on function public.evaluate_my_badges() from public;
revoke all on function public.get_unseen_badges() from public;
revoke all on function public.get_user_badge_progress(uuid) from public;
revoke all on function public.mark_badges_seen(text[]) from public;

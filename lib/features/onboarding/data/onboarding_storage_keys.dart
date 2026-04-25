/// SharedPreferences keys for the pre-auth onboarding buffer.
///
/// Lives in its own file so the auth feature can import the keys to clear
/// the buffer on sign-out without creating a circular dependency between
/// the auth and onboarding controllers.
const String onboardingSeenKey = 'onboarding_seen';
const String onboardingAnswersKey = 'onboarding_answers';
const String onboardingProfileSeedPendingKey =
    'onboarding_profile_seed_pending';

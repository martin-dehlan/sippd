// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsLoadError => 'Couldn\'t load notification settings';

  @override
  String get sectionTastings => 'Tastings';

  @override
  String get sectionFriends => 'Friends';

  @override
  String get sectionGroups => 'Groups';

  @override
  String get tileTastingRemindersLabel => 'Tasting reminders';

  @override
  String get tileTastingRemindersSubtitle => 'Push before a tasting starts';

  @override
  String get tileFriendActivityLabel => 'Friend activity';

  @override
  String get tileFriendActivitySubtitle => 'Requests and acceptances';

  @override
  String get tileGroupActivityLabel => 'Group activity';

  @override
  String get tileGroupActivitySubtitle => 'Invites, joins and new tastings';

  @override
  String get tileGroupWineSharedLabel => 'New wine shared';

  @override
  String get tileGroupWineSharedSubtitle =>
      'When a friend adds a wine to your group';

  @override
  String get hoursPickerLabel => 'Notify me before';

  @override
  String get hoursPickerHint =>
      'Applies to all upcoming tastings — change anytime.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Language';

  @override
  String get languageSheetTitle => 'Choose language';

  @override
  String get languageOptionSystem => 'System default';

  @override
  String get onbWelcomeTitle => 'Your wine\nmoments.';

  @override
  String get onbWelcomeBody =>
      'Rate the wines you love. Remember them forever. Taste alongside friends.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get onbWelcomeSignIn => 'Sign in';

  @override
  String get onbWhyEyebrow => 'Why Sippd';

  @override
  String get onbWhyTitle => 'Built for people\nwho actually drink wine.';

  @override
  String get onbWhyPrinciple1Headline => 'Snap. Rate. Remember.';

  @override
  String get onbWhyPrinciple1Line => 'Three taps, find it next year.';

  @override
  String get onbWhyPrinciple2Headline => 'Tastings with friends.';

  @override
  String get onbWhyPrinciple2Line =>
      'Blind pours, pooled scores. No spreadsheets.';

  @override
  String get onbWhyPrinciple3Headline => 'Works offline.';

  @override
  String get onbWhyPrinciple3Line => 'Log anywhere. Syncs when you\'re home.';

  @override
  String get onbLevelEyebrow => 'About you';

  @override
  String get onbLevelTitle => 'How deep are you\ninto wine?';

  @override
  String get onbLevelSubtitle =>
      'No wrong answer. We\'ll tune suggestions and keep things your pace.';

  @override
  String get onbLevelBeginnerLabel => 'Beginner';

  @override
  String get onbLevelBeginnerSubtitle => 'Just starting out';

  @override
  String get onbLevelCuriousLabel => 'Curious';

  @override
  String get onbLevelCuriousSubtitle => 'A few favorites';

  @override
  String get onbLevelEnthusiastLabel => 'Enthusiast';

  @override
  String get onbLevelEnthusiastSubtitle => 'I know what I like';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Somm-level';

  @override
  String get onbFreqEyebrow => 'Your rhythm';

  @override
  String get onbFreqTitle => 'How often\ndo you open a bottle?';

  @override
  String get onbFreqWeekly => 'Weekly';

  @override
  String get onbFreqMonthly => 'A few times a month';

  @override
  String get onbFreqRare => 'Now and then';

  @override
  String get onbGoalsEyebrow => 'Your goals';

  @override
  String get onbGoalsTitle => 'What do you\nwant from Sippd?';

  @override
  String get onbGoalsSubtitle => 'Pick one or more. You can change this later.';

  @override
  String get onbGoalRemember => 'Remember bottles I love';

  @override
  String get onbGoalDiscover => 'Discover new styles';

  @override
  String get onbGoalSocial => 'Taste with friends';

  @override
  String get onbGoalValue => 'Track what I pay';

  @override
  String get onbStylesEyebrow => 'Your styles';

  @override
  String get onbStylesTitle => 'What do you\nreach for?';

  @override
  String get onbStylesSubtitle =>
      'Pick any that feel like you. We\'ll keep an eye on your picks.';

  @override
  String get wineTypeRed => 'Red';

  @override
  String get wineTypeWhite => 'White';

  @override
  String get wineTypeRose => 'Rosé';

  @override
  String get wineTypeSparkling => 'Sparkling';

  @override
  String get onbRespEyebrow => 'A note from us';

  @override
  String get onbRespTitle => 'Drink less,\ntaste more.';

  @override
  String get onbRespSubtitle =>
      'Sippd is for remembering and rating wines you\'ve enjoyed — not pressure to drink more. We don\'t do streaks or daily quotas, on purpose.';

  @override
  String get onbRespHelpBody =>
      'If alcohol is hurting you or someone close,\nfree confidential help is available.';

  @override
  String get onbRespHelpCta => 'Find help';

  @override
  String get onbNameEyebrow => 'Almost there';

  @override
  String get onbNameTitle => 'What should we\ncall you?';

  @override
  String get onbNameSubtitle =>
      'First name, nickname — whatever fits. Pick an icon too.';

  @override
  String get onbNameHint => 'Your name';

  @override
  String get onbNameIconLabel => 'Pick your icon';

  @override
  String get onbNameIconSubtitle => 'Shows up as your avatar.';

  @override
  String get onbNotifEyebrow => 'Stay in the loop';

  @override
  String get onbNotifTitle => 'Never lose a great\nbottle again.';

  @override
  String get onbNotifSubtitle =>
      'We\'ll nudge you when friends start tastings or invite you to groups. You can turn this off anytime.';

  @override
  String get onbNotifPreview =>
      'Tasting invites\nGroup ratings\nFriend activity';

  @override
  String get onbNotifTurnOn => 'Turn on notifications';

  @override
  String get onbNotifNotNow => 'Not now';

  @override
  String get onbLoaderAlmostThere => 'ALMOST THERE';

  @override
  String get onbLoaderCrafting => 'Crafting your profile.';

  @override
  String get onbLoaderAllSet => 'All set.';

  @override
  String get onbLoaderStepMatching => 'Matching your taste';

  @override
  String get onbLoaderStepCurating => 'Curating your styles';

  @override
  String get onbLoaderStepSetting => 'Setting up your journal';

  @override
  String get onbLoaderSeeProfile => 'See your profile';

  @override
  String get onbLoaderContinue => 'Continue';

  @override
  String get onbResultsEyebrow => 'YOUR TASTE PROFILE';

  @override
  String get onbResultsLevelCard => 'Level';

  @override
  String get onbResultsFreqCard => 'Frequency';

  @override
  String get onbResultsStylesCard => 'Styles';

  @override
  String get onbResultsGoalsCard => 'Goals';

  @override
  String get onbArchSommTitle => 'Seasoned Somm';

  @override
  String get onbArchSommSubtitle =>
      'You know your terroir. Sippd keeps the receipts.';

  @override
  String get onbArchPalateTitle => 'Sharp Palate';

  @override
  String get onbArchPalateSubtitle =>
      'Nuance-chaser. Sippd captures the detail.';

  @override
  String get onbArchRegularTitle => 'Cellar Regular';

  @override
  String get onbArchRegularSubtitle =>
      'A bottle a week, opinions sharper every month.';

  @override
  String get onbArchDevotedTitle => 'Devoted Taster';

  @override
  String get onbArchDevotedSubtitle =>
      'Serious about each pour. Sippd keeps your notes.';

  @override
  String get onbArchRedTitle => 'Red Loyalist';

  @override
  String get onbArchRedSubtitle =>
      'One grape per glass. We\'ll help you branch out.';

  @override
  String get onbArchBubbleTitle => 'Bubble Chaser';

  @override
  String get onbArchBubbleSubtitle =>
      'Bubbles over everything. Sippd tracks the good ones.';

  @override
  String get onbArchOpenTitle => 'Open Palate';

  @override
  String get onbArchOpenSubtitle =>
      'Red, white, pink, sparkling — all welcome. Log them all.';

  @override
  String get onbArchSteadyTitle => 'Steady Sipper';

  @override
  String get onbArchSteadySubtitle =>
      'Wine stays in the rotation. Sippd keeps the thread.';

  @override
  String get onbArchNowAndThenTitle => 'Now-and-Then Taster';

  @override
  String get onbArchNowAndThenSubtitle => 'Wine for the moments that matter.';

  @override
  String get onbArchOccasionalTitle => 'Occasional Glass';

  @override
  String get onbArchOccasionalSubtitle => 'Rare pour, worth remembering.';

  @override
  String get onbArchFreshTitle => 'Fresh Palate';

  @override
  String get onbArchFreshSubtitle =>
      'New journey. Every bottle counts from here.';

  @override
  String get onbArchCuriousTitle => 'Wine Curious';

  @override
  String get onbArchCuriousSubtitle =>
      'Tell us more and your profile sharpens.';

  @override
  String get onbCtaGetStarted => 'Get started';

  @override
  String get onbCtaIUnderstand => 'I understand';

  @override
  String get onbCtaContinue => 'Continue';

  @override
  String get onbCtaSignInToSave => 'Sign in to save it';

  @override
  String get onbCtaSaveAndContinue => 'Save and continue';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Level';

  @override
  String get tasteEditorFreq => 'How often';

  @override
  String get tasteEditorStyles => 'Favourite styles';

  @override
  String get tasteEditorGoals => 'What you\'re after';

  @override
  String get tasteEditorFreqWeekly => 'Weekly';

  @override
  String get tasteEditorFreqMonthly => 'Monthly';

  @override
  String get tasteEditorFreqRare => 'Rarely';

  @override
  String get tasteEditorGoalRemember => 'Remember';

  @override
  String get tasteEditorGoalDiscover => 'Discover';

  @override
  String get tasteEditorGoalSocial => 'Social';

  @override
  String get tasteEditorGoalValue => 'Value';

  @override
  String get authLoginWelcomeBack => 'Welcome back';

  @override
  String get authLoginCreateAccount => 'Create your account';

  @override
  String get authLoginDisplayNameLabel => 'Display Name';

  @override
  String get authLoginEmailLabel => 'Email';

  @override
  String get authLoginPasswordLabel => 'Password';

  @override
  String get authLoginConfirmPasswordLabel => 'Confirm Password';

  @override
  String get authLoginDisplayNameMin => 'Min 2 characters';

  @override
  String get authLoginDisplayNameMax => 'Max 30 characters';

  @override
  String get authLoginEmailInvalid => 'Valid email required';

  @override
  String get authLoginPasswordMin => 'Min 8 characters';

  @override
  String get authLoginPasswordRequired => 'Enter password';

  @override
  String get authLoginPasswordsDontMatch => 'Passwords don\'t match';

  @override
  String get authLoginForgotPassword => 'Forgot password?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Enter a valid email above first.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Couldn\'t create account. Try again.';

  @override
  String get authLoginSignInFailedFallback =>
      'Sign-in failed. Check your details.';

  @override
  String get authLoginCreateAccountButton => 'Create Account';

  @override
  String get authLoginSignInButton => 'Sign In';

  @override
  String get authLoginToggleHaveAccount => 'Already have an account? Sign In';

  @override
  String get authLoginToggleNoAccount => 'Don\'t have an account? Sign Up';

  @override
  String get authOrDivider => 'or';

  @override
  String get authGoogleContinue => 'Continue with Google';

  @override
  String get authGoogleFailed => 'Google sign-in failed. Please try again.';

  @override
  String get authConfTitleReset => 'Reset link sent';

  @override
  String get authConfTitleSignup => 'Check your inbox';

  @override
  String get authConfIntroReset => 'We sent a password reset link to';

  @override
  String get authConfIntroSignup => 'We sent a confirmation link to';

  @override
  String get authConfOutroReset => '.\nTap it to set a new password.';

  @override
  String get authConfOutroSignup => '.\nTap it to activate your account.';

  @override
  String get authConfOpenMailApp => 'Open mail app';

  @override
  String get authConfResendEmail => 'Resend email';

  @override
  String get authConfResendSending => 'Sending…';

  @override
  String authConfResendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'Email sent.';

  @override
  String get authConfResendFailedFallback =>
      'Couldn\'t send. Try again in a moment.';

  @override
  String get authConfBackToSignIn => 'Back to sign in';

  @override
  String get authResetTitle => 'Set a new password';

  @override
  String get authResetSubtitle => 'Choose a password you haven\'t used before.';

  @override
  String get authResetNewPasswordLabel => 'New password';

  @override
  String get authResetConfirmPasswordLabel => 'Confirm password';

  @override
  String get authResetPasswordMin => 'Min 6 characters';

  @override
  String get authResetPasswordsDontMatch => 'Passwords do not match';

  @override
  String get authResetFailedFallback => 'Couldn\'t update password. Try again.';

  @override
  String get authResetUpdateButton => 'Update password';

  @override
  String get authResetUpdatedSnack => 'Password updated.';

  @override
  String get authProfileGuest => 'Guest';

  @override
  String get authProfileSectionAccount => 'Account';

  @override
  String get authProfileSectionSupport => 'Support';

  @override
  String get authProfileSectionLegal => 'Legal';

  @override
  String get authProfileEditProfile => 'Edit profile';

  @override
  String get authProfileFriends => 'Friends';

  @override
  String get authProfileNotifications => 'Notifications';

  @override
  String get authProfileCleanupDuplicates => 'Clean up duplicates';

  @override
  String get authProfileSubscription => 'Subscription';

  @override
  String get authProfileChangePassword => 'Change password';

  @override
  String get authProfileContactUs => 'Contact us';

  @override
  String get authProfileRateSippd => 'Rate Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Privacy Policy';

  @override
  String get authProfileTermsOfService => 'Terms of Service';

  @override
  String get authProfileSignOut => 'Sign Out';

  @override
  String get authProfileSignIn => 'Sign In';

  @override
  String get authProfileDeleteAccount => 'Delete account';

  @override
  String get authProfileViewFullStats => 'View full stats';

  @override
  String get authProfileChangePasswordDialogTitle => 'Change password?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'We\'ll send a password reset link to $email. Tap it from your inbox to set a new password.';
  }

  @override
  String get authProfileCancel => 'Cancel';

  @override
  String get authProfileSendLink => 'Send link';

  @override
  String get authProfileSendLinkFailedTitle => 'Couldn\'t send link';

  @override
  String get authProfileSendLinkFailedFallback => 'Try again in a moment.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'Could not open $url';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Delete account?';

  @override
  String get authProfileDeleteDialogBody =>
      'This permanently deletes your profile, wines, ratings, tastings, group memberships and friends. Cannot be undone.';

  @override
  String get authProfileDeleteTypeConfirm => 'Type DELETE to confirm:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Delete';

  @override
  String get authProfileDeleteFailedFallback => 'Delete failed.';

  @override
  String get winesListSubtitle => 'Your wine rankings';

  @override
  String get winesListSortRating => 'Sort: rating';

  @override
  String get winesListSortRecent => 'Sort: recent';

  @override
  String get winesListSortName => 'Sort: name';

  @override
  String get winesListTooltipStats => 'Your stats';

  @override
  String get winesListTooltipAddWine => 'Add wine';

  @override
  String get winesListErrorLoad => 'Couldn\'t load wines';

  @override
  String get winesEmptyTitle => 'No wines yet';

  @override
  String get winesEmptyFilteredTitle => 'No wines match filter';

  @override
  String get winesEmptyFilteredBody => 'Try a different filter';

  @override
  String get winesEmptyAddWineCta => 'Add wine';

  @override
  String get winesAddSaveLabel => 'Save wine';

  @override
  String get winesAddDiscardTitle => 'Discard new wine?';

  @override
  String get winesAddDiscardBody =>
      'You haven\'t saved this wine yet. Leaving now will discard your changes.';

  @override
  String get winesAddDiscardKeepEditing => 'Keep editing';

  @override
  String get winesAddDiscardConfirm => 'Discard';

  @override
  String get winesAddDuplicateTitle => 'Looks like a duplicate';

  @override
  String winesAddDuplicateBody(String name) {
    return 'You already logged \"$name\" with the same vintage, winery and grape. Open the existing entry or add a new one anyway?';
  }

  @override
  String get winesAddDuplicateCancel => 'Cancel';

  @override
  String get winesAddDuplicateAddAnyway => 'Add anyway';

  @override
  String get winesAddDuplicateOpenExisting => 'Open existing';

  @override
  String get winesDetailNotFound => 'Wine not found';

  @override
  String get winesDetailErrorLoad => 'Couldn\'t load wine';

  @override
  String get winesDetailMenuCompare => 'Compare with…';

  @override
  String get winesDetailMenuShareRating => 'Share rating';

  @override
  String get winesDetailMenuShareToGroup => 'Share to group';

  @override
  String get winesDetailMenuEdit => 'Edit wine';

  @override
  String get winesDetailMenuTastingNotesPro => 'Tasting notes (Pro)';

  @override
  String get winesDetailMenuDelete => 'Delete wine';

  @override
  String get winesDetailStatRating => 'Rating';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Price';

  @override
  String get winesDetailStatRegion => 'Region';

  @override
  String get winesDetailStatCountry => 'Country';

  @override
  String get winesDetailSectionNotes => 'NOTES';

  @override
  String get winesDetailSectionPlace => 'PLACES';

  @override
  String get winesDetailPlaceEmpty => 'No place set';

  @override
  String get winesDetailDeleteTitle => 'Delete wine?';

  @override
  String get winesDetailDeleteBody => 'This cannot be undone.';

  @override
  String get winesDetailDeleteCancel => 'Cancel';

  @override
  String get winesDetailDeleteConfirm => 'Delete';

  @override
  String get winesEditErrorLoad => 'Couldn\'t load wine';

  @override
  String get winesEditErrorMemories => 'Couldn\'t load moments';

  @override
  String get winesEditNotFound => 'Wine not found';

  @override
  String get winesCleanupTitle => 'Clean up duplicates';

  @override
  String get winesCleanupErrorLoad => 'Couldn\'t load duplicates';

  @override
  String get winesCleanupEmptyTitle => 'No duplicates to clean up';

  @override
  String get winesCleanupEmptyBody =>
      'Your wines are tidy. We check for near-duplicate names and winery matches automatically.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% match';
  }

  @override
  String get winesCleanupKeepA => 'Keep A';

  @override
  String get winesCleanupKeepB => 'Keep B';

  @override
  String get winesCleanupSkippedSnack =>
      'Skipped for now — will reappear next visit.';

  @override
  String get winesCleanupDifferentWines => 'They\'re different wines';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'Merge into \"$name\"?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Every rating, group share, and stat that pointed at \"$loser\" will be moved over to \"$keeper\". This cannot be undone.';
  }

  @override
  String get winesCleanupMergeCancel => 'Cancel';

  @override
  String get winesCleanupMergeConfirm => 'Merge';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Merged into \"$name\".';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Merge failed.';

  @override
  String get winesCompareHeader => 'COMPARE';

  @override
  String get winesComparePickerSubtitle => 'Pick the second wine.';

  @override
  String get winesComparePickerEmptyTitle => 'No other wines yet';

  @override
  String get winesComparePickerEmptyBody =>
      'Add at least one more wine to compare.';

  @override
  String get winesComparePickerErrorFallback => 'Couldn\'t load wines.';

  @override
  String get winesCompareMissingSameWine => 'Pick a different wine to compare.';

  @override
  String get winesCompareMissingDefault => 'Couldn\'t load both wines.';

  @override
  String get winesCompareErrorFallback => 'Couldn\'t load wines.';

  @override
  String get winesCompareSectionAtAGlance => 'At a glance';

  @override
  String get winesCompareSectionTasting => 'Tasting profile';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Body, tannin, acidity, sweetness, oak, finish.';

  @override
  String get winesCompareSectionNotes => 'Notes';

  @override
  String get winesCompareAttrType => 'TYPE';

  @override
  String get winesCompareAttrVintage => 'VINTAGE';

  @override
  String get winesCompareAttrGrape => 'GRAPE';

  @override
  String get winesCompareAttrOrigin => 'ORIGIN';

  @override
  String get winesCompareAttrPrice => 'PRICE';

  @override
  String get winesCompareNotesEyebrow => 'NOTES';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'WINE $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'See body, tannin, acidity and more side by side.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Unlock with Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Add tasting notes from either wine to see them compared here.';

  @override
  String get winesFormHintName => 'Wine name';

  @override
  String get winesFormSubmitDefault => 'Save wine';

  @override
  String get winesFormPhotoLabel => 'Photo';

  @override
  String get winesFormPlaceMomentHint =>
      'Tip: the place auto-fills from the first moment you add with a location.';

  @override
  String get winesFormStatRating => 'Rating';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Price';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Region';

  @override
  String get winesFormStatCountry => 'Country';

  @override
  String get winesFormChipWinery => 'Winery';

  @override
  String get winesFormChipGrape => 'Grape';

  @override
  String get winesFormChipYear => 'Year';

  @override
  String get winesFormChipNotes => 'Notes';

  @override
  String get winesFormChipNotesFilled => 'Notes ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Tap to add place';

  @override
  String get winesFormWineryTitle => 'Winery';

  @override
  String get winesFormWineryHint => 'e.g. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Tasting notes';

  @override
  String get winesFormNotesHint => 'Aromas, body, finish…';

  @override
  String get winesFormTypeRed => 'Red';

  @override
  String get winesFormTypeWhite => 'White';

  @override
  String get winesFormTypeRose => 'Rosé';

  @override
  String get winesFormTypeSparkling => 'Sparkling';

  @override
  String get winesMemoriesHeader => 'Moments';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Moments ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Add';

  @override
  String get winesMemoriesRemoveTitle => 'Remove moment?';

  @override
  String get winesMemoriesRemoveBody =>
      'This will remove this moment from the wine.';

  @override
  String get winesMemoriesRemoveCancel => 'Cancel';

  @override
  String get winesMemoriesRemoveConfirm => 'Remove';

  @override
  String get momentSheetNewTitle => 'New moment';

  @override
  String get momentSheetEditTitle => 'Edit moment';

  @override
  String get momentFieldPhotos => 'Photos';

  @override
  String get momentFieldWhen => 'When';

  @override
  String get momentFieldOccasion => 'Occasion';

  @override
  String get momentFieldCompanions => 'With';

  @override
  String get momentFieldPlace => 'Where';

  @override
  String get momentFieldFood => 'Paired with';

  @override
  String get momentFieldNote => 'Note';

  @override
  String get momentFieldVisibility => 'Visibility';

  @override
  String get momentAddPhoto => 'Add photo';

  @override
  String get momentPhotoCap => 'Up to 10 photos';

  @override
  String get momentOccasionDinner => 'Dinner';

  @override
  String get momentOccasionDate => 'Date';

  @override
  String get momentOccasionCelebration => 'Celebration';

  @override
  String get momentOccasionTasting => 'Tasting';

  @override
  String get momentOccasionCasual => 'Casual';

  @override
  String get momentOccasionBirthday => 'Birthday';

  @override
  String get momentCompanionsAddFriend => 'Add friend';

  @override
  String get momentCompanionsEmpty => 'No friends to tag yet.';

  @override
  String get friendsProfileSharedMoments => 'Shared moments';

  @override
  String get winesShareToFriend => 'Share with friend';

  @override
  String winesShareSuccess(String name) {
    return 'Wine shared with $name';
  }

  @override
  String get winesShareError => 'Couldn\'t share — try again';

  @override
  String get winesSharePickFriendsTitle => 'Share with';

  @override
  String get winesExpertProUnlock => 'Unlock with Pro';

  @override
  String get momentShowcaseApplied => 'Set as wine\'s main photo.';

  @override
  String get momentShowcaseError => 'Couldn\'t set as main photo. Try again.';

  @override
  String get momentPlaceHint => 'Restaurant or place';

  @override
  String get momentFoodHint => 'What did you pair it with?';

  @override
  String get momentNoteHint => 'Anything to remember?';

  @override
  String get momentVisibilityFriends => 'Friends';

  @override
  String get momentVisibilityPrivate => 'Private';

  @override
  String get momentSave => 'Save moment';

  @override
  String get momentSaveError => 'Couldn\'t save moment';

  @override
  String get momentEdit => 'Edit';

  @override
  String get momentDelete => 'Delete';

  @override
  String get momentDeleteConfirmTitle => 'Delete moment?';

  @override
  String get momentDeleteConfirmBody =>
      'This permanently removes this moment and its photos.';

  @override
  String get momentUseAsShowcase => 'Use as showcase';

  @override
  String get momentTastingAdd => 'Add tasting moment';

  @override
  String get momentValidationEmpty => 'Add a photo or note to save';

  @override
  String get momentSectionHeader => 'Moments';

  @override
  String get momentSectionAdd => 'New';

  @override
  String get momentSectionEmpty => 'No moments yet — tap +.';

  @override
  String momentMetaWith(String names) {
    return 'With $names';
  }

  @override
  String get winesPhotoSourceTake => 'Take photo';

  @override
  String get winesPhotoSourceGallery => 'Choose from gallery';

  @override
  String get winesGrapeSheetTitle => 'Grape variety';

  @override
  String get winesGrapeSheetHint => 'e.g. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Use \"';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '\" as custom';

  @override
  String get winesGrapeSheetEmpty => 'No grapes available yet.';

  @override
  String get winesGrapeSheetErrorLoad => 'Couldn\'t load grape catalog.';

  @override
  String get winesGrapeSheetUseTyped => 'Use what I typed';

  @override
  String get winesRegionSheetTitle => 'Wine region';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Pick where in $country the wine comes from — or skip if you’re not sure.';
  }

  @override
  String get winesRegionSheetSkip => 'Skip';

  @override
  String get winesRegionSheetSearchHint => 'Search region...';

  @override
  String get winesRegionSheetClear => 'Clear region';

  @override
  String get winesRegionSheetOther => 'Other region…';

  @override
  String get winesRegionSheetOtherTitle => 'Region';

  @override
  String get winesRegionSheetOtherHint => 'e.g. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Search country...';

  @override
  String get winesCountrySheetTopHeader => 'Top Wine Countries';

  @override
  String get winesCountrySheetOtherHeader => 'Other Countries';

  @override
  String get winesRatingSheetSaveCta => 'Save rating';

  @override
  String get winesRatingSheetCancel => 'Cancel';

  @override
  String get winesRatingSheetSaveError => 'Could not save.';

  @override
  String get winesRatingHeaderLabel => 'YOUR RATING';

  @override
  String get winesRatingChipTasting => 'Tasting notes';

  @override
  String get winesRatingInputLabel => 'Rating';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Save the wine first — tasting notes attach to the canonical id.';

  @override
  String get winesExpertSheetTitle => 'Tasting notes';

  @override
  String get winesExpertSheetSubtitle => 'WSET-style perceptions';

  @override
  String get winesExpertSheetSave => 'Save';

  @override
  String get winesExpertAxisBody => 'Body';

  @override
  String get winesExpertAxisTannin => 'Tannin';

  @override
  String get winesExpertAxisAcidity => 'Acidity';

  @override
  String get winesExpertAxisSweetness => 'Sweetness';

  @override
  String get winesExpertAxisOak => 'Oak';

  @override
  String get winesExpertAxisFinish => 'Finish';

  @override
  String get winesExpertAxisAromas => 'Aromas';

  @override
  String get winesExpertBodyLow => 'light';

  @override
  String get winesExpertBodyHigh => 'full';

  @override
  String get winesExpertTanninLow => 'soft';

  @override
  String get winesExpertTanninHigh => 'gripping';

  @override
  String get winesExpertAcidityLow => 'soft';

  @override
  String get winesExpertAcidityHigh => 'crisp';

  @override
  String get winesExpertSweetnessLow => 'dry';

  @override
  String get winesExpertSweetnessHigh => 'sweet';

  @override
  String get winesExpertOakLow => 'unoaked';

  @override
  String get winesExpertOakHigh => 'heavy';

  @override
  String get winesExpertFinishShort => 'Short';

  @override
  String get winesExpertFinishMedium => 'Medium';

  @override
  String get winesExpertFinishLong => 'Long';

  @override
  String get winesExpertSummaryHeader => 'TASTING NOTES';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMAS';

  @override
  String get winesExpertSummaryAxisBody => 'BODY';

  @override
  String get winesExpertSummaryAxisTannin => 'TANNIN';

  @override
  String get winesExpertSummaryAxisAcidity => 'ACIDITY';

  @override
  String get winesExpertSummaryAxisSweetness => 'SWEETNESS';

  @override
  String get winesExpertSummaryAxisOak => 'OAK';

  @override
  String get winesExpertSummaryAxisFinish => 'FINISH';

  @override
  String get winesExpertDescriptorBody1 => 'very light';

  @override
  String get winesExpertDescriptorBody2 => 'light';

  @override
  String get winesExpertDescriptorBody3 => 'medium';

  @override
  String get winesExpertDescriptorBody4 => 'full';

  @override
  String get winesExpertDescriptorBody5 => 'heavy';

  @override
  String get winesExpertDescriptorTannin1 => 'silky';

  @override
  String get winesExpertDescriptorTannin2 => 'soft';

  @override
  String get winesExpertDescriptorTannin3 => 'medium';

  @override
  String get winesExpertDescriptorTannin4 => 'firm';

  @override
  String get winesExpertDescriptorTannin5 => 'gripping';

  @override
  String get winesExpertDescriptorAcidity1 => 'flat';

  @override
  String get winesExpertDescriptorAcidity2 => 'soft';

  @override
  String get winesExpertDescriptorAcidity3 => 'balanced';

  @override
  String get winesExpertDescriptorAcidity4 => 'crisp';

  @override
  String get winesExpertDescriptorAcidity5 => 'sharp';

  @override
  String get winesExpertDescriptorSweetness1 => 'bone dry';

  @override
  String get winesExpertDescriptorSweetness2 => 'dry';

  @override
  String get winesExpertDescriptorSweetness3 => 'off-dry';

  @override
  String get winesExpertDescriptorSweetness4 => 'sweet';

  @override
  String get winesExpertDescriptorSweetness5 => 'lush';

  @override
  String get winesExpertDescriptorOak1 => 'unoaked';

  @override
  String get winesExpertDescriptorOak2 => 'subtle';

  @override
  String get winesExpertDescriptorOak3 => 'present';

  @override
  String get winesExpertDescriptorOak4 => 'oak-forward';

  @override
  String get winesExpertDescriptorOak5 => 'heavy';

  @override
  String get winesExpertDescriptorFinish1 => 'short';

  @override
  String get winesExpertDescriptorFinish2 => 'medium';

  @override
  String get winesExpertDescriptorFinish3 => 'long';

  @override
  String get winesCanonicalPromptTitle => 'Same wine?';

  @override
  String get winesCanonicalPromptBody =>
      'Looks similar to a wine that\'s already in the catalog. Linking them keeps your stats and matches accurate.';

  @override
  String get winesCanonicalPromptInputLabel => 'What you\'re adding';

  @override
  String get winesCanonicalPromptExistingLabel => 'EXISTING IN CATALOG';

  @override
  String get winesCanonicalPromptDifferent => 'No, this is a different wine';

  @override
  String get winesFriendRatingsHeader => 'FRIENDS WHO RATED';

  @override
  String get winesFriendRatingsFallback => 'Friend';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count more';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'All';

  @override
  String get winesTypeFilterRed => 'Red';

  @override
  String get winesTypeFilterWhite => 'White';

  @override
  String get winesTypeFilterRose => 'Rosé';

  @override
  String get winesTypeFilterSparkling => 'Sparkling';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Your wine journey, visualised';

  @override
  String get winesStatsPreviewBadge => 'PREVIEW';

  @override
  String get winesStatsPreviewHint => 'What you’ll see after a few ratings.';

  @override
  String get winesStatsEmptyEyebrow => 'GET STARTED';

  @override
  String get winesStatsEmptyTitle => 'Your stats start with a rating';

  @override
  String get winesStatsEmptyBody =>
      'Rate your first wine to bring your taste, regions and value to life here.';

  @override
  String get winesStatsEmptyCta => 'Rate a wine';

  @override
  String get winesStatsHeroLabel => 'YOUR AVG';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'personal';

  @override
  String get winesStatsHeroChipGroup => 'group';

  @override
  String get winesStatsHeroChipTasting => 'tasting';

  @override
  String get winesStatsSectionTypeBreakdown => 'Wine type breakdown';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'How your taste splits across the four styles.';

  @override
  String get winesStatsSectionTopRated => 'Highest rated';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Your personal podium.';

  @override
  String get winesStatsSectionTimeline => 'Timeline';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Month by month, the wines that wrote your year.';

  @override
  String get winesStatsSectionPartners => 'Drinking partners';

  @override
  String get winesStatsSectionPartnersSubtitle => 'Who you taste with most.';

  @override
  String get winesStatsSectionPrices => 'Prices & value';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Sum of bottle prices logged on your rated wines — not actual consumption spend.';

  @override
  String get winesStatsSectionPlaces => 'Where you’ve drunk wine';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Every wine you logged with a place.';

  @override
  String get winesStatsSectionRegions => 'Top regions';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'Where most of your bottles come from.';

  @override
  String get winesStatsPartnersErrorTitle => 'Couldn\'t load partners';

  @override
  String get winesStatsPartnersErrorBody =>
      'Pull down or come back in a moment.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Rate together';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Once you and a friend rate the same wine in a group, they\'ll show up here.';

  @override
  String get winesStatsPartnersCta => 'Open groups';

  @override
  String get winesStatsPriceEmptyTitle => 'Add a price';

  @override
  String get winesStatsPriceEmptyBody =>
      'Log what you paid on a wine to unlock spend, average cost and best-value picks.';

  @override
  String get winesStatsPriceEmptyCta => 'Edit a wine';

  @override
  String get winesStatsPlacesEmptyTitle => 'Add a location';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Drop a pin on a wine to start mapping where you drink — bars, dinners, trips.';

  @override
  String get winesStatsPlacesEmptyCta => 'Edit a wine';

  @override
  String get winesStatsRegionsEmptyTitle => 'Add a region';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Tag wines with a region or country to see where your taste leans.';

  @override
  String get winesStatsRegionsEmptyCta => 'Edit a wine';

  @override
  String get winesStatsPartnersHint =>
      'Counts wines rated together inside shared groups.';

  @override
  String get winesStatsPartnersFallback => 'Wine friend';

  @override
  String get winesStatsSpendingLabel => 'RATED PORTFOLIO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count priced wines',
      one: '1 priced wine',
    );
    return 'across $_temp0 · avg $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Most expensive';

  @override
  String get winesStatsSpendingBestValue => 'Best value';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count more';
  }

  @override
  String get winesStatsProLockTitle => 'Unlock 3 more insights';

  @override
  String get winesStatsProLockBody =>
      'See where your bottles came from, what you spend, and which regions you back the most.';

  @override
  String get winesStatsProLockPillPrices => 'Prices';

  @override
  String get winesStatsProLockPillWhere => 'Where';

  @override
  String get winesStatsProLockPillRegions => 'Top regions';

  @override
  String get winesStatsProLockCta => 'Unlock with Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 earlier month';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count earlier months';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wines',
      one: '1 wine',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places',
      one: '1 place',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Close';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'wine';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'wines';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Most drunk';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Top rated';

  @override
  String get tastingCreateHeader => 'NEW TASTING';

  @override
  String get tastingEditHeader => 'EDIT TASTING';

  @override
  String get tastingFieldTitleLabel => 'Title';

  @override
  String get tastingFieldDateLabel => 'Date';

  @override
  String get tastingFieldTimeLabel => 'Time';

  @override
  String get tastingFieldPlaceLabel => 'Place';

  @override
  String get tastingFieldDescriptionLabel => 'Description';

  @override
  String get tastingFieldTapToAdd => 'Tap to add';

  @override
  String get tastingFieldOpenLineupLabel => 'Open lineup';

  @override
  String get tastingFieldOpenLineupHint => 'Add wines as they arrive';

  @override
  String get tastingTitleSheetTitle => 'Tasting title';

  @override
  String get tastingTitleSheetHint => 'e.g. Barolo night';

  @override
  String get tastingDescriptionSheetTitle => 'Description';

  @override
  String get tastingDescriptionSheetHint => 'What is this about?';

  @override
  String get tastingCreateSubmitCta => 'Create tasting';

  @override
  String get tastingEditSubmitCta => 'Save changes';

  @override
  String get tastingCreateFailedSnack => 'Could not create tasting';

  @override
  String get tastingUpdateFailedSnack => 'Could not update tasting';

  @override
  String get tastingDetailNotFound => 'Tasting not found';

  @override
  String get tastingDetailErrorLoad => 'Couldn\'t load tasting';

  @override
  String get tastingDetailMenuAddToCalendar => 'Add to calendar';

  @override
  String get tastingDetailMenuShare => 'Share';

  @override
  String get tastingDetailMenuEdit => 'Edit tasting';

  @override
  String get tastingDetailMenuCancel => 'Cancel tasting';

  @override
  String get tastingDetailCancelDialogTitle => 'Cancel tasting?';

  @override
  String get tastingDetailCancelDialogBody => 'This removes it for everyone.';

  @override
  String get tastingDetailCancelDialogKeep => 'Keep';

  @override
  String get tastingDetailCancelDialogConfirm => 'Cancel';

  @override
  String get tastingDetailEndDialogTitle => 'End tasting?';

  @override
  String get tastingDetailEndDialogBody =>
      'This locks the recap. Attendees can still add ratings briefly afterwards.';

  @override
  String get tastingDetailEndDialogKeep => 'Keep going';

  @override
  String get tastingDetailEndDialogConfirm => 'End';

  @override
  String get tastingCalendarFailedSnack => 'Could not open calendar';

  @override
  String get tastingLifecycleUpcoming => 'UPCOMING';

  @override
  String get tastingLifecycleLive => 'LIVE';

  @override
  String get tastingLifecycleConcluded => 'CONCLUDED';

  @override
  String get tastingLifecycleStartCta => 'Start tasting';

  @override
  String get tastingLifecycleEndCta => 'End tasting';

  @override
  String get tastingDetailSectionPeople => 'People';

  @override
  String get tastingDetailSectionPlace => 'Place';

  @override
  String get tastingDetailSectionWines => 'WINES';

  @override
  String get tastingDetailAddWines => 'Add wines';

  @override
  String get tastingDetailNoAttendees => 'No one invited yet.';

  @override
  String get tastingDetailUnknownAttendee => 'Unknown';

  @override
  String get tastingDetailRsvpYour => 'Your response';

  @override
  String get tastingDetailRsvpGoing => 'Going';

  @override
  String get tastingDetailRsvpMaybe => 'Maybe';

  @override
  String get tastingDetailRsvpDeclined => 'No';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count going';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count maybe';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count declined';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count pending';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Going';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Maybe';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'Declined';

  @override
  String get tastingDetailAttendeesSheetPending => 'Pending';

  @override
  String get tastingEmptyOpenActiveTitle => 'Lineup fills as you go';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Anyone going can add bottles as they appear';

  @override
  String get tastingEmptyDefaultTitle => 'No wines lined up yet';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Wines can be added once the tasting starts';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Wines will be added on the night';

  @override
  String get tastingEmptyPlannedHost => 'Tap “Add wines” to build the lineup';

  @override
  String get tastingEmptyPlannedGuest => 'The host hasn’t added wines yet';

  @override
  String get tastingRecapResultsHeader => 'RESULTS';

  @override
  String get tastingRecapShareCta => 'Share recap';

  @override
  String get tastingRecapTopWineEyebrow => 'TOP WINE OF THE NIGHT';

  @override
  String get tastingRecapEmpty => 'No ratings submitted for this tasting yet.';

  @override
  String get tastingRecapRowNoRatings => 'no ratings';

  @override
  String get tastingRecapGroupFallback => 'Group tasting';

  @override
  String get tastingPickerSheetTitle => 'Add wines to lineup';

  @override
  String get tastingPickerEmpty => 'You have no wines yet.';

  @override
  String get tastingPickerErrorFallback => 'Couldn\'t load wines.';

  @override
  String get tastingPickerSubmitDefault => 'Add wines';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Add $count wines',
      one: 'Add 1 wine',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Added';

  @override
  String get groupListHeader => 'GROUPS';

  @override
  String get groupListSubtitle => 'Taste together';

  @override
  String get groupListSortRecent => 'Sort: recent';

  @override
  String get groupListSortName => 'Sort: name';

  @override
  String get groupListCreateTooltip => 'Create group';

  @override
  String get groupListJoinTitle => 'Join a group';

  @override
  String get groupListJoinSubtitle => 'Enter an invite code';

  @override
  String get groupListJoinNotFound => 'Group not found';

  @override
  String get groupListErrorLoad => 'Couldn\'t load groups';

  @override
  String get groupListEmptyTitle => 'No groups yet';

  @override
  String get groupListEmptyBody => 'Create or join one to share wines';

  @override
  String get groupListEmptyCta => 'Create group';

  @override
  String get groupCreateSourceCamera => 'Camera';

  @override
  String get groupCreateSourceGallery => 'Gallery';

  @override
  String get groupCreateSourceRemovePhoto => 'Remove photo';

  @override
  String get groupCreatePickFailedFallback => 'Pick failed.';

  @override
  String get groupCreateUploadFailedFallback => 'Photo upload failed.';

  @override
  String get groupCreateFailedFallback => 'Couldn\'t create group. Try again.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get groupCreateTitle => 'New group';

  @override
  String get groupCreateNameHint => 'Group name';

  @override
  String get groupCreateSubmit => 'Create';

  @override
  String get groupJoinTitle => 'Invite code';

  @override
  String get groupJoinHint => 'e.g. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Join';

  @override
  String get groupDetailNotFound => 'Group not found';

  @override
  String get groupDetailErrorLoad => 'Couldn\'t load group';

  @override
  String get groupDetailSectionSharedWines => 'Shared wines';

  @override
  String get groupDetailSectionTastings => 'Tastings';

  @override
  String get groupDetailActionShare => 'Share';

  @override
  String get groupDetailActionPlan => 'Plan';

  @override
  String get groupDetailMenuEdit => 'Edit group';

  @override
  String get groupDetailMenuDelete => 'Delete group';

  @override
  String get groupDetailMenuLeave => 'Leave group';

  @override
  String get groupDetailLeaveDialogTitle => 'Leave group?';

  @override
  String get groupDetailLeaveDialogBody =>
      'You can rejoin later with the invite code.';

  @override
  String get groupDetailLeaveDialogCancel => 'Cancel';

  @override
  String get groupDetailLeaveDialogConfirm => 'Leave';

  @override
  String get groupDetailDeleteDialogTitle => 'Delete group?';

  @override
  String get groupDetailDeleteDialogBody =>
      'The group and its shared wines will be removed for everyone.';

  @override
  String get groupDetailDeleteDialogCancel => 'Cancel';

  @override
  String get groupDetailDeleteDialogConfirm => 'Delete';

  @override
  String get groupSettingsEditTitle => 'Edit group';

  @override
  String get groupSettingsNameLabel => 'Name';

  @override
  String get groupSettingsSourceCamera => 'Camera';

  @override
  String get groupSettingsSourceGallery => 'Gallery';

  @override
  String get groupSettingsRemovePhoto => 'Remove photo';

  @override
  String get groupSettingsUploadFailedFallback => 'Upload failed.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Delete failed.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get groupSettingsSave => 'Save';

  @override
  String get groupInviteEyebrow => 'INVITE';

  @override
  String get groupInviteFriendsEyebrow => 'INVITE FRIENDS';

  @override
  String get groupInviteCodeCopied => 'Invite code copied';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Join \"$groupName\" on Sippd 🍷\n\n$url\n\nOr enter code: $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Join $groupName on Sippd';
  }

  @override
  String get groupInviteActionCopy => 'Copy code';

  @override
  String get groupInviteActionShare => 'Share link';

  @override
  String get groupInviteFriendsEmpty => 'No friends available to invite.';

  @override
  String get groupInviteFriendsErrorLoad => 'Couldn\'t load friends';

  @override
  String get groupInviteFriendFallback => 'friend';

  @override
  String get groupInviteUnknownName => 'Unknown';

  @override
  String groupInviteSentSnack(String name) {
    return 'Invite sent to $name';
  }

  @override
  String get groupInviteSendFailedFallback => 'Could not send invite.';

  @override
  String get groupInvitationsHeader => 'INVITATIONS';

  @override
  String get groupInvitationsInviterFallback => 'Someone';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Invited by $name';
  }

  @override
  String get groupInvitationsDecline => 'Decline';

  @override
  String get groupInvitationsAccept => 'Accept';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return 'Joined $name';
  }

  @override
  String get groupInvitationsAcceptFailed => 'Could not accept invitation';

  @override
  String get groupMembersCountOne => '1 member';

  @override
  String groupMembersCountMany(int count) {
    return '$count members';
  }

  @override
  String get groupMembersUnknown => 'Unknown';

  @override
  String get groupMembersOwnerBadge => 'OWNER';

  @override
  String get groupWineCarouselDetails => 'Details';

  @override
  String get groupWineCarouselEmptyTitle => 'No wines shared yet';

  @override
  String get groupWineCarouselEmptyBody =>
      'Pick one from your cellar to kick off the list.';

  @override
  String get groupWineCarouselEmptyCta => 'Share a wine';

  @override
  String get groupWineTypeRed => 'RED';

  @override
  String get groupWineTypeWhite => 'WHITE';

  @override
  String get groupWineTypeRose => 'ROSÉ';

  @override
  String get groupWineTypeSparkling => 'SPARKLING';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Save the wine first — tasting notes attach to it.';

  @override
  String get groupWineRatingNoCanonical =>
      'Wine has no canonical identity yet — try again.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'Wine has no canonical identity yet.';

  @override
  String get groupWineRatingNotesHint => 'Add a note';

  @override
  String get groupWineRatingOfflineRetry => 'Offline · Retry';

  @override
  String get groupWineRatingSaveFailedRetry => 'Couldn\'t save · Retry';

  @override
  String get groupWineRatingSaved => 'Saved ✓';

  @override
  String get groupWineRatingSaveCta => 'Save rating';

  @override
  String get groupWineRatingRemoveMine => 'Remove my rating';

  @override
  String get groupWineRatingUnshareDialogTitle => 'Remove from group?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '\"$name\" will be removed from this group. Ratings from members will also be deleted.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Cancel';

  @override
  String get groupWineRatingUnshareConfirm => 'Remove';

  @override
  String get groupWineRatingMoreTooltip => 'More';

  @override
  String get groupWineRatingUnshareMenu => 'Remove from group';

  @override
  String get groupWineRatingsTitle => 'Ratings';

  @override
  String get groupWineRatingsCountOne => '1 rating';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count ratings';
  }

  @override
  String get groupWineRatingsAvgLabel => 'avg';

  @override
  String get groupWineRatingsBeFirst => 'Be the first to rate';

  @override
  String get groupWineRatingsSoloMe =>
      'You\'re the first · invite others to rate';

  @override
  String get groupShareWineTitle => 'Share a wine';

  @override
  String get groupShareWineErrorLoad => 'Couldn\'t load wines.';

  @override
  String get groupShareWineEmpty => 'You have no wines yet.';

  @override
  String get groupShareWineSharedChip => 'Shared';

  @override
  String get groupShareWineSheetTitle => 'Share to group';

  @override
  String get groupShareWineSheetEmpty => 'You are not in any groups yet.';

  @override
  String get groupShareWineSheetErrorLoad => 'Couldn\'t load groups.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Already shared';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Shared to $name';
  }

  @override
  String get groupShareWineRowMemberOne => '1 member';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count members';
  }

  @override
  String get groupShareWineRowWineOne => '1 wine';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count wines';
  }

  @override
  String get groupShareMatchTitle => 'Already in this group';

  @override
  String groupShareMatchBody(String name) {
    return '\"$name\" looks like a wine a member already shared. Is it the same wine?';
  }

  @override
  String get groupShareMatchNone => 'None of these — share separately';

  @override
  String get groupShareMatchCancel => 'Cancel';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Shared by @$username';
  }

  @override
  String get groupFriendActionsInvite => 'Invite to a group';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return 'Invite $name to…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'No groups to invite to. Create or join one first.';

  @override
  String get groupFriendActionsPickerErrorLoad => 'Couldn\'t load groups';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Past tastings ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'No tastings yet';

  @override
  String get groupCalendarEmptyBody =>
      'Schedule one to gather the group over a bottle.';

  @override
  String get groupCalendarEmptyCta => 'Plan a tasting';

  @override
  String get groupWineDetailSectionRatings => 'GROUP RATINGS';

  @override
  String get groupWineDetailEmptyRatings => 'No group ratings yet.';

  @override
  String get groupWineDetailStatGroupAvg => 'Group avg';

  @override
  String get groupWineDetailStatRatings => 'Ratings';

  @override
  String get groupWineDetailStatNoRatings => 'No ratings';

  @override
  String get groupWineDetailStatRegion => 'Region';

  @override
  String get groupWineDetailStatCountry => 'Country';

  @override
  String get groupWineDetailStatOrigin => 'Origin';

  @override
  String get groupWineDetailSharedByEyebrow => 'SHARED BY';

  @override
  String get groupWineDetailSharerFallback => 'someone';

  @override
  String get groupWineDetailMemberFallback => 'Member';

  @override
  String get groupWineDetailRelJustNow => 'just now';

  @override
  String groupWineDetailRelMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return '${count}h ago';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return '${count}d ago';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return '${count}w ago';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return '${count}mo ago';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return '${count}y ago';
  }

  @override
  String get friendsHeader => 'FRIENDS';

  @override
  String get friendsSubtitle => 'Taste with people you know';

  @override
  String get friendsSearchHint => 'Search by username or name';

  @override
  String get friendsSearchEmpty => 'No users found';

  @override
  String get friendsSearchErrorFallback => 'Couldn\'t load search.';

  @override
  String get friendsUnknownUser => 'Unknown';

  @override
  String friendsRequestsHeader(int count) {
    return 'Requests ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'Waiting for reply ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Request sent';

  @override
  String get friendsRequestSubtitle => 'wants to be friends';

  @override
  String get friendsActionCancel => 'Cancel';

  @override
  String get friendsActionAdd => 'Add';

  @override
  String get friendsCancelDialogFallbackUser => 'this user';

  @override
  String get friendsCancelDialogTitle => 'Cancel request?';

  @override
  String friendsCancelDialogBody(String name) {
    return 'Cancel your friend request to $name?';
  }

  @override
  String get friendsCancelDialogKeep => 'Keep';

  @override
  String get friendsCancelDialogConfirm => 'Cancel request';

  @override
  String get friendsListHeader => 'Your friends';

  @override
  String get friendsListErrorFallback => 'Couldn\'t load friends.';

  @override
  String get friendsRemoveDialogTitle => 'Remove friend?';

  @override
  String friendsRemoveDialogBody(String name) {
    return 'Remove $name from your friends?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Remove';

  @override
  String get friendsSendRequestErrorFallback => 'Could not send request.';

  @override
  String get friendsStatusChipFriend => 'Friend';

  @override
  String get friendsStatusChipPending => 'Pending';

  @override
  String get friendsEmptyDefaultName => 'A friend';

  @override
  String get friendsEmptyTitle => 'Bring your tasting circle';

  @override
  String get friendsEmptyBody =>
      'Sippd gets better with friends. Send an invite — they land straight on your profile.';

  @override
  String get friendsEmptyInviteCta => 'Invite friends';

  @override
  String get friendsEmptyFindCta => 'Find by username';

  @override
  String get friendsProfileNotFound => 'Profile not found';

  @override
  String get friendsProfileErrorLoad => 'Couldn\'t load profile';

  @override
  String get friendsProfileNameFallback => 'Friend';

  @override
  String get friendsProfileRecentWinesHeader => 'RECENT WINES';

  @override
  String get friendsProfileWinesErrorLoad => 'Couldn\'t load wines';

  @override
  String get friendsProfileStatWines => 'Wines';

  @override
  String get friendsProfileStatAvg => 'Avg';

  @override
  String get friendsProfileStatCountry => 'Country';

  @override
  String get friendsProfileStatCountries => 'Countries';

  @override
  String get paywallPitchEyebrow => 'Sippd Pro';

  @override
  String get paywallPitchHeadline => 'See how you\nreally taste.';

  @override
  String get paywallPitchSubhead =>
      'Map every bottle, match with friends who drink like you, and dig deeper into every tasting.';

  @override
  String get paywallBenefitFriendsTitle => 'Unlimited groups & friend matching';

  @override
  String get paywallBenefitFriendsSubtitle =>
      'Bring your circle. See who drinks like you.';

  @override
  String get paywallBenefitCompassTitle => 'Taste compass & deep stats';

  @override
  String get paywallBenefitCompassSubtitle => 'Your wine personality, mapped.';

  @override
  String get paywallBenefitNotesTitle => 'Expert tasting notes';

  @override
  String get paywallBenefitNotesSubtitle => 'Nose · body · tannins · finish.';

  @override
  String get paywallPlanMonthly => 'Monthly';

  @override
  String get paywallPlanAnnual => 'Annual';

  @override
  String get paywallPlanLifetime => 'Lifetime';

  @override
  String get paywallPlanSubtitleMonthly => 'Cancel anytime';

  @override
  String get paywallPlanSubtitleAnnual => 'Most popular';

  @override
  String get paywallPlanSubtitleLifetime => 'Limited launch offer · pay once';

  @override
  String get paywallPlanBadgeAnnual => 'MOST POPULAR';

  @override
  String get paywallPlanBadgeLifetime => 'FOUNDERS EDITION';

  @override
  String paywallPlanSavingsVsMonthly(int pct) {
    return 'Save $pct% vs monthly';
  }

  @override
  String get paywallTrialTodayTitle => 'Today';

  @override
  String get paywallTrialTodaySubtitle => 'Full Pro access unlocked.';

  @override
  String get paywallTrialDay5Title => 'Day 5';

  @override
  String get paywallTrialDay5Subtitle => 'We\'ll remind you before billing.';

  @override
  String get paywallTrialDay7Title => 'Day 7';

  @override
  String get paywallTrialDay7Subtitle => 'Trial ends. Cancel anytime.';

  @override
  String get paywallCtaContinue => 'Continue';

  @override
  String get paywallCtaSelectPlan => 'Select a plan';

  @override
  String get paywallCtaStartTrial => 'Start 7-day free trial';

  @override
  String get paywallCtaMaybeLater => 'Maybe later';

  @override
  String get paywallCtaRestore => 'Restore purchases';

  @override
  String get paywallFooterDisclosure =>
      'Cancel anytime · billed by Apple or Google';

  @override
  String get paywallPlansLoadError => 'Couldn\'t load plans';

  @override
  String get paywallPlansEmpty => 'No plans available yet.';

  @override
  String get paywallErrorPurchaseFailed => 'Purchase failed. Please try again.';

  @override
  String get paywallErrorRestoreFailed => 'Could not restore purchases.';

  @override
  String get paywallRestoreWelcomeBack => 'Welcome back to Sippd Pro!';

  @override
  String get paywallRestoreNoneFound => 'No active subscription found.';

  @override
  String get paywallSubscriptionTitle => 'Subscription';

  @override
  String get paywallSubscriptionBrand => 'Sippd Pro';

  @override
  String get paywallSubscriptionChipActive => 'ACTIVE';

  @override
  String get paywallSubscriptionChipTrial => 'TRIAL';

  @override
  String get paywallSubscriptionChipEnding => 'ENDING';

  @override
  String get paywallSubscriptionChipLifetime => 'LIFETIME';

  @override
  String get paywallSubscriptionChipTest => 'TEST MODE';

  @override
  String get paywallSubscriptionPlanTest => 'Test mode';

  @override
  String get paywallSubscriptionPlanLifetime => 'Lifetime';

  @override
  String get paywallSubscriptionPlanAnnual => 'Annual';

  @override
  String get paywallSubscriptionPlanMonthly => 'Monthly';

  @override
  String get paywallSubscriptionPlanWeekly => 'Weekly';

  @override
  String get paywallSubscriptionPlanGeneric => 'Pro plan';

  @override
  String get paywallSubscriptionPeriodYear => '/ year';

  @override
  String get paywallSubscriptionPeriodMonth => '/ month';

  @override
  String get paywallSubscriptionPeriodWeek => '/ week';

  @override
  String get paywallSubscriptionPeriodLifetime => 'one-time';

  @override
  String get paywallSubscriptionStoreAppStore => 'App Store';

  @override
  String get paywallSubscriptionStorePlayStore => 'Play Store';

  @override
  String get paywallSubscriptionStoreStripe => 'Stripe';

  @override
  String get paywallSubscriptionStoreAmazon => 'Amazon';

  @override
  String get paywallSubscriptionStoreMacAppStore => 'Mac App Store';

  @override
  String get paywallSubscriptionStorePromo => 'Promo grant';

  @override
  String paywallSubscriptionBilledVia(String store) {
    return 'Billed via $store';
  }

  @override
  String get paywallSubscriptionStatusTestNoSub =>
      'Pro features unlocked locally · no real subscription';

  @override
  String get paywallSubscriptionStatusTestLocal =>
      'Pro features unlocked locally';

  @override
  String get paywallSubscriptionStatusLifetime =>
      'Lifetime access — yours forever';

  @override
  String get paywallSubscriptionStatusEndingNoDate => 'Won\'t renew';

  @override
  String paywallSubscriptionStatusEndingWithDate(String date) {
    return 'Access until $date · won\'t renew';
  }

  @override
  String get paywallSubscriptionStatusTrialActive => 'Trial active';

  @override
  String get paywallSubscriptionStatusTrialEndsToday => 'Trial ends today';

  @override
  String get paywallSubscriptionStatusTrialEndsTomorrow =>
      'Trial ends tomorrow';

  @override
  String paywallSubscriptionStatusTrialEndsInDays(int days) {
    return 'Trial ends in $days days';
  }

  @override
  String get paywallSubscriptionStatusActive => 'Active';

  @override
  String paywallSubscriptionStatusRenewsOn(String date) {
    return 'Renews $date';
  }

  @override
  String get paywallSubscriptionSectionIncluded => 'Included in Pro';

  @override
  String get paywallSubscriptionSectionManage => 'Manage';

  @override
  String get paywallSubscriptionRowChangePlan => 'Change plan';

  @override
  String get paywallSubscriptionRowRestore => 'Restore purchases';

  @override
  String get paywallSubscriptionRowCancel => 'Cancel subscription';

  @override
  String get paywallSubscriptionDisclosure =>
      'Subscriptions are billed by Apple or Google. Manage them in store settings.';

  @override
  String get paywallSubscriptionOpenError =>
      'Could not open subscription settings.';

  @override
  String get paywallMonthShortJan => 'Jan';

  @override
  String get paywallMonthShortFeb => 'Feb';

  @override
  String get paywallMonthShortMar => 'Mar';

  @override
  String get paywallMonthShortApr => 'Apr';

  @override
  String get paywallMonthShortMay => 'May';

  @override
  String get paywallMonthShortJun => 'Jun';

  @override
  String get paywallMonthShortJul => 'Jul';

  @override
  String get paywallMonthShortAug => 'Aug';

  @override
  String get paywallMonthShortSep => 'Sep';

  @override
  String get paywallMonthShortOct => 'Oct';

  @override
  String get paywallMonthShortNov => 'Nov';

  @override
  String get paywallMonthShortDec => 'Dec';

  @override
  String get tasteTraitBody => 'Body';

  @override
  String get tasteTraitTannin => 'Tannin';

  @override
  String get tasteTraitAcidity => 'Acidity';

  @override
  String get tasteTraitSweetness => 'Sweetness';

  @override
  String get tasteTraitOak => 'Oak';

  @override
  String get tasteTraitIntensity => 'Intensity';

  @override
  String get tasteTraitSweetShort => 'Sweet';

  @override
  String get tasteTraitBodyLow => 'Light, easy-drinking';

  @override
  String get tasteTraitBodyMid => 'Balanced';

  @override
  String get tasteTraitBodyHigh => 'Bold, full-bodied';

  @override
  String get tasteTraitTanninLow => 'Soft, low-grip';

  @override
  String get tasteTraitTanninMid => 'Medium grip';

  @override
  String get tasteTraitTanninHigh => 'Grippy, structured';

  @override
  String get tasteTraitAcidityLow => 'Soft, round';

  @override
  String get tasteTraitAcidityMid => 'Balanced';

  @override
  String get tasteTraitAcidityHigh => 'Crisp, bright';

  @override
  String get tasteTraitSweetnessLow => 'Bone dry';

  @override
  String get tasteTraitSweetnessMid => 'Off-dry';

  @override
  String get tasteTraitSweetnessHigh => 'Sweet-leaning';

  @override
  String get tasteTraitOakLow => 'Unoaked, fresh';

  @override
  String get tasteTraitOakMid => 'Touch of oak';

  @override
  String get tasteTraitOakHigh => 'Oak-forward';

  @override
  String get tasteTraitIntensityLow => 'Subtle aromatics';

  @override
  String get tasteTraitIntensityMid => 'Expressive';

  @override
  String get tasteTraitIntensityHigh => 'Bold, aromatic';

  @override
  String tasteDnaBodyLowPct(int pct) {
    return 'You lean light-bodied · $pct%';
  }

  @override
  String tasteDnaBodyMidPct(int pct) {
    return 'Balanced body · $pct%';
  }

  @override
  String tasteDnaBodyHighPct(int pct) {
    return 'You lean full-bodied · $pct%';
  }

  @override
  String tasteDnaTanninLowPct(int pct) {
    return 'Soft tannins · $pct%';
  }

  @override
  String tasteDnaTanninMidPct(int pct) {
    return 'Medium tannin · $pct%';
  }

  @override
  String tasteDnaTanninHighPct(int pct) {
    return 'Bold, gripping tannins · $pct%';
  }

  @override
  String tasteDnaAcidityLowPct(int pct) {
    return 'Soft acid · $pct%';
  }

  @override
  String tasteDnaAcidityMidPct(int pct) {
    return 'Balanced acid · $pct%';
  }

  @override
  String tasteDnaAcidityHighPct(int pct) {
    return 'High-acid drinker · $pct%';
  }

  @override
  String tasteDnaSweetnessLowPct(int pct) {
    return 'Bone dry · $pct%';
  }

  @override
  String tasteDnaSweetnessMidPct(int pct) {
    return 'Off-dry tendency · $pct%';
  }

  @override
  String tasteDnaSweetnessHighPct(int pct) {
    return 'Sweet leaning · $pct%';
  }

  @override
  String tasteDnaOakLowPct(int pct) {
    return 'Unoaked / fresh · $pct%';
  }

  @override
  String tasteDnaOakMidPct(int pct) {
    return 'Some oak · $pct%';
  }

  @override
  String tasteDnaOakHighPct(int pct) {
    return 'Oak lover · $pct%';
  }

  @override
  String tasteDnaIntensityLowPct(int pct) {
    return 'Subtle aromatics · $pct%';
  }

  @override
  String tasteDnaIntensityMidPct(int pct) {
    return 'Expressive · $pct%';
  }

  @override
  String tasteDnaIntensityHighPct(int pct) {
    return 'Bold aromatics · $pct%';
  }

  @override
  String get tasteDnaNotEnoughYet => 'Not enough rated wines yet — keep going';

  @override
  String get tasteArchetypeBoldRedHunter => 'Bold Red Hunter';

  @override
  String get tasteArchetypeBoldRedHunterTagline =>
      'Full-bodied, tannin-rich reds are your home turf.';

  @override
  String get tasteArchetypeElegantBurgundian => 'Elegant Burgundian';

  @override
  String get tasteArchetypeElegantBurgundianTagline =>
      'Lighter reds with bright acidity drive your palate.';

  @override
  String get tasteArchetypeAromaticWhiteLover => 'Aromatic White Lover';

  @override
  String get tasteArchetypeAromaticWhiteLoverTagline =>
      'Crisp, expressive whites with cut-through acidity.';

  @override
  String get tasteArchetypeSparklingSociable => 'Sparkling Sociable';

  @override
  String get tasteArchetypeSparklingSociableTagline =>
      'Bubbles and pale wines feature heavily in your collection.';

  @override
  String get tasteArchetypeClassicStructure => 'Classic Structure';

  @override
  String get tasteArchetypeClassicStructureTagline =>
      'Restrained, food-aligned wines with bright acidity.';

  @override
  String get tasteArchetypeSunRipenedBold => 'Sun-Ripened Bold';

  @override
  String get tasteArchetypeSunRipenedBoldTagline =>
      'Big fruit, oak-friendly wines from sun-soaked vineyards.';

  @override
  String get tasteArchetypeDessertOffDry => 'Dessert / Off-Dry';

  @override
  String get tasteArchetypeDessertOffDryTagline =>
      'You lean toward bottles with a touch of sweetness.';

  @override
  String get tasteArchetypeNaturalLowIntervention =>
      'Natural / Low-Intervention';

  @override
  String get tasteArchetypeNaturalLowInterventionTagline =>
      'Unoaked, lighter wines — the freshness camp.';

  @override
  String get tasteArchetypeCrispMineralFan => 'Crisp Mineral Fan';

  @override
  String get tasteArchetypeCrispMineralFanTagline =>
      'Tight, mineral, high-acid styles are your signature.';

  @override
  String get tasteArchetypeEclecticExplorer => 'Eclectic Explorer';

  @override
  String get tasteArchetypeEclecticExplorerTagline =>
      'Wide-ranging palate — you taste across the wine map.';

  @override
  String get tasteArchetypeCuriousNewcomer => 'Curious Newcomer';

  @override
  String get tasteArchetypeCuriousNewcomerTagline =>
      'Rate a few more wines and your personality reveals itself.';

  @override
  String get tasteCompassModeStyle => 'Style';

  @override
  String get tasteCompassModeWorld => 'World';

  @override
  String get tasteCompassModeGrapes => 'Grapes';

  @override
  String get tasteCompassModeDna => 'DNA';

  @override
  String get tasteCompassMetricCount => 'count';

  @override
  String get tasteCompassMetricRating => 'rating';

  @override
  String get tasteCompassContinentEurope => 'Europe';

  @override
  String get tasteCompassContinentNorthAmerica => 'North America';

  @override
  String get tasteCompassContinentSouthAmerica => 'South America';

  @override
  String get tasteCompassContinentAfrica => 'Africa';

  @override
  String get tasteCompassContinentAsia => 'Asia';

  @override
  String get tasteCompassContinentOceania => 'Oceania';

  @override
  String tasteCompassStyleNoneYet(String label) {
    return 'No $label wines yet';
  }

  @override
  String tasteCompassStyleSummaryOne(int count, String label, String avg) {
    return '$count $label wine · $avg★ avg';
  }

  @override
  String tasteCompassStyleSummaryMany(int count, String label, String avg) {
    return '$count $label wines · $avg★ avg';
  }

  @override
  String tasteCompassWorldNoneYet(String label) {
    return 'No bottles from $label yet';
  }

  @override
  String tasteCompassWorldSummaryOne(String label, String avg) {
    return '1 bottle from $label · $avg★ avg';
  }

  @override
  String tasteCompassWorldSummaryMany(int count, String label, String avg) {
    return '$count bottles from $label · $avg★ avg';
  }

  @override
  String get tasteCompassGrapeEmptySlot =>
      'Empty slot — rate more grapes to fill';

  @override
  String tasteCompassGrapeSummaryOne(String name, String avg) {
    return '$name · 1 bottle · $avg★ avg';
  }

  @override
  String tasteCompassGrapeSummaryMany(String name, int count, String avg) {
    return '$name · $count bottles · $avg★ avg';
  }

  @override
  String get tasteCompassTitleDefault => 'Taste compass';

  @override
  String get tasteCompassEmptyPromptOne =>
      'Rate 1 more wine to unlock the compass.';

  @override
  String tasteCompassEmptyPromptMany(int count) {
    return 'Rate $count more wines to unlock the compass.';
  }

  @override
  String get tasteCompassNotEnoughData => 'Not enough data for this mode yet.';

  @override
  String get tasteCompassDnaNeedsGrapes =>
      'DNA needs a few wines whose grape we recognise. Pick a canonical grape on your wines to unlock this view.';

  @override
  String get tasteCompassEyebrowPersonality => 'YOUR WINE PERSONALITY';

  @override
  String get tasteCompassTentativeHint =>
      'Tentative — rate more wines for a sharper read';

  @override
  String get tasteCompassTopRegions => 'Top regions';

  @override
  String get tasteCompassTopCountries => 'Top countries';

  @override
  String get tasteCompassFooterWinesOne => '1 wine';

  @override
  String tasteCompassFooterWinesMany(int count) {
    return '$count wines';
  }

  @override
  String tasteCompassFooterAvg(String avg) {
    return '$avg ★ avg';
  }

  @override
  String get tasteHeroEyebrow => 'PERSONALITY';

  @override
  String get tasteHeroPromptCuriousOne =>
      'Rate 1 more wine to reveal your personality.';

  @override
  String tasteHeroPromptCuriousMany(int count) {
    return 'Rate $count more wines to reveal your personality.';
  }

  @override
  String get tasteHeroAlmostThere => 'Almost There';

  @override
  String get tasteHeroPromptThinDnaOne =>
      'Tag a canonical grape on 1 more wine to unlock your archetype.';

  @override
  String tasteHeroPromptThinDnaMany(int count) {
    return 'Tag a canonical grape on $count more wines to unlock your archetype.';
  }

  @override
  String tasteHeroMatchExact(int score) {
    return '$score% match';
  }

  @override
  String tasteHeroMatchTentative(int score) {
    return '~$score% match';
  }

  @override
  String get tasteHeroWinesOne => '1 wine';

  @override
  String tasteHeroWinesMany(int count) {
    return '$count wines';
  }

  @override
  String tasteHeroAvg(String avg) {
    return '$avg★ avg';
  }

  @override
  String get tasteHeroShare => 'Share';

  @override
  String get tasteTraitsHeading => 'TRAITS';

  @override
  String get tasteTraitsProDivider => 'PRO';

  @override
  String get tasteTraitsUnlockAll => 'Unlock all traits with Pro';

  @override
  String get tasteMatchLabel => 'taste match';

  @override
  String get tasteMatchConfidenceStrong => 'Strong';

  @override
  String get tasteMatchConfidenceSolid => 'Solid';

  @override
  String get tasteMatchConfidenceEarly => 'Early';

  @override
  String tasteMatchSupportingOne(String dnaPart) {
    return 'Based on 1 shared region/type bucket$dnaPart.';
  }

  @override
  String tasteMatchSupportingMany(int overlap, String dnaPart) {
    return 'Based on $overlap shared region/type buckets$dnaPart.';
  }

  @override
  String get tasteMatchSupportingDnaPart => ' + WSET style overlap';

  @override
  String get tasteMatchSignalStrong => 'Strong signal.';

  @override
  String get tasteMatchSignalSolid => 'Solid signal.';

  @override
  String get tasteMatchSignalEarly =>
      'Early signal — keep rating to sharpen this.';

  @override
  String get tasteMatchBreakdownBucket => 'Region & type fit';

  @override
  String get tasteMatchBreakdownDna => 'Style DNA fit';

  @override
  String get tasteMatchEmptyNotEnough =>
      'Not enough wines to compare yet — rate a few more bottles to unlock taste match.';

  @override
  String get tasteMatchEmptyNoOverlap =>
      'You haven\'t rated wines from the same regions or types yet. Match opens up as your tastes overlap.';

  @override
  String tasteFriendUpsellTitle(String name) {
    return 'See how $name tastes';
  }

  @override
  String get tasteFriendUpsellBody =>
      'Compare your palates, find wines you both love, and spot where your taste diverges.';

  @override
  String get tasteFriendUpsellPillMatch => 'Taste match';

  @override
  String get tasteFriendUpsellPillShared => 'Shared bottles';

  @override
  String get tasteFriendUpsellCta => 'Unlock Sippd Pro';

  @override
  String get tasteFriendSharedHeading => 'WINES YOU\'VE BOTH RATED';

  @override
  String tasteFriendSharedMore(int count) {
    return '+ $count more';
  }

  @override
  String get tasteFriendRatingYou => 'you';

  @override
  String get tasteFriendRatingThem => 'them';

  @override
  String shareRatedOn(String date) {
    return 'RATED · $date';
  }

  @override
  String get shareRatingDenominator => '/ 10';

  @override
  String shareFooterRateYours(String url) {
    return 'rate yours at $url';
  }

  @override
  String shareFooterFindYours(String url) {
    return 'find your taste at $url';
  }

  @override
  String shareFooterHostYours(String url) {
    return 'host yours at $url';
  }

  @override
  String shareFooterJoinAt(String url) {
    return 'join at $url';
  }

  @override
  String get shareCompassEyebrow => 'WINE PERSONALITY';

  @override
  String get shareCompassWhatDefinesMe => 'WHAT DEFINES ME';

  @override
  String get shareCompassSampleSizeOne => 'based on 1 wine';

  @override
  String shareCompassSampleSizeMany(int count) {
    return 'based on $count wines';
  }

  @override
  String shareCompassPhrase(String descriptor, String trait) {
    return '$descriptor $trait';
  }

  @override
  String shareCompassShareText(String archetype, String url) {
    return 'My wine personality: $archetype · find yours at $url';
  }

  @override
  String get shareTastingEyebrow => 'GROUP TASTING';

  @override
  String get shareTastingTopWine => 'TOP WINE OF THE NIGHT';

  @override
  String get shareTastingLineup => 'LINEUP';

  @override
  String shareTastingMore(int count) {
    return '+ $count more';
  }

  @override
  String get shareTastingAttendeesOne => '1 taster';

  @override
  String shareTastingAttendeesMany(int count) {
    return '$count tasters';
  }

  @override
  String shareTastingShareTextTop(String wine, String avg, String url) {
    return '$wine took the night at $avg/10 · hosted on Sippd · $url';
  }

  @override
  String shareTastingShareTextTitle(String title, String url) {
    return '$title · hosted on Sippd · $url';
  }

  @override
  String shareRatingShareText(String wine, String rating, String url) {
    return 'Just rated $wine $rating/10 on Sippd · $url';
  }

  @override
  String get shareInviteEyebrow => 'AN INVITATION';

  @override
  String get shareInviteHero => 'Let\'s taste\ntogether.';

  @override
  String get shareInviteSub => 'Rate it. Remember it. Share it.';

  @override
  String get shareInviteWantsToTaste => 'wants to taste with you';

  @override
  String shareInviteFallbackText(String name, String url) {
    return '$name wants to taste with you on Sippd · $url';
  }

  @override
  String shareInviteImageText(String url) {
    return 'Join me on Sippd 🍷  $url';
  }

  @override
  String get shareInviteSubject => 'Join me on Sippd';

  @override
  String get shareRatingPromptSavedBadge => 'WINE SAVED';

  @override
  String get shareRatingPromptTitle => 'Your card is ready';

  @override
  String get shareRatingPromptBody =>
      'Send it to friends or post it to your story.';

  @override
  String get shareRatingPromptCta => 'Share card';

  @override
  String get shareRatingPromptPreparing => 'Preparing…';

  @override
  String get shareRatingPromptDismiss => 'Not now';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonGotIt => 'Got it';

  @override
  String get commonOptional => '(optional)';

  @override
  String get commonOffline => 'Offline';

  @override
  String get commonOfflineMessage => 'You\'re offline. Reconnect to try again.';

  @override
  String get commonNetworkErrorMessage =>
      'Network error. Check your connection.';

  @override
  String get commonSomethingWentWrong => 'Something went wrong.';

  @override
  String get commonErrorViewOfflineTitle => 'You\'re offline';

  @override
  String get commonErrorViewOfflineSubtitle => 'Reconnect to load this.';

  @override
  String get commonErrorViewGenericTitle => 'Couldn\'t load';

  @override
  String get commonErrorViewGenericSubtitle =>
      'Pull to retry or try again later.';

  @override
  String get commonInlineCouldntSaveRetry => 'Couldn\'t save · Retry';

  @override
  String get commonInlineOfflineRetry => 'Offline · Retry';

  @override
  String get commonPhotoDialogCameraTitle => 'Camera access off';

  @override
  String get commonPhotoDialogCameraBody =>
      'Sippd needs camera access to capture wine photos. Enable it in Settings to continue.';

  @override
  String get commonPhotoDialogPhotosTitle => 'Photos access off';

  @override
  String get commonPhotoDialogPhotosBody =>
      'Sippd needs photo library access to attach images. Enable it in Settings to continue.';

  @override
  String get commonPhotoErrorSnack => 'Could not load photo. Please try again.';

  @override
  String get commonPriceSheetTitle => 'Bottle price';

  @override
  String get commonYearPickerTitle => 'Year';

  @override
  String get locSheetTitle => 'Where did you drink it?';

  @override
  String get locSearchHint => 'Search location...';

  @override
  String get locNoResults => 'No locations found';

  @override
  String get locSearchFailed => 'Search failed';

  @override
  String get locUseMyLocation => 'Use my current location';

  @override
  String get locFindingLocation => 'Finding your location…';

  @override
  String get locReadCurrentFailed => 'Could not read current location';

  @override
  String get locServicesDisabled => 'Location services are disabled';

  @override
  String get locPermissionDenied => 'Location permission denied';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileEditSectionProfile => 'Profile';

  @override
  String get profileEditFieldUsername => 'Username';

  @override
  String get profileEditFieldDisplayName => 'Display name';

  @override
  String profileEditDisplayNameHintWithUsername(String username) {
    return 'e.g. $username';
  }

  @override
  String get profileEditDisplayNameHintGeneric => 'How should we call you?';

  @override
  String get profileEditDisplayNameHelper =>
      'Shown in groups and tastings. Leave empty to use your username.';

  @override
  String get profileEditSectionTaste => 'Your taste';

  @override
  String get profileEditSectionTasteSubtitle =>
      'Tune what Sippd learns about you. Change anytime.';

  @override
  String get profileEditAvatarUpdateFailed =>
      'Couldn\'t update photo. Try again.';

  @override
  String get profileEditUploadFailed => 'Upload failed.';

  @override
  String get profileEditSaveChangesFailed =>
      'Couldn\'t save changes. Try again.';

  @override
  String get profileAvatarTakePhoto => 'Take photo';

  @override
  String get profileAvatarChooseGallery => 'Choose from gallery';

  @override
  String get profileAvatarRemove => 'Remove photo';

  @override
  String get profileUsernameTooShort => 'At least 3 characters';

  @override
  String get profileUsernameInvalid => 'Only letters, numbers, . and _';

  @override
  String get profileUsernameTaken => 'Already taken';

  @override
  String get profileUsernameAvailable => 'Available';

  @override
  String get profileUsernameChecking => 'Checking…';

  @override
  String get profileUsernameHelperIdle =>
      '3–20 chars · letters, numbers, . and _';

  @override
  String get profileChooseUsernameTitle => 'Pick a username';

  @override
  String get profileChooseUsernameSubtitle =>
      'How friends will find you on Sippd.';

  @override
  String get profileChooseUsernameHint => 'username';

  @override
  String get profileChooseUsernameContinue => 'Continue';

  @override
  String get profileChooseUsernameSaveFailed =>
      'Couldn\'t save username. Try again.';

  @override
  String get errNetworkDefault => 'No internet connection. Using cached data.';

  @override
  String get errOffline => 'You\'re offline. Reconnect to try again.';

  @override
  String errDatabase(String msg) {
    return 'Local data error: $msg';
  }

  @override
  String errValidation(String field, String msg) {
    return '$field: $msg';
  }

  @override
  String errValidationNoField(String msg) {
    return '$msg';
  }

  @override
  String errNotFound(String resource) {
    return '$resource not found.';
  }

  @override
  String get errNotFoundDefault => 'Not found.';

  @override
  String get errUnauthorized => 'Please sign in to continue.';

  @override
  String errServer(int code) {
    return 'Server error ($code). Try again.';
  }

  @override
  String get errServerNoCode => 'Server error. Try again.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String routeNotFound(String uri) {
    return 'Page not found: $uri';
  }
}

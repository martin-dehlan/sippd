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
  String get onbWelcomeTitle => 'Your wine\nmemory.';

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
}

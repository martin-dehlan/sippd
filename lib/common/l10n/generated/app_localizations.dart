import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// AppBar title for the notification settings screen
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Error view title when prefs fail to load
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load notification settings'**
  String get notificationsLoadError;

  /// No description provided for @sectionTastings.
  ///
  /// In en, this message translates to:
  /// **'Tastings'**
  String get sectionTastings;

  /// No description provided for @sectionFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get sectionFriends;

  /// No description provided for @sectionGroups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get sectionGroups;

  /// No description provided for @tileTastingRemindersLabel.
  ///
  /// In en, this message translates to:
  /// **'Tasting reminders'**
  String get tileTastingRemindersLabel;

  /// No description provided for @tileTastingRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Push before a tasting starts'**
  String get tileTastingRemindersSubtitle;

  /// No description provided for @tileFriendActivityLabel.
  ///
  /// In en, this message translates to:
  /// **'Friend activity'**
  String get tileFriendActivityLabel;

  /// No description provided for @tileFriendActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Requests and acceptances'**
  String get tileFriendActivitySubtitle;

  /// No description provided for @tileGroupActivityLabel.
  ///
  /// In en, this message translates to:
  /// **'Group activity'**
  String get tileGroupActivityLabel;

  /// No description provided for @tileGroupActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invites, joins and new tastings'**
  String get tileGroupActivitySubtitle;

  /// No description provided for @tileGroupWineSharedLabel.
  ///
  /// In en, this message translates to:
  /// **'New wine shared'**
  String get tileGroupWineSharedLabel;

  /// No description provided for @tileGroupWineSharedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When a friend adds a wine to your group'**
  String get tileGroupWineSharedSubtitle;

  /// No description provided for @hoursPickerLabel.
  ///
  /// In en, this message translates to:
  /// **'Notify me before'**
  String get hoursPickerLabel;

  /// No description provided for @hoursPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Applies to all upcoming tastings — change anytime.'**
  String get hoursPickerHint;

  /// Chip label for an hours-before option, e.g. 1h, 2h, 24h
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String hoursPickerOption(int hours);

  /// Debug-only 30-seconds-before option
  ///
  /// In en, this message translates to:
  /// **'30s · debug'**
  String get hoursPickerDebugOption;

  /// Profile menu tile that opens the language picker
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileTileLanguageLabel;

  /// Title of the language picker bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get languageSheetTitle;

  /// Option that follows the device language
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageOptionSystem;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your wine\nmemory.'**
  String get onbWelcomeTitle;

  /// No description provided for @onbWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Rate the wines you love. Remember them forever. Taste alongside friends.'**
  String get onbWelcomeBody;

  /// No description provided for @onbWelcomeAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get onbWelcomeAlreadyHaveAccount;

  /// No description provided for @onbWelcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get onbWelcomeSignIn;

  /// No description provided for @onbWhyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Why Sippd'**
  String get onbWhyEyebrow;

  /// No description provided for @onbWhyTitle.
  ///
  /// In en, this message translates to:
  /// **'Built for people\nwho actually drink wine.'**
  String get onbWhyTitle;

  /// No description provided for @onbWhyPrinciple1Headline.
  ///
  /// In en, this message translates to:
  /// **'Snap. Rate. Remember.'**
  String get onbWhyPrinciple1Headline;

  /// No description provided for @onbWhyPrinciple1Line.
  ///
  /// In en, this message translates to:
  /// **'Three taps, find it next year.'**
  String get onbWhyPrinciple1Line;

  /// No description provided for @onbWhyPrinciple2Headline.
  ///
  /// In en, this message translates to:
  /// **'Tastings with friends.'**
  String get onbWhyPrinciple2Headline;

  /// No description provided for @onbWhyPrinciple2Line.
  ///
  /// In en, this message translates to:
  /// **'Blind pours, pooled scores. No spreadsheets.'**
  String get onbWhyPrinciple2Line;

  /// No description provided for @onbWhyPrinciple3Headline.
  ///
  /// In en, this message translates to:
  /// **'Works offline.'**
  String get onbWhyPrinciple3Headline;

  /// No description provided for @onbWhyPrinciple3Line.
  ///
  /// In en, this message translates to:
  /// **'Log anywhere. Syncs when you\'re home.'**
  String get onbWhyPrinciple3Line;

  /// No description provided for @onbLevelEyebrow.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get onbLevelEyebrow;

  /// No description provided for @onbLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'How deep are you\ninto wine?'**
  String get onbLevelTitle;

  /// No description provided for @onbLevelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No wrong answer. We\'ll tune suggestions and keep things your pace.'**
  String get onbLevelSubtitle;

  /// No description provided for @onbLevelBeginnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get onbLevelBeginnerLabel;

  /// No description provided for @onbLevelBeginnerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Just starting out'**
  String get onbLevelBeginnerSubtitle;

  /// No description provided for @onbLevelCuriousLabel.
  ///
  /// In en, this message translates to:
  /// **'Curious'**
  String get onbLevelCuriousLabel;

  /// No description provided for @onbLevelCuriousSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A few favorites'**
  String get onbLevelCuriousSubtitle;

  /// No description provided for @onbLevelEnthusiastLabel.
  ///
  /// In en, this message translates to:
  /// **'Enthusiast'**
  String get onbLevelEnthusiastLabel;

  /// No description provided for @onbLevelEnthusiastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I know what I like'**
  String get onbLevelEnthusiastSubtitle;

  /// No description provided for @onbLevelProLabel.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get onbLevelProLabel;

  /// No description provided for @onbLevelProSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Somm-level'**
  String get onbLevelProSubtitle;

  /// No description provided for @onbFreqEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Your rhythm'**
  String get onbFreqEyebrow;

  /// No description provided for @onbFreqTitle.
  ///
  /// In en, this message translates to:
  /// **'How often\ndo you open a bottle?'**
  String get onbFreqTitle;

  /// No description provided for @onbFreqWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get onbFreqWeekly;

  /// No description provided for @onbFreqMonthly.
  ///
  /// In en, this message translates to:
  /// **'A few times a month'**
  String get onbFreqMonthly;

  /// No description provided for @onbFreqRare.
  ///
  /// In en, this message translates to:
  /// **'Now and then'**
  String get onbFreqRare;

  /// No description provided for @onbGoalsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Your goals'**
  String get onbGoalsEyebrow;

  /// No description provided for @onbGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'What do you\nwant from Sippd?'**
  String get onbGoalsTitle;

  /// No description provided for @onbGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick one or more. You can change this later.'**
  String get onbGoalsSubtitle;

  /// No description provided for @onbGoalRemember.
  ///
  /// In en, this message translates to:
  /// **'Remember bottles I love'**
  String get onbGoalRemember;

  /// No description provided for @onbGoalDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover new styles'**
  String get onbGoalDiscover;

  /// No description provided for @onbGoalSocial.
  ///
  /// In en, this message translates to:
  /// **'Taste with friends'**
  String get onbGoalSocial;

  /// No description provided for @onbGoalValue.
  ///
  /// In en, this message translates to:
  /// **'Track what I pay'**
  String get onbGoalValue;

  /// No description provided for @onbStylesEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Your styles'**
  String get onbStylesEyebrow;

  /// No description provided for @onbStylesTitle.
  ///
  /// In en, this message translates to:
  /// **'What do you\nreach for?'**
  String get onbStylesTitle;

  /// No description provided for @onbStylesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick any that feel like you. We\'ll keep an eye on your picks.'**
  String get onbStylesSubtitle;

  /// No description provided for @wineTypeRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get wineTypeRed;

  /// No description provided for @wineTypeWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get wineTypeWhite;

  /// No description provided for @wineTypeRose.
  ///
  /// In en, this message translates to:
  /// **'Rosé'**
  String get wineTypeRose;

  /// No description provided for @wineTypeSparkling.
  ///
  /// In en, this message translates to:
  /// **'Sparkling'**
  String get wineTypeSparkling;

  /// No description provided for @onbRespEyebrow.
  ///
  /// In en, this message translates to:
  /// **'A note from us'**
  String get onbRespEyebrow;

  /// No description provided for @onbRespTitle.
  ///
  /// In en, this message translates to:
  /// **'Drink less,\ntaste more.'**
  String get onbRespTitle;

  /// No description provided for @onbRespSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sippd is for remembering and rating wines you\'ve enjoyed — not pressure to drink more. We don\'t do streaks or daily quotas, on purpose.'**
  String get onbRespSubtitle;

  /// No description provided for @onbRespHelpBody.
  ///
  /// In en, this message translates to:
  /// **'If alcohol is hurting you or someone close,\nfree confidential help is available.'**
  String get onbRespHelpBody;

  /// No description provided for @onbRespHelpCta.
  ///
  /// In en, this message translates to:
  /// **'Find help'**
  String get onbRespHelpCta;

  /// No description provided for @onbNameEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Almost there'**
  String get onbNameEyebrow;

  /// No description provided for @onbNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we\ncall you?'**
  String get onbNameTitle;

  /// No description provided for @onbNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'First name, nickname — whatever fits. Pick an icon too.'**
  String get onbNameSubtitle;

  /// No description provided for @onbNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onbNameHint;

  /// No description provided for @onbNameIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Pick your icon'**
  String get onbNameIconLabel;

  /// No description provided for @onbNameIconSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shows up as your avatar.'**
  String get onbNameIconSubtitle;

  /// No description provided for @onbNotifEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Stay in the loop'**
  String get onbNotifEyebrow;

  /// No description provided for @onbNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Never lose a great\nbottle again.'**
  String get onbNotifTitle;

  /// No description provided for @onbNotifSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll nudge you when friends start tastings or invite you to groups. You can turn this off anytime.'**
  String get onbNotifSubtitle;

  /// No description provided for @onbNotifPreview.
  ///
  /// In en, this message translates to:
  /// **'Tasting invites\nGroup ratings\nFriend activity'**
  String get onbNotifPreview;

  /// No description provided for @onbNotifTurnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications'**
  String get onbNotifTurnOn;

  /// No description provided for @onbNotifNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get onbNotifNotNow;

  /// No description provided for @onbLoaderAlmostThere.
  ///
  /// In en, this message translates to:
  /// **'ALMOST THERE'**
  String get onbLoaderAlmostThere;

  /// No description provided for @onbLoaderCrafting.
  ///
  /// In en, this message translates to:
  /// **'Crafting your profile.'**
  String get onbLoaderCrafting;

  /// No description provided for @onbLoaderAllSet.
  ///
  /// In en, this message translates to:
  /// **'All set.'**
  String get onbLoaderAllSet;

  /// No description provided for @onbLoaderStepMatching.
  ///
  /// In en, this message translates to:
  /// **'Matching your taste'**
  String get onbLoaderStepMatching;

  /// No description provided for @onbLoaderStepCurating.
  ///
  /// In en, this message translates to:
  /// **'Curating your styles'**
  String get onbLoaderStepCurating;

  /// No description provided for @onbLoaderStepSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting up your journal'**
  String get onbLoaderStepSetting;

  /// No description provided for @onbLoaderSeeProfile.
  ///
  /// In en, this message translates to:
  /// **'See your profile'**
  String get onbLoaderSeeProfile;

  /// No description provided for @onbLoaderContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onbLoaderContinue;

  /// No description provided for @onbResultsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOUR TASTE PROFILE'**
  String get onbResultsEyebrow;

  /// No description provided for @onbResultsLevelCard.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get onbResultsLevelCard;

  /// No description provided for @onbResultsFreqCard.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get onbResultsFreqCard;

  /// No description provided for @onbResultsStylesCard.
  ///
  /// In en, this message translates to:
  /// **'Styles'**
  String get onbResultsStylesCard;

  /// No description provided for @onbResultsGoalsCard.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get onbResultsGoalsCard;

  /// No description provided for @onbArchSommTitle.
  ///
  /// In en, this message translates to:
  /// **'Seasoned Somm'**
  String get onbArchSommTitle;

  /// No description provided for @onbArchSommSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You know your terroir. Sippd keeps the receipts.'**
  String get onbArchSommSubtitle;

  /// No description provided for @onbArchPalateTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharp Palate'**
  String get onbArchPalateTitle;

  /// No description provided for @onbArchPalateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nuance-chaser. Sippd captures the detail.'**
  String get onbArchPalateSubtitle;

  /// No description provided for @onbArchRegularTitle.
  ///
  /// In en, this message translates to:
  /// **'Cellar Regular'**
  String get onbArchRegularTitle;

  /// No description provided for @onbArchRegularSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A bottle a week, opinions sharper every month.'**
  String get onbArchRegularSubtitle;

  /// No description provided for @onbArchDevotedTitle.
  ///
  /// In en, this message translates to:
  /// **'Devoted Taster'**
  String get onbArchDevotedTitle;

  /// No description provided for @onbArchDevotedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Serious about each pour. Sippd keeps your notes.'**
  String get onbArchDevotedSubtitle;

  /// No description provided for @onbArchRedTitle.
  ///
  /// In en, this message translates to:
  /// **'Red Loyalist'**
  String get onbArchRedTitle;

  /// No description provided for @onbArchRedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One grape per glass. We\'ll help you branch out.'**
  String get onbArchRedSubtitle;

  /// No description provided for @onbArchBubbleTitle.
  ///
  /// In en, this message translates to:
  /// **'Bubble Chaser'**
  String get onbArchBubbleTitle;

  /// No description provided for @onbArchBubbleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bubbles over everything. Sippd tracks the good ones.'**
  String get onbArchBubbleSubtitle;

  /// No description provided for @onbArchOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Open Palate'**
  String get onbArchOpenTitle;

  /// No description provided for @onbArchOpenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Red, white, pink, sparkling — all welcome. Log them all.'**
  String get onbArchOpenSubtitle;

  /// No description provided for @onbArchSteadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Steady Sipper'**
  String get onbArchSteadyTitle;

  /// No description provided for @onbArchSteadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Wine stays in the rotation. Sippd keeps the thread.'**
  String get onbArchSteadySubtitle;

  /// No description provided for @onbArchNowAndThenTitle.
  ///
  /// In en, this message translates to:
  /// **'Now-and-Then Taster'**
  String get onbArchNowAndThenTitle;

  /// No description provided for @onbArchNowAndThenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Wine for the moments that matter.'**
  String get onbArchNowAndThenSubtitle;

  /// No description provided for @onbArchOccasionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Occasional Glass'**
  String get onbArchOccasionalTitle;

  /// No description provided for @onbArchOccasionalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rare pour, worth remembering.'**
  String get onbArchOccasionalSubtitle;

  /// No description provided for @onbArchFreshTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh Palate'**
  String get onbArchFreshTitle;

  /// No description provided for @onbArchFreshSubtitle.
  ///
  /// In en, this message translates to:
  /// **'New journey. Every bottle counts from here.'**
  String get onbArchFreshSubtitle;

  /// No description provided for @onbArchCuriousTitle.
  ///
  /// In en, this message translates to:
  /// **'Wine Curious'**
  String get onbArchCuriousTitle;

  /// No description provided for @onbArchCuriousSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us more and your profile sharpens.'**
  String get onbArchCuriousSubtitle;

  /// No description provided for @onbCtaGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onbCtaGetStarted;

  /// No description provided for @onbCtaIUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get onbCtaIUnderstand;

  /// No description provided for @onbCtaContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onbCtaContinue;

  /// No description provided for @onbCtaSignInToSave.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save it'**
  String get onbCtaSignInToSave;

  /// No description provided for @onbCtaSaveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save and continue'**
  String get onbCtaSaveAndContinue;

  /// No description provided for @onbStepCounter.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String onbStepCounter(int current, int total);

  /// No description provided for @tasteEditorLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get tasteEditorLevel;

  /// No description provided for @tasteEditorFreq.
  ///
  /// In en, this message translates to:
  /// **'How often'**
  String get tasteEditorFreq;

  /// No description provided for @tasteEditorStyles.
  ///
  /// In en, this message translates to:
  /// **'Favourite styles'**
  String get tasteEditorStyles;

  /// No description provided for @tasteEditorGoals.
  ///
  /// In en, this message translates to:
  /// **'What you\'re after'**
  String get tasteEditorGoals;

  /// No description provided for @tasteEditorFreqWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get tasteEditorFreqWeekly;

  /// No description provided for @tasteEditorFreqMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get tasteEditorFreqMonthly;

  /// No description provided for @tasteEditorFreqRare.
  ///
  /// In en, this message translates to:
  /// **'Rarely'**
  String get tasteEditorFreqRare;

  /// No description provided for @tasteEditorGoalRemember.
  ///
  /// In en, this message translates to:
  /// **'Remember'**
  String get tasteEditorGoalRemember;

  /// No description provided for @tasteEditorGoalDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get tasteEditorGoalDiscover;

  /// No description provided for @tasteEditorGoalSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get tasteEditorGoalSocial;

  /// No description provided for @tasteEditorGoalValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get tasteEditorGoalValue;

  /// No description provided for @authLoginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authLoginWelcomeBack;

  /// No description provided for @authLoginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authLoginCreateAccount;

  /// No description provided for @authLoginDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get authLoginDisplayNameLabel;

  /// No description provided for @authLoginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authLoginEmailLabel;

  /// No description provided for @authLoginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authLoginPasswordLabel;

  /// No description provided for @authLoginConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authLoginConfirmPasswordLabel;

  /// No description provided for @authLoginDisplayNameMin.
  ///
  /// In en, this message translates to:
  /// **'Min 2 characters'**
  String get authLoginDisplayNameMin;

  /// No description provided for @authLoginDisplayNameMax.
  ///
  /// In en, this message translates to:
  /// **'Max 30 characters'**
  String get authLoginDisplayNameMax;

  /// No description provided for @authLoginEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Valid email required'**
  String get authLoginEmailInvalid;

  /// No description provided for @authLoginPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'Min 8 characters'**
  String get authLoginPasswordMin;

  /// No description provided for @authLoginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get authLoginPasswordRequired;

  /// No description provided for @authLoginPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get authLoginPasswordsDontMatch;

  /// No description provided for @authLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authLoginForgotPassword;

  /// No description provided for @authLoginEnterValidEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email above first.'**
  String get authLoginEnterValidEmailFirst;

  /// No description provided for @authLoginSignUpFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t create account. Try again.'**
  String get authLoginSignUpFailedFallback;

  /// No description provided for @authLoginSignInFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Check your details.'**
  String get authLoginSignInFailedFallback;

  /// No description provided for @authLoginCreateAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authLoginCreateAccountButton;

  /// No description provided for @authLoginSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authLoginSignInButton;

  /// No description provided for @authLoginToggleHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get authLoginToggleHaveAccount;

  /// No description provided for @authLoginToggleNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get authLoginToggleNoAccount;

  /// No description provided for @authOrDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get authOrDivider;

  /// No description provided for @authGoogleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogleContinue;

  /// No description provided for @authGoogleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed. Please try again.'**
  String get authGoogleFailed;

  /// No description provided for @authConfTitleReset.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent'**
  String get authConfTitleReset;

  /// No description provided for @authConfTitleSignup.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get authConfTitleSignup;

  /// No description provided for @authConfIntroReset.
  ///
  /// In en, this message translates to:
  /// **'We sent a password reset link to'**
  String get authConfIntroReset;

  /// No description provided for @authConfIntroSignup.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to'**
  String get authConfIntroSignup;

  /// No description provided for @authConfOutroReset.
  ///
  /// In en, this message translates to:
  /// **'.\nTap it to set a new password.'**
  String get authConfOutroReset;

  /// No description provided for @authConfOutroSignup.
  ///
  /// In en, this message translates to:
  /// **'.\nTap it to activate your account.'**
  String get authConfOutroSignup;

  /// No description provided for @authConfOpenMailApp.
  ///
  /// In en, this message translates to:
  /// **'Open mail app'**
  String get authConfOpenMailApp;

  /// No description provided for @authConfResendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get authConfResendEmail;

  /// No description provided for @authConfResendSending.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get authConfResendSending;

  /// Cooldown label on the resend button
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String authConfResendIn(int seconds);

  /// No description provided for @authConfEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Email sent.'**
  String get authConfEmailSent;

  /// No description provided for @authConfResendFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t send. Try again in a moment.'**
  String get authConfResendFailedFallback;

  /// No description provided for @authConfBackToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get authConfBackToSignIn;

  /// No description provided for @authResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get authResetTitle;

  /// No description provided for @authResetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a password you haven\'t used before.'**
  String get authResetSubtitle;

  /// No description provided for @authResetNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authResetNewPasswordLabel;

  /// No description provided for @authResetConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authResetConfirmPasswordLabel;

  /// No description provided for @authResetPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'Min 6 characters'**
  String get authResetPasswordMin;

  /// No description provided for @authResetPasswordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get authResetPasswordsDontMatch;

  /// No description provided for @authResetFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update password. Try again.'**
  String get authResetFailedFallback;

  /// No description provided for @authResetUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get authResetUpdateButton;

  /// No description provided for @authResetUpdatedSnack.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get authResetUpdatedSnack;

  /// No description provided for @authProfileGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get authProfileGuest;

  /// No description provided for @authProfileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get authProfileSectionAccount;

  /// No description provided for @authProfileSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get authProfileSectionSupport;

  /// No description provided for @authProfileSectionLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get authProfileSectionLegal;

  /// No description provided for @authProfileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get authProfileEditProfile;

  /// No description provided for @authProfileFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get authProfileFriends;

  /// No description provided for @authProfileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get authProfileNotifications;

  /// No description provided for @authProfileCleanupDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Clean up duplicates'**
  String get authProfileCleanupDuplicates;

  /// No description provided for @authProfileSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get authProfileSubscription;

  /// No description provided for @authProfileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get authProfileChangePassword;

  /// No description provided for @authProfileContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get authProfileContactUs;

  /// No description provided for @authProfileRateSippd.
  ///
  /// In en, this message translates to:
  /// **'Rate Sippd'**
  String get authProfileRateSippd;

  /// No description provided for @authProfilePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authProfilePrivacyPolicy;

  /// No description provided for @authProfileTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get authProfileTermsOfService;

  /// No description provided for @authProfileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get authProfileSignOut;

  /// No description provided for @authProfileSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authProfileSignIn;

  /// No description provided for @authProfileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get authProfileDeleteAccount;

  /// No description provided for @authProfileViewFullStats.
  ///
  /// In en, this message translates to:
  /// **'View full stats'**
  String get authProfileViewFullStats;

  /// No description provided for @authProfileChangePasswordDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password?'**
  String get authProfileChangePasswordDialogTitle;

  /// No description provided for @authProfileChangePasswordDialogBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a password reset link to {email}. Tap it from your inbox to set a new password.'**
  String authProfileChangePasswordDialogBody(String email);

  /// No description provided for @authProfileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get authProfileCancel;

  /// No description provided for @authProfileSendLink.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get authProfileSendLink;

  /// No description provided for @authProfileSendLinkFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t send link'**
  String get authProfileSendLinkFailedTitle;

  /// No description provided for @authProfileSendLinkFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Try again in a moment.'**
  String get authProfileSendLinkFailedFallback;

  /// No description provided for @authProfileOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get authProfileOk;

  /// No description provided for @authProfileCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open {url}'**
  String authProfileCouldNotOpen(String url);

  /// No description provided for @authProfileDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get authProfileDeleteDialogTitle;

  /// No description provided for @authProfileDeleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your profile, wines, ratings, tastings, group memberships and friends. Cannot be undone.'**
  String get authProfileDeleteDialogBody;

  /// No description provided for @authProfileDeleteTypeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm:'**
  String get authProfileDeleteTypeConfirm;

  /// No description provided for @authProfileDeleteHint.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get authProfileDeleteHint;

  /// No description provided for @authProfileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get authProfileDelete;

  /// No description provided for @authProfileDeleteFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Delete failed.'**
  String get authProfileDeleteFailedFallback;

  /// No description provided for @winesListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your wine rankings'**
  String get winesListSubtitle;

  /// No description provided for @winesListSortRating.
  ///
  /// In en, this message translates to:
  /// **'Sort: rating'**
  String get winesListSortRating;

  /// No description provided for @winesListSortRecent.
  ///
  /// In en, this message translates to:
  /// **'Sort: recent'**
  String get winesListSortRecent;

  /// No description provided for @winesListSortName.
  ///
  /// In en, this message translates to:
  /// **'Sort: name'**
  String get winesListSortName;

  /// No description provided for @winesListTooltipStats.
  ///
  /// In en, this message translates to:
  /// **'Your stats'**
  String get winesListTooltipStats;

  /// No description provided for @winesListTooltipAddWine.
  ///
  /// In en, this message translates to:
  /// **'Add wine'**
  String get winesListTooltipAddWine;

  /// No description provided for @winesListErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wines'**
  String get winesListErrorLoad;

  /// No description provided for @winesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No wines yet'**
  String get winesEmptyTitle;

  /// No description provided for @winesEmptyFilteredTitle.
  ///
  /// In en, this message translates to:
  /// **'No wines match filter'**
  String get winesEmptyFilteredTitle;

  /// No description provided for @winesEmptyFilteredBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different filter'**
  String get winesEmptyFilteredBody;

  /// No description provided for @winesEmptyAddWineCta.
  ///
  /// In en, this message translates to:
  /// **'Add wine'**
  String get winesEmptyAddWineCta;

  /// No description provided for @winesAddSaveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save wine'**
  String get winesAddSaveLabel;

  /// No description provided for @winesAddDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard new wine?'**
  String get winesAddDiscardTitle;

  /// No description provided for @winesAddDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t saved this wine yet. Leaving now will discard your changes.'**
  String get winesAddDiscardBody;

  /// No description provided for @winesAddDiscardKeepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get winesAddDiscardKeepEditing;

  /// No description provided for @winesAddDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get winesAddDiscardConfirm;

  /// No description provided for @winesAddDuplicateTitle.
  ///
  /// In en, this message translates to:
  /// **'Looks like a duplicate'**
  String get winesAddDuplicateTitle;

  /// No description provided for @winesAddDuplicateBody.
  ///
  /// In en, this message translates to:
  /// **'You already logged \"{name}\" with the same vintage, winery and grape. Open the existing entry or add a new one anyway?'**
  String winesAddDuplicateBody(String name);

  /// No description provided for @winesAddDuplicateCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get winesAddDuplicateCancel;

  /// No description provided for @winesAddDuplicateAddAnyway.
  ///
  /// In en, this message translates to:
  /// **'Add anyway'**
  String get winesAddDuplicateAddAnyway;

  /// No description provided for @winesAddDuplicateOpenExisting.
  ///
  /// In en, this message translates to:
  /// **'Open existing'**
  String get winesAddDuplicateOpenExisting;

  /// No description provided for @winesDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wine not found'**
  String get winesDetailNotFound;

  /// No description provided for @winesDetailErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wine'**
  String get winesDetailErrorLoad;

  /// No description provided for @winesDetailMenuCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare with…'**
  String get winesDetailMenuCompare;

  /// No description provided for @winesDetailMenuShareRating.
  ///
  /// In en, this message translates to:
  /// **'Share rating'**
  String get winesDetailMenuShareRating;

  /// No description provided for @winesDetailMenuShareToGroup.
  ///
  /// In en, this message translates to:
  /// **'Share to group'**
  String get winesDetailMenuShareToGroup;

  /// No description provided for @winesDetailMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit wine'**
  String get winesDetailMenuEdit;

  /// No description provided for @winesDetailMenuTastingNotesPro.
  ///
  /// In en, this message translates to:
  /// **'Tasting notes (Pro)'**
  String get winesDetailMenuTastingNotesPro;

  /// No description provided for @winesDetailMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete wine'**
  String get winesDetailMenuDelete;

  /// No description provided for @winesDetailStatRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get winesDetailStatRating;

  /// No description provided for @winesDetailStatRatingUnit.
  ///
  /// In en, this message translates to:
  /// **'/ 10'**
  String get winesDetailStatRatingUnit;

  /// No description provided for @winesDetailStatPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get winesDetailStatPrice;

  /// No description provided for @winesDetailStatRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get winesDetailStatRegion;

  /// No description provided for @winesDetailStatCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get winesDetailStatCountry;

  /// No description provided for @winesDetailSectionNotes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get winesDetailSectionNotes;

  /// No description provided for @winesDetailSectionPlace.
  ///
  /// In en, this message translates to:
  /// **'PLACE'**
  String get winesDetailSectionPlace;

  /// No description provided for @winesDetailPlaceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No place set'**
  String get winesDetailPlaceEmpty;

  /// No description provided for @winesDetailDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete wine?'**
  String get winesDetailDeleteTitle;

  /// No description provided for @winesDetailDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get winesDetailDeleteBody;

  /// No description provided for @winesDetailDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get winesDetailDeleteCancel;

  /// No description provided for @winesDetailDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get winesDetailDeleteConfirm;

  /// No description provided for @winesEditErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wine'**
  String get winesEditErrorLoad;

  /// No description provided for @winesEditErrorMemories.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load memories'**
  String get winesEditErrorMemories;

  /// No description provided for @winesEditNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wine not found'**
  String get winesEditNotFound;

  /// No description provided for @winesCleanupTitle.
  ///
  /// In en, this message translates to:
  /// **'Clean up duplicates'**
  String get winesCleanupTitle;

  /// No description provided for @winesCleanupErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load duplicates'**
  String get winesCleanupErrorLoad;

  /// No description provided for @winesCleanupEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No duplicates to clean up'**
  String get winesCleanupEmptyTitle;

  /// No description provided for @winesCleanupEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your wines are tidy. We check for near-duplicate names and winery matches automatically.'**
  String get winesCleanupEmptyBody;

  /// No description provided for @winesCleanupMatchPct.
  ///
  /// In en, this message translates to:
  /// **'{pct}% match'**
  String winesCleanupMatchPct(int pct);

  /// No description provided for @winesCleanupKeepA.
  ///
  /// In en, this message translates to:
  /// **'Keep A'**
  String get winesCleanupKeepA;

  /// No description provided for @winesCleanupKeepB.
  ///
  /// In en, this message translates to:
  /// **'Keep B'**
  String get winesCleanupKeepB;

  /// No description provided for @winesCleanupSkippedSnack.
  ///
  /// In en, this message translates to:
  /// **'Skipped for now — will reappear next visit.'**
  String get winesCleanupSkippedSnack;

  /// No description provided for @winesCleanupDifferentWines.
  ///
  /// In en, this message translates to:
  /// **'They\'re different wines'**
  String get winesCleanupDifferentWines;

  /// No description provided for @winesCleanupMergeTitle.
  ///
  /// In en, this message translates to:
  /// **'Merge into \"{name}\"?'**
  String winesCleanupMergeTitle(String name);

  /// No description provided for @winesCleanupMergeBody.
  ///
  /// In en, this message translates to:
  /// **'Every rating, group share, and stat that pointed at \"{loser}\" will be moved over to \"{keeper}\". This cannot be undone.'**
  String winesCleanupMergeBody(String loser, String keeper);

  /// No description provided for @winesCleanupMergeCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get winesCleanupMergeCancel;

  /// No description provided for @winesCleanupMergeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get winesCleanupMergeConfirm;

  /// No description provided for @winesCleanupMergeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Merged into \"{name}\".'**
  String winesCleanupMergeSuccess(String name);

  /// No description provided for @winesCleanupMergeFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Merge failed.'**
  String get winesCleanupMergeFailedFallback;

  /// No description provided for @winesCompareHeader.
  ///
  /// In en, this message translates to:
  /// **'COMPARE'**
  String get winesCompareHeader;

  /// No description provided for @winesComparePickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick the second wine.'**
  String get winesComparePickerSubtitle;

  /// No description provided for @winesComparePickerEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No other wines yet'**
  String get winesComparePickerEmptyTitle;

  /// No description provided for @winesComparePickerEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add at least one more wine to compare.'**
  String get winesComparePickerEmptyBody;

  /// No description provided for @winesComparePickerErrorFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wines.'**
  String get winesComparePickerErrorFallback;

  /// No description provided for @winesCompareMissingSameWine.
  ///
  /// In en, this message translates to:
  /// **'Pick a different wine to compare.'**
  String get winesCompareMissingSameWine;

  /// No description provided for @winesCompareMissingDefault.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load both wines.'**
  String get winesCompareMissingDefault;

  /// No description provided for @winesCompareErrorFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wines.'**
  String get winesCompareErrorFallback;

  /// No description provided for @winesCompareSectionAtAGlance.
  ///
  /// In en, this message translates to:
  /// **'At a glance'**
  String get winesCompareSectionAtAGlance;

  /// No description provided for @winesCompareSectionTasting.
  ///
  /// In en, this message translates to:
  /// **'Tasting profile'**
  String get winesCompareSectionTasting;

  /// No description provided for @winesCompareSectionTastingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Body, tannin, acidity, sweetness, oak, finish.'**
  String get winesCompareSectionTastingSubtitle;

  /// No description provided for @winesCompareSectionNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get winesCompareSectionNotes;

  /// No description provided for @winesCompareAttrType.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get winesCompareAttrType;

  /// No description provided for @winesCompareAttrVintage.
  ///
  /// In en, this message translates to:
  /// **'VINTAGE'**
  String get winesCompareAttrVintage;

  /// No description provided for @winesCompareAttrGrape.
  ///
  /// In en, this message translates to:
  /// **'GRAPE'**
  String get winesCompareAttrGrape;

  /// No description provided for @winesCompareAttrOrigin.
  ///
  /// In en, this message translates to:
  /// **'ORIGIN'**
  String get winesCompareAttrOrigin;

  /// No description provided for @winesCompareAttrPrice.
  ///
  /// In en, this message translates to:
  /// **'PRICE'**
  String get winesCompareAttrPrice;

  /// No description provided for @winesCompareNotesEyebrow.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get winesCompareNotesEyebrow;

  /// No description provided for @winesCompareSlotWineLabel.
  ///
  /// In en, this message translates to:
  /// **'WINE {slot}'**
  String winesCompareSlotWineLabel(String slot);

  /// No description provided for @winesCompareVs.
  ///
  /// In en, this message translates to:
  /// **'VS'**
  String get winesCompareVs;

  /// No description provided for @winesCompareTastingLockedBody.
  ///
  /// In en, this message translates to:
  /// **'See body, tannin, acidity and more side by side.'**
  String get winesCompareTastingLockedBody;

  /// No description provided for @winesCompareTastingPro.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get winesCompareTastingPro;

  /// No description provided for @winesCompareTastingUnlockCta.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Pro'**
  String get winesCompareTastingUnlockCta;

  /// No description provided for @winesCompareTastingEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add tasting notes from either wine to see them compared here.'**
  String get winesCompareTastingEmpty;

  /// No description provided for @winesFormHintName.
  ///
  /// In en, this message translates to:
  /// **'Wine name'**
  String get winesFormHintName;

  /// No description provided for @winesFormSubmitDefault.
  ///
  /// In en, this message translates to:
  /// **'Save wine'**
  String get winesFormSubmitDefault;

  /// No description provided for @winesFormPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get winesFormPhotoLabel;

  /// No description provided for @winesFormStatRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get winesFormStatRating;

  /// No description provided for @winesFormStatRatingUnit.
  ///
  /// In en, this message translates to:
  /// **'/ 10'**
  String get winesFormStatRatingUnit;

  /// No description provided for @winesFormStatPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get winesFormStatPrice;

  /// No description provided for @winesFormStatPriceUnit.
  ///
  /// In en, this message translates to:
  /// **'EUR'**
  String get winesFormStatPriceUnit;

  /// No description provided for @winesFormStatRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get winesFormStatRegion;

  /// No description provided for @winesFormStatCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get winesFormStatCountry;

  /// No description provided for @winesFormChipWinery.
  ///
  /// In en, this message translates to:
  /// **'Winery'**
  String get winesFormChipWinery;

  /// No description provided for @winesFormChipGrape.
  ///
  /// In en, this message translates to:
  /// **'Grape'**
  String get winesFormChipGrape;

  /// No description provided for @winesFormChipYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get winesFormChipYear;

  /// No description provided for @winesFormChipNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get winesFormChipNotes;

  /// No description provided for @winesFormChipNotesFilled.
  ///
  /// In en, this message translates to:
  /// **'Notes ✓'**
  String get winesFormChipNotesFilled;

  /// No description provided for @winesFormPlaceTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add place'**
  String get winesFormPlaceTapToAdd;

  /// No description provided for @winesFormWineryTitle.
  ///
  /// In en, this message translates to:
  /// **'Winery'**
  String get winesFormWineryTitle;

  /// No description provided for @winesFormWineryHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Château Margaux'**
  String get winesFormWineryHint;

  /// No description provided for @winesFormNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasting notes'**
  String get winesFormNotesTitle;

  /// No description provided for @winesFormNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Aromas, body, finish…'**
  String get winesFormNotesHint;

  /// No description provided for @winesFormTypeRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get winesFormTypeRed;

  /// No description provided for @winesFormTypeWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get winesFormTypeWhite;

  /// No description provided for @winesFormTypeRose.
  ///
  /// In en, this message translates to:
  /// **'Rosé'**
  String get winesFormTypeRose;

  /// No description provided for @winesFormTypeSparkling.
  ///
  /// In en, this message translates to:
  /// **'Sparkling'**
  String get winesFormTypeSparkling;

  /// No description provided for @winesMemoriesHeader.
  ///
  /// In en, this message translates to:
  /// **'Memories'**
  String get winesMemoriesHeader;

  /// No description provided for @winesMemoriesHeaderWithCount.
  ///
  /// In en, this message translates to:
  /// **'Memories ({count})'**
  String winesMemoriesHeaderWithCount(int count);

  /// No description provided for @winesMemoriesAddTile.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get winesMemoriesAddTile;

  /// No description provided for @winesMemoriesRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove memory?'**
  String get winesMemoriesRemoveTitle;

  /// No description provided for @winesMemoriesRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove this photo from the wine.'**
  String get winesMemoriesRemoveBody;

  /// No description provided for @winesMemoriesRemoveCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get winesMemoriesRemoveCancel;

  /// No description provided for @winesMemoriesRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get winesMemoriesRemoveConfirm;

  /// No description provided for @winesPhotoSourceTake.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get winesPhotoSourceTake;

  /// No description provided for @winesPhotoSourceGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get winesPhotoSourceGallery;

  /// No description provided for @winesGrapeSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Grape variety'**
  String get winesGrapeSheetTitle;

  /// No description provided for @winesGrapeSheetHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Pinot Noir'**
  String get winesGrapeSheetHint;

  /// No description provided for @winesGrapeSheetUseFreetextPrefix.
  ///
  /// In en, this message translates to:
  /// **'Use \"'**
  String get winesGrapeSheetUseFreetextPrefix;

  /// No description provided for @winesGrapeSheetUseFreetextSuffix.
  ///
  /// In en, this message translates to:
  /// **'\" as custom'**
  String get winesGrapeSheetUseFreetextSuffix;

  /// No description provided for @winesGrapeSheetEmpty.
  ///
  /// In en, this message translates to:
  /// **'No grapes available yet.'**
  String get winesGrapeSheetEmpty;

  /// No description provided for @winesGrapeSheetErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load grape catalog.'**
  String get winesGrapeSheetErrorLoad;

  /// No description provided for @winesGrapeSheetUseTyped.
  ///
  /// In en, this message translates to:
  /// **'Use what I typed'**
  String get winesGrapeSheetUseTyped;

  /// No description provided for @winesRegionSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Wine region'**
  String get winesRegionSheetTitle;

  /// No description provided for @winesRegionSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick where in {country} the wine comes from — or skip if you’re not sure.'**
  String winesRegionSheetSubtitle(String country);

  /// No description provided for @winesRegionSheetSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get winesRegionSheetSkip;

  /// No description provided for @winesRegionSheetSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search region...'**
  String get winesRegionSheetSearchHint;

  /// No description provided for @winesRegionSheetClear.
  ///
  /// In en, this message translates to:
  /// **'Clear region'**
  String get winesRegionSheetClear;

  /// No description provided for @winesRegionSheetOther.
  ///
  /// In en, this message translates to:
  /// **'Other region…'**
  String get winesRegionSheetOther;

  /// No description provided for @winesRegionSheetOtherTitle.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get winesRegionSheetOtherTitle;

  /// No description provided for @winesRegionSheetOtherHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Côtes Catalanes'**
  String get winesRegionSheetOtherHint;

  /// No description provided for @winesCountrySheetSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country...'**
  String get winesCountrySheetSearchHint;

  /// No description provided for @winesCountrySheetTopHeader.
  ///
  /// In en, this message translates to:
  /// **'Top Wine Countries'**
  String get winesCountrySheetTopHeader;

  /// No description provided for @winesCountrySheetOtherHeader.
  ///
  /// In en, this message translates to:
  /// **'Other Countries'**
  String get winesCountrySheetOtherHeader;

  /// No description provided for @winesRatingSheetSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save rating'**
  String get winesRatingSheetSaveCta;

  /// No description provided for @winesRatingSheetCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get winesRatingSheetCancel;

  /// No description provided for @winesRatingSheetSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save.'**
  String get winesRatingSheetSaveError;

  /// No description provided for @winesRatingHeaderLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR RATING'**
  String get winesRatingHeaderLabel;

  /// No description provided for @winesRatingChipTasting.
  ///
  /// In en, this message translates to:
  /// **'Tasting notes'**
  String get winesRatingChipTasting;

  /// No description provided for @winesRatingInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get winesRatingInputLabel;

  /// No description provided for @winesRatingInputMin.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get winesRatingInputMin;

  /// No description provided for @winesRatingInputMax.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get winesRatingInputMax;

  /// No description provided for @winesExpertSheetSaveFirstSnack.
  ///
  /// In en, this message translates to:
  /// **'Save the wine first — tasting notes attach to the canonical id.'**
  String get winesExpertSheetSaveFirstSnack;

  /// No description provided for @winesExpertSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasting notes'**
  String get winesExpertSheetTitle;

  /// No description provided for @winesExpertSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'WSET-style perceptions'**
  String get winesExpertSheetSubtitle;

  /// No description provided for @winesExpertSheetSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get winesExpertSheetSave;

  /// No description provided for @winesExpertAxisBody.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get winesExpertAxisBody;

  /// No description provided for @winesExpertAxisTannin.
  ///
  /// In en, this message translates to:
  /// **'Tannin'**
  String get winesExpertAxisTannin;

  /// No description provided for @winesExpertAxisAcidity.
  ///
  /// In en, this message translates to:
  /// **'Acidity'**
  String get winesExpertAxisAcidity;

  /// No description provided for @winesExpertAxisSweetness.
  ///
  /// In en, this message translates to:
  /// **'Sweetness'**
  String get winesExpertAxisSweetness;

  /// No description provided for @winesExpertAxisOak.
  ///
  /// In en, this message translates to:
  /// **'Oak'**
  String get winesExpertAxisOak;

  /// No description provided for @winesExpertAxisFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get winesExpertAxisFinish;

  /// No description provided for @winesExpertAxisAromas.
  ///
  /// In en, this message translates to:
  /// **'Aromas'**
  String get winesExpertAxisAromas;

  /// No description provided for @winesExpertBodyLow.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get winesExpertBodyLow;

  /// No description provided for @winesExpertBodyHigh.
  ///
  /// In en, this message translates to:
  /// **'full'**
  String get winesExpertBodyHigh;

  /// No description provided for @winesExpertTanninLow.
  ///
  /// In en, this message translates to:
  /// **'soft'**
  String get winesExpertTanninLow;

  /// No description provided for @winesExpertTanninHigh.
  ///
  /// In en, this message translates to:
  /// **'gripping'**
  String get winesExpertTanninHigh;

  /// No description provided for @winesExpertAcidityLow.
  ///
  /// In en, this message translates to:
  /// **'soft'**
  String get winesExpertAcidityLow;

  /// No description provided for @winesExpertAcidityHigh.
  ///
  /// In en, this message translates to:
  /// **'crisp'**
  String get winesExpertAcidityHigh;

  /// No description provided for @winesExpertSweetnessLow.
  ///
  /// In en, this message translates to:
  /// **'dry'**
  String get winesExpertSweetnessLow;

  /// No description provided for @winesExpertSweetnessHigh.
  ///
  /// In en, this message translates to:
  /// **'sweet'**
  String get winesExpertSweetnessHigh;

  /// No description provided for @winesExpertOakLow.
  ///
  /// In en, this message translates to:
  /// **'unoaked'**
  String get winesExpertOakLow;

  /// No description provided for @winesExpertOakHigh.
  ///
  /// In en, this message translates to:
  /// **'heavy'**
  String get winesExpertOakHigh;

  /// No description provided for @winesExpertFinishShort.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get winesExpertFinishShort;

  /// No description provided for @winesExpertFinishMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get winesExpertFinishMedium;

  /// No description provided for @winesExpertFinishLong.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get winesExpertFinishLong;

  /// No description provided for @winesExpertSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'TASTING NOTES'**
  String get winesExpertSummaryHeader;

  /// No description provided for @winesExpertSummaryAromasHeader.
  ///
  /// In en, this message translates to:
  /// **'AROMAS'**
  String get winesExpertSummaryAromasHeader;

  /// No description provided for @winesExpertSummaryAxisBody.
  ///
  /// In en, this message translates to:
  /// **'BODY'**
  String get winesExpertSummaryAxisBody;

  /// No description provided for @winesExpertSummaryAxisTannin.
  ///
  /// In en, this message translates to:
  /// **'TANNIN'**
  String get winesExpertSummaryAxisTannin;

  /// No description provided for @winesExpertSummaryAxisAcidity.
  ///
  /// In en, this message translates to:
  /// **'ACIDITY'**
  String get winesExpertSummaryAxisAcidity;

  /// No description provided for @winesExpertSummaryAxisSweetness.
  ///
  /// In en, this message translates to:
  /// **'SWEETNESS'**
  String get winesExpertSummaryAxisSweetness;

  /// No description provided for @winesExpertSummaryAxisOak.
  ///
  /// In en, this message translates to:
  /// **'OAK'**
  String get winesExpertSummaryAxisOak;

  /// No description provided for @winesExpertSummaryAxisFinish.
  ///
  /// In en, this message translates to:
  /// **'FINISH'**
  String get winesExpertSummaryAxisFinish;

  /// No description provided for @winesExpertDescriptorBody1.
  ///
  /// In en, this message translates to:
  /// **'very light'**
  String get winesExpertDescriptorBody1;

  /// No description provided for @winesExpertDescriptorBody2.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get winesExpertDescriptorBody2;

  /// No description provided for @winesExpertDescriptorBody3.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get winesExpertDescriptorBody3;

  /// No description provided for @winesExpertDescriptorBody4.
  ///
  /// In en, this message translates to:
  /// **'full'**
  String get winesExpertDescriptorBody4;

  /// No description provided for @winesExpertDescriptorBody5.
  ///
  /// In en, this message translates to:
  /// **'heavy'**
  String get winesExpertDescriptorBody5;

  /// No description provided for @winesExpertDescriptorTannin1.
  ///
  /// In en, this message translates to:
  /// **'silky'**
  String get winesExpertDescriptorTannin1;

  /// No description provided for @winesExpertDescriptorTannin2.
  ///
  /// In en, this message translates to:
  /// **'soft'**
  String get winesExpertDescriptorTannin2;

  /// No description provided for @winesExpertDescriptorTannin3.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get winesExpertDescriptorTannin3;

  /// No description provided for @winesExpertDescriptorTannin4.
  ///
  /// In en, this message translates to:
  /// **'firm'**
  String get winesExpertDescriptorTannin4;

  /// No description provided for @winesExpertDescriptorTannin5.
  ///
  /// In en, this message translates to:
  /// **'gripping'**
  String get winesExpertDescriptorTannin5;

  /// No description provided for @winesExpertDescriptorAcidity1.
  ///
  /// In en, this message translates to:
  /// **'flat'**
  String get winesExpertDescriptorAcidity1;

  /// No description provided for @winesExpertDescriptorAcidity2.
  ///
  /// In en, this message translates to:
  /// **'soft'**
  String get winesExpertDescriptorAcidity2;

  /// No description provided for @winesExpertDescriptorAcidity3.
  ///
  /// In en, this message translates to:
  /// **'balanced'**
  String get winesExpertDescriptorAcidity3;

  /// No description provided for @winesExpertDescriptorAcidity4.
  ///
  /// In en, this message translates to:
  /// **'crisp'**
  String get winesExpertDescriptorAcidity4;

  /// No description provided for @winesExpertDescriptorAcidity5.
  ///
  /// In en, this message translates to:
  /// **'sharp'**
  String get winesExpertDescriptorAcidity5;

  /// No description provided for @winesExpertDescriptorSweetness1.
  ///
  /// In en, this message translates to:
  /// **'bone dry'**
  String get winesExpertDescriptorSweetness1;

  /// No description provided for @winesExpertDescriptorSweetness2.
  ///
  /// In en, this message translates to:
  /// **'dry'**
  String get winesExpertDescriptorSweetness2;

  /// No description provided for @winesExpertDescriptorSweetness3.
  ///
  /// In en, this message translates to:
  /// **'off-dry'**
  String get winesExpertDescriptorSweetness3;

  /// No description provided for @winesExpertDescriptorSweetness4.
  ///
  /// In en, this message translates to:
  /// **'sweet'**
  String get winesExpertDescriptorSweetness4;

  /// No description provided for @winesExpertDescriptorSweetness5.
  ///
  /// In en, this message translates to:
  /// **'lush'**
  String get winesExpertDescriptorSweetness5;

  /// No description provided for @winesExpertDescriptorOak1.
  ///
  /// In en, this message translates to:
  /// **'unoaked'**
  String get winesExpertDescriptorOak1;

  /// No description provided for @winesExpertDescriptorOak2.
  ///
  /// In en, this message translates to:
  /// **'subtle'**
  String get winesExpertDescriptorOak2;

  /// No description provided for @winesExpertDescriptorOak3.
  ///
  /// In en, this message translates to:
  /// **'present'**
  String get winesExpertDescriptorOak3;

  /// No description provided for @winesExpertDescriptorOak4.
  ///
  /// In en, this message translates to:
  /// **'oak-forward'**
  String get winesExpertDescriptorOak4;

  /// No description provided for @winesExpertDescriptorOak5.
  ///
  /// In en, this message translates to:
  /// **'heavy'**
  String get winesExpertDescriptorOak5;

  /// No description provided for @winesExpertDescriptorFinish1.
  ///
  /// In en, this message translates to:
  /// **'short'**
  String get winesExpertDescriptorFinish1;

  /// No description provided for @winesExpertDescriptorFinish2.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get winesExpertDescriptorFinish2;

  /// No description provided for @winesExpertDescriptorFinish3.
  ///
  /// In en, this message translates to:
  /// **'long'**
  String get winesExpertDescriptorFinish3;

  /// No description provided for @winesCanonicalPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Same wine?'**
  String get winesCanonicalPromptTitle;

  /// No description provided for @winesCanonicalPromptBody.
  ///
  /// In en, this message translates to:
  /// **'Looks similar to a wine that\'s already in the catalog. Linking them keeps your stats and matches accurate.'**
  String get winesCanonicalPromptBody;

  /// No description provided for @winesCanonicalPromptInputLabel.
  ///
  /// In en, this message translates to:
  /// **'What you\'re adding'**
  String get winesCanonicalPromptInputLabel;

  /// No description provided for @winesCanonicalPromptExistingLabel.
  ///
  /// In en, this message translates to:
  /// **'EXISTING IN CATALOG'**
  String get winesCanonicalPromptExistingLabel;

  /// No description provided for @winesCanonicalPromptDifferent.
  ///
  /// In en, this message translates to:
  /// **'No, this is a different wine'**
  String get winesCanonicalPromptDifferent;

  /// No description provided for @winesFriendRatingsHeader.
  ///
  /// In en, this message translates to:
  /// **'FRIENDS WHO RATED'**
  String get winesFriendRatingsHeader;

  /// No description provided for @winesFriendRatingsFallback.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get winesFriendRatingsFallback;

  /// No description provided for @winesFriendRatingsMore.
  ///
  /// In en, this message translates to:
  /// **'+ {count} more'**
  String winesFriendRatingsMore(int count);

  /// No description provided for @winesFriendRatingsUnit.
  ///
  /// In en, this message translates to:
  /// **'/ 10'**
  String get winesFriendRatingsUnit;

  /// No description provided for @winesTypeFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get winesTypeFilterAll;

  /// No description provided for @winesTypeFilterRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get winesTypeFilterRed;

  /// No description provided for @winesTypeFilterWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get winesTypeFilterWhite;

  /// No description provided for @winesTypeFilterRose.
  ///
  /// In en, this message translates to:
  /// **'Rosé'**
  String get winesTypeFilterRose;

  /// No description provided for @winesTypeFilterSparkling.
  ///
  /// In en, this message translates to:
  /// **'Sparkling'**
  String get winesTypeFilterSparkling;

  /// No description provided for @winesStatsHeader.
  ///
  /// In en, this message translates to:
  /// **'STATS'**
  String get winesStatsHeader;

  /// No description provided for @winesStatsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your wine journey, visualised'**
  String get winesStatsSubtitle;

  /// No description provided for @winesStatsPreviewBadge.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW'**
  String get winesStatsPreviewBadge;

  /// No description provided for @winesStatsPreviewHint.
  ///
  /// In en, this message translates to:
  /// **'What you’ll see after a few ratings.'**
  String get winesStatsPreviewHint;

  /// No description provided for @winesStatsEmptyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get winesStatsEmptyEyebrow;

  /// No description provided for @winesStatsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your stats start with a rating'**
  String get winesStatsEmptyTitle;

  /// No description provided for @winesStatsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Rate your first wine to bring your taste, regions and value to life here.'**
  String get winesStatsEmptyBody;

  /// No description provided for @winesStatsEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Rate a wine'**
  String get winesStatsEmptyCta;

  /// No description provided for @winesStatsHeroLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR AVG'**
  String get winesStatsHeroLabel;

  /// No description provided for @winesStatsHeroUnit.
  ///
  /// In en, this message translates to:
  /// **'/ 10'**
  String get winesStatsHeroUnit;

  /// No description provided for @winesStatsHeroChipPersonal.
  ///
  /// In en, this message translates to:
  /// **'personal'**
  String get winesStatsHeroChipPersonal;

  /// No description provided for @winesStatsHeroChipGroup.
  ///
  /// In en, this message translates to:
  /// **'group'**
  String get winesStatsHeroChipGroup;

  /// No description provided for @winesStatsHeroChipTasting.
  ///
  /// In en, this message translates to:
  /// **'tasting'**
  String get winesStatsHeroChipTasting;

  /// No description provided for @winesStatsSectionTypeBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Wine type breakdown'**
  String get winesStatsSectionTypeBreakdown;

  /// No description provided for @winesStatsSectionTypeBreakdownSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How your taste splits across the four styles.'**
  String get winesStatsSectionTypeBreakdownSubtitle;

  /// No description provided for @winesStatsSectionTopRated.
  ///
  /// In en, this message translates to:
  /// **'Highest rated'**
  String get winesStatsSectionTopRated;

  /// No description provided for @winesStatsSectionTopRatedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal podium.'**
  String get winesStatsSectionTopRatedSubtitle;

  /// No description provided for @winesStatsSectionTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get winesStatsSectionTimeline;

  /// No description provided for @winesStatsSectionTimelineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Month by month, the wines that wrote your year.'**
  String get winesStatsSectionTimelineSubtitle;

  /// No description provided for @winesStatsSectionPartners.
  ///
  /// In en, this message translates to:
  /// **'Drinking partners'**
  String get winesStatsSectionPartners;

  /// No description provided for @winesStatsSectionPartnersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who you taste with most.'**
  String get winesStatsSectionPartnersSubtitle;

  /// No description provided for @winesStatsSectionPrices.
  ///
  /// In en, this message translates to:
  /// **'Prices & value'**
  String get winesStatsSectionPrices;

  /// No description provided for @winesStatsSectionPricesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sum of bottle prices logged on your rated wines — not actual consumption spend.'**
  String get winesStatsSectionPricesSubtitle;

  /// No description provided for @winesStatsSectionPlaces.
  ///
  /// In en, this message translates to:
  /// **'Where you’ve drunk wine'**
  String get winesStatsSectionPlaces;

  /// No description provided for @winesStatsSectionPlacesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every wine you logged with a place.'**
  String get winesStatsSectionPlacesSubtitle;

  /// No description provided for @winesStatsSectionRegions.
  ///
  /// In en, this message translates to:
  /// **'Top regions'**
  String get winesStatsSectionRegions;

  /// No description provided for @winesStatsSectionRegionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where most of your bottles come from.'**
  String get winesStatsSectionRegionsSubtitle;

  /// No description provided for @winesStatsPartnersErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load partners'**
  String get winesStatsPartnersErrorTitle;

  /// No description provided for @winesStatsPartnersErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Pull down or come back in a moment.'**
  String get winesStatsPartnersErrorBody;

  /// No description provided for @winesStatsPartnersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate together'**
  String get winesStatsPartnersEmptyTitle;

  /// No description provided for @winesStatsPartnersEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Once you and a friend rate the same wine in a group, they\'ll show up here.'**
  String get winesStatsPartnersEmptyBody;

  /// No description provided for @winesStatsPartnersCta.
  ///
  /// In en, this message translates to:
  /// **'Open groups'**
  String get winesStatsPartnersCta;

  /// No description provided for @winesStatsPriceEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a price'**
  String get winesStatsPriceEmptyTitle;

  /// No description provided for @winesStatsPriceEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log what you paid on a wine to unlock spend, average cost and best-value picks.'**
  String get winesStatsPriceEmptyBody;

  /// No description provided for @winesStatsPriceEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Edit a wine'**
  String get winesStatsPriceEmptyCta;

  /// No description provided for @winesStatsPlacesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a location'**
  String get winesStatsPlacesEmptyTitle;

  /// No description provided for @winesStatsPlacesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Drop a pin on a wine to start mapping where you drink — bars, dinners, trips.'**
  String get winesStatsPlacesEmptyBody;

  /// No description provided for @winesStatsPlacesEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Edit a wine'**
  String get winesStatsPlacesEmptyCta;

  /// No description provided for @winesStatsRegionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a region'**
  String get winesStatsRegionsEmptyTitle;

  /// No description provided for @winesStatsRegionsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tag wines with a region or country to see where your taste leans.'**
  String get winesStatsRegionsEmptyBody;

  /// No description provided for @winesStatsRegionsEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Edit a wine'**
  String get winesStatsRegionsEmptyCta;

  /// No description provided for @winesStatsPartnersHint.
  ///
  /// In en, this message translates to:
  /// **'Counts wines rated together inside shared groups.'**
  String get winesStatsPartnersHint;

  /// No description provided for @winesStatsPartnersFallback.
  ///
  /// In en, this message translates to:
  /// **'Wine friend'**
  String get winesStatsPartnersFallback;

  /// No description provided for @winesStatsSpendingLabel.
  ///
  /// In en, this message translates to:
  /// **'RATED PORTFOLIO'**
  String get winesStatsSpendingLabel;

  /// No description provided for @winesStatsSpendingSummary.
  ///
  /// In en, this message translates to:
  /// **'across {count, plural, =1{1 priced wine} other{{count} priced wines}} · avg {avg}'**
  String winesStatsSpendingSummary(int count, String avg);

  /// No description provided for @winesStatsSpendingMostExpensive.
  ///
  /// In en, this message translates to:
  /// **'Most expensive'**
  String get winesStatsSpendingMostExpensive;

  /// No description provided for @winesStatsSpendingBestValue.
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get winesStatsSpendingBestValue;

  /// No description provided for @winesStatsRegionsMore.
  ///
  /// In en, this message translates to:
  /// **'+ {count} more'**
  String winesStatsRegionsMore(int count);

  /// No description provided for @winesStatsProLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock 3 more insights'**
  String get winesStatsProLockTitle;

  /// No description provided for @winesStatsProLockBody.
  ///
  /// In en, this message translates to:
  /// **'See where your bottles came from, what you spend, and which regions you back the most.'**
  String get winesStatsProLockBody;

  /// No description provided for @winesStatsProLockPillPrices.
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get winesStatsProLockPillPrices;

  /// No description provided for @winesStatsProLockPillWhere.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get winesStatsProLockPillWhere;

  /// No description provided for @winesStatsProLockPillRegions.
  ///
  /// In en, this message translates to:
  /// **'Top regions'**
  String get winesStatsProLockPillRegions;

  /// No description provided for @winesStatsProLockCta.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Pro'**
  String get winesStatsProLockCta;

  /// No description provided for @winesStatsTimelineEarlierOne.
  ///
  /// In en, this message translates to:
  /// **'+ 1 earlier month'**
  String get winesStatsTimelineEarlierOne;

  /// No description provided for @winesStatsTimelineEarlierMany.
  ///
  /// In en, this message translates to:
  /// **'+ {count} earlier months'**
  String winesStatsTimelineEarlierMany(int count);

  /// No description provided for @winesStatsTimelineWines.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 wine} other{{count} wines}}'**
  String winesStatsTimelineWines(int count);

  /// No description provided for @winesStatsMapPlacesLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 place} other{{count} places}}'**
  String winesStatsMapPlacesLabel(int count);

  /// No description provided for @winesStatsMapClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get winesStatsMapClose;

  /// No description provided for @winesStatsTypeBreakdownTotalOne.
  ///
  /// In en, this message translates to:
  /// **'wine'**
  String get winesStatsTypeBreakdownTotalOne;

  /// No description provided for @winesStatsTypeBreakdownTotalMany.
  ///
  /// In en, this message translates to:
  /// **'wines'**
  String get winesStatsTypeBreakdownTotalMany;

  /// No description provided for @winesStatsTypeBreakdownMostDrunk.
  ///
  /// In en, this message translates to:
  /// **'Most drunk'**
  String get winesStatsTypeBreakdownMostDrunk;

  /// No description provided for @winesStatsTypeBreakdownTopRated.
  ///
  /// In en, this message translates to:
  /// **'Top rated'**
  String get winesStatsTypeBreakdownTopRated;

  /// No description provided for @tastingCreateHeader.
  ///
  /// In en, this message translates to:
  /// **'NEW TASTING'**
  String get tastingCreateHeader;

  /// No description provided for @tastingEditHeader.
  ///
  /// In en, this message translates to:
  /// **'EDIT TASTING'**
  String get tastingEditHeader;

  /// No description provided for @tastingFieldTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get tastingFieldTitleLabel;

  /// No description provided for @tastingFieldDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get tastingFieldDateLabel;

  /// No description provided for @tastingFieldTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get tastingFieldTimeLabel;

  /// No description provided for @tastingFieldPlaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get tastingFieldPlaceLabel;

  /// No description provided for @tastingFieldDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get tastingFieldDescriptionLabel;

  /// No description provided for @tastingFieldTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add'**
  String get tastingFieldTapToAdd;

  /// No description provided for @tastingFieldOpenLineupLabel.
  ///
  /// In en, this message translates to:
  /// **'Open lineup'**
  String get tastingFieldOpenLineupLabel;

  /// No description provided for @tastingFieldOpenLineupHint.
  ///
  /// In en, this message translates to:
  /// **'Add wines as they arrive'**
  String get tastingFieldOpenLineupHint;

  /// No description provided for @tastingTitleSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasting title'**
  String get tastingTitleSheetTitle;

  /// No description provided for @tastingTitleSheetHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Barolo night'**
  String get tastingTitleSheetHint;

  /// No description provided for @tastingDescriptionSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get tastingDescriptionSheetTitle;

  /// No description provided for @tastingDescriptionSheetHint.
  ///
  /// In en, this message translates to:
  /// **'What is this about?'**
  String get tastingDescriptionSheetHint;

  /// No description provided for @tastingCreateSubmitCta.
  ///
  /// In en, this message translates to:
  /// **'Create tasting'**
  String get tastingCreateSubmitCta;

  /// No description provided for @tastingEditSubmitCta.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get tastingEditSubmitCta;

  /// No description provided for @tastingCreateFailedSnack.
  ///
  /// In en, this message translates to:
  /// **'Could not create tasting'**
  String get tastingCreateFailedSnack;

  /// No description provided for @tastingUpdateFailedSnack.
  ///
  /// In en, this message translates to:
  /// **'Could not update tasting'**
  String get tastingUpdateFailedSnack;

  /// No description provided for @tastingDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Tasting not found'**
  String get tastingDetailNotFound;

  /// No description provided for @tastingDetailErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load tasting'**
  String get tastingDetailErrorLoad;

  /// No description provided for @tastingDetailMenuAddToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to calendar'**
  String get tastingDetailMenuAddToCalendar;

  /// No description provided for @tastingDetailMenuShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get tastingDetailMenuShare;

  /// No description provided for @tastingDetailMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit tasting'**
  String get tastingDetailMenuEdit;

  /// No description provided for @tastingDetailMenuCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel tasting'**
  String get tastingDetailMenuCancel;

  /// No description provided for @tastingDetailCancelDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel tasting?'**
  String get tastingDetailCancelDialogTitle;

  /// No description provided for @tastingDetailCancelDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This removes it for everyone.'**
  String get tastingDetailCancelDialogBody;

  /// No description provided for @tastingDetailCancelDialogKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get tastingDetailCancelDialogKeep;

  /// No description provided for @tastingDetailCancelDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get tastingDetailCancelDialogConfirm;

  /// No description provided for @tastingDetailEndDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'End tasting?'**
  String get tastingDetailEndDialogTitle;

  /// No description provided for @tastingDetailEndDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This locks the recap. Attendees can still add ratings briefly afterwards.'**
  String get tastingDetailEndDialogBody;

  /// No description provided for @tastingDetailEndDialogKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get tastingDetailEndDialogKeep;

  /// No description provided for @tastingDetailEndDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get tastingDetailEndDialogConfirm;

  /// No description provided for @tastingCalendarFailedSnack.
  ///
  /// In en, this message translates to:
  /// **'Could not open calendar'**
  String get tastingCalendarFailedSnack;

  /// No description provided for @tastingLifecycleUpcoming.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING'**
  String get tastingLifecycleUpcoming;

  /// No description provided for @tastingLifecycleLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get tastingLifecycleLive;

  /// No description provided for @tastingLifecycleConcluded.
  ///
  /// In en, this message translates to:
  /// **'CONCLUDED'**
  String get tastingLifecycleConcluded;

  /// No description provided for @tastingLifecycleStartCta.
  ///
  /// In en, this message translates to:
  /// **'Start tasting'**
  String get tastingLifecycleStartCta;

  /// No description provided for @tastingLifecycleEndCta.
  ///
  /// In en, this message translates to:
  /// **'End tasting'**
  String get tastingLifecycleEndCta;

  /// No description provided for @tastingDetailSectionPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get tastingDetailSectionPeople;

  /// No description provided for @tastingDetailSectionPlace.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get tastingDetailSectionPlace;

  /// No description provided for @tastingDetailSectionWines.
  ///
  /// In en, this message translates to:
  /// **'WINES'**
  String get tastingDetailSectionWines;

  /// No description provided for @tastingDetailAddWines.
  ///
  /// In en, this message translates to:
  /// **'Add wines'**
  String get tastingDetailAddWines;

  /// No description provided for @tastingDetailNoAttendees.
  ///
  /// In en, this message translates to:
  /// **'No one invited yet.'**
  String get tastingDetailNoAttendees;

  /// No description provided for @tastingDetailUnknownAttendee.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get tastingDetailUnknownAttendee;

  /// No description provided for @tastingDetailRsvpYour.
  ///
  /// In en, this message translates to:
  /// **'Your response'**
  String get tastingDetailRsvpYour;

  /// No description provided for @tastingDetailRsvpGoing.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get tastingDetailRsvpGoing;

  /// No description provided for @tastingDetailRsvpMaybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get tastingDetailRsvpMaybe;

  /// No description provided for @tastingDetailRsvpDeclined.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get tastingDetailRsvpDeclined;

  /// No description provided for @tastingDetailAttendeesCountGoing.
  ///
  /// In en, this message translates to:
  /// **'{count} going'**
  String tastingDetailAttendeesCountGoing(int count);

  /// No description provided for @tastingDetailAttendeesCountMaybe.
  ///
  /// In en, this message translates to:
  /// **'{count} maybe'**
  String tastingDetailAttendeesCountMaybe(int count);

  /// No description provided for @tastingDetailAttendeesCountDeclined.
  ///
  /// In en, this message translates to:
  /// **'{count} declined'**
  String tastingDetailAttendeesCountDeclined(int count);

  /// No description provided for @tastingDetailAttendeesCountPending.
  ///
  /// In en, this message translates to:
  /// **'{count} pending'**
  String tastingDetailAttendeesCountPending(int count);

  /// No description provided for @tastingDetailAttendeesSheetGoing.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get tastingDetailAttendeesSheetGoing;

  /// No description provided for @tastingDetailAttendeesSheetMaybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get tastingDetailAttendeesSheetMaybe;

  /// No description provided for @tastingDetailAttendeesSheetDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get tastingDetailAttendeesSheetDeclined;

  /// No description provided for @tastingDetailAttendeesSheetPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get tastingDetailAttendeesSheetPending;

  /// No description provided for @tastingEmptyOpenActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Lineup fills as you go'**
  String get tastingEmptyOpenActiveTitle;

  /// No description provided for @tastingEmptyOpenActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Anyone going can add bottles as they appear'**
  String get tastingEmptyOpenActiveBody;

  /// No description provided for @tastingEmptyDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'No wines lined up yet'**
  String get tastingEmptyDefaultTitle;

  /// No description provided for @tastingEmptyOpenUpcomingHost.
  ///
  /// In en, this message translates to:
  /// **'Wines can be added once the tasting starts'**
  String get tastingEmptyOpenUpcomingHost;

  /// No description provided for @tastingEmptyOpenUpcomingGuest.
  ///
  /// In en, this message translates to:
  /// **'Wines will be added on the night'**
  String get tastingEmptyOpenUpcomingGuest;

  /// No description provided for @tastingEmptyPlannedHost.
  ///
  /// In en, this message translates to:
  /// **'Tap “Add wines” to build the lineup'**
  String get tastingEmptyPlannedHost;

  /// No description provided for @tastingEmptyPlannedGuest.
  ///
  /// In en, this message translates to:
  /// **'The host hasn’t added wines yet'**
  String get tastingEmptyPlannedGuest;

  /// No description provided for @tastingRecapResultsHeader.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get tastingRecapResultsHeader;

  /// No description provided for @tastingRecapShareCta.
  ///
  /// In en, this message translates to:
  /// **'Share recap'**
  String get tastingRecapShareCta;

  /// No description provided for @tastingRecapTopWineEyebrow.
  ///
  /// In en, this message translates to:
  /// **'TOP WINE OF THE NIGHT'**
  String get tastingRecapTopWineEyebrow;

  /// No description provided for @tastingRecapEmpty.
  ///
  /// In en, this message translates to:
  /// **'No ratings submitted for this tasting yet.'**
  String get tastingRecapEmpty;

  /// No description provided for @tastingRecapRowNoRatings.
  ///
  /// In en, this message translates to:
  /// **'no ratings'**
  String get tastingRecapRowNoRatings;

  /// No description provided for @tastingRecapGroupFallback.
  ///
  /// In en, this message translates to:
  /// **'Group tasting'**
  String get tastingRecapGroupFallback;

  /// No description provided for @tastingPickerSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add wines to lineup'**
  String get tastingPickerSheetTitle;

  /// No description provided for @tastingPickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no wines yet.'**
  String get tastingPickerEmpty;

  /// No description provided for @tastingPickerErrorFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wines.'**
  String get tastingPickerErrorFallback;

  /// No description provided for @tastingPickerSubmitDefault.
  ///
  /// In en, this message translates to:
  /// **'Add wines'**
  String get tastingPickerSubmitDefault;

  /// No description provided for @tastingPickerSubmitWithCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Add 1 wine} other{Add {count} wines}}'**
  String tastingPickerSubmitWithCount(int count);

  /// No description provided for @tastingPickerAddedChip.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get tastingPickerAddedChip;

  /// No description provided for @groupListHeader.
  ///
  /// In en, this message translates to:
  /// **'GROUPS'**
  String get groupListHeader;

  /// No description provided for @groupListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Taste together'**
  String get groupListSubtitle;

  /// No description provided for @groupListSortRecent.
  ///
  /// In en, this message translates to:
  /// **'Sort: recent'**
  String get groupListSortRecent;

  /// No description provided for @groupListSortName.
  ///
  /// In en, this message translates to:
  /// **'Sort: name'**
  String get groupListSortName;

  /// No description provided for @groupListCreateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get groupListCreateTooltip;

  /// No description provided for @groupListJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join a group'**
  String get groupListJoinTitle;

  /// No description provided for @groupListJoinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter an invite code'**
  String get groupListJoinSubtitle;

  /// No description provided for @groupListJoinNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group not found'**
  String get groupListJoinNotFound;

  /// No description provided for @groupListErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load groups'**
  String get groupListErrorLoad;

  /// No description provided for @groupListEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get groupListEmptyTitle;

  /// No description provided for @groupListEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create or join one to share wines'**
  String get groupListEmptyBody;

  /// No description provided for @groupListEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get groupListEmptyCta;

  /// No description provided for @groupCreateSourceCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get groupCreateSourceCamera;

  /// No description provided for @groupCreateSourceGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get groupCreateSourceGallery;

  /// No description provided for @groupCreateSourceRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get groupCreateSourceRemovePhoto;

  /// No description provided for @groupCreatePickFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Pick failed.'**
  String get groupCreatePickFailedFallback;

  /// No description provided for @groupCreateUploadFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Photo upload failed.'**
  String get groupCreateUploadFailedFallback;

  /// No description provided for @groupCreateFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t create group. Try again.'**
  String get groupCreateFailedFallback;

  /// No description provided for @groupCreateSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String groupCreateSaveFailed(String error);

  /// No description provided for @groupCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get groupCreateTitle;

  /// No description provided for @groupCreateNameHint.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get groupCreateNameHint;

  /// No description provided for @groupCreateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get groupCreateSubmit;

  /// No description provided for @groupJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get groupJoinTitle;

  /// No description provided for @groupJoinHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. a1b2c3d4'**
  String get groupJoinHint;

  /// No description provided for @groupJoinSubmit.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get groupJoinSubmit;

  /// No description provided for @groupDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group not found'**
  String get groupDetailNotFound;

  /// No description provided for @groupDetailErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load group'**
  String get groupDetailErrorLoad;

  /// No description provided for @groupDetailSectionSharedWines.
  ///
  /// In en, this message translates to:
  /// **'Shared wines'**
  String get groupDetailSectionSharedWines;

  /// No description provided for @groupDetailSectionTastings.
  ///
  /// In en, this message translates to:
  /// **'Tastings'**
  String get groupDetailSectionTastings;

  /// No description provided for @groupDetailActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get groupDetailActionShare;

  /// No description provided for @groupDetailActionPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get groupDetailActionPlan;

  /// No description provided for @groupDetailMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit group'**
  String get groupDetailMenuEdit;

  /// No description provided for @groupDetailMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete group'**
  String get groupDetailMenuDelete;

  /// No description provided for @groupDetailMenuLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave group'**
  String get groupDetailMenuLeave;

  /// No description provided for @groupDetailLeaveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave group?'**
  String get groupDetailLeaveDialogTitle;

  /// No description provided for @groupDetailLeaveDialogBody.
  ///
  /// In en, this message translates to:
  /// **'You can rejoin later with the invite code.'**
  String get groupDetailLeaveDialogBody;

  /// No description provided for @groupDetailLeaveDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailLeaveDialogCancel;

  /// No description provided for @groupDetailLeaveDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get groupDetailLeaveDialogConfirm;

  /// No description provided for @groupDetailDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete group?'**
  String get groupDetailDeleteDialogTitle;

  /// No description provided for @groupDetailDeleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'The group and its shared wines will be removed for everyone.'**
  String get groupDetailDeleteDialogBody;

  /// No description provided for @groupDetailDeleteDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailDeleteDialogCancel;

  /// No description provided for @groupDetailDeleteDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get groupDetailDeleteDialogConfirm;

  /// No description provided for @groupSettingsEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit group'**
  String get groupSettingsEditTitle;

  /// No description provided for @groupSettingsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get groupSettingsNameLabel;

  /// No description provided for @groupSettingsSourceCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get groupSettingsSourceCamera;

  /// No description provided for @groupSettingsSourceGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get groupSettingsSourceGallery;

  /// No description provided for @groupSettingsRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get groupSettingsRemovePhoto;

  /// No description provided for @groupSettingsUploadFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Upload failed.'**
  String get groupSettingsUploadFailedFallback;

  /// No description provided for @groupSettingsDeleteFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Delete failed.'**
  String get groupSettingsDeleteFailedFallback;

  /// No description provided for @groupSettingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String groupSettingsSaveFailed(String error);

  /// No description provided for @groupSettingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get groupSettingsSave;

  /// No description provided for @groupInviteEyebrow.
  ///
  /// In en, this message translates to:
  /// **'INVITE'**
  String get groupInviteEyebrow;

  /// No description provided for @groupInviteFriendsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'INVITE FRIENDS'**
  String get groupInviteFriendsEyebrow;

  /// No description provided for @groupInviteCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied'**
  String get groupInviteCodeCopied;

  /// No description provided for @groupInviteShareMessage.
  ///
  /// In en, this message translates to:
  /// **'Join \"{groupName}\" on Sippd 🍷\n\n{url}\n\nOr enter code: {code}'**
  String groupInviteShareMessage(String groupName, String url, String code);

  /// No description provided for @groupInviteShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Join {groupName} on Sippd'**
  String groupInviteShareSubject(String groupName);

  /// No description provided for @groupInviteActionCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get groupInviteActionCopy;

  /// No description provided for @groupInviteActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share link'**
  String get groupInviteActionShare;

  /// No description provided for @groupInviteFriendsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No friends available to invite.'**
  String get groupInviteFriendsEmpty;

  /// No description provided for @groupInviteFriendsErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load friends'**
  String get groupInviteFriendsErrorLoad;

  /// No description provided for @groupInviteFriendFallback.
  ///
  /// In en, this message translates to:
  /// **'friend'**
  String get groupInviteFriendFallback;

  /// No description provided for @groupInviteUnknownName.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get groupInviteUnknownName;

  /// No description provided for @groupInviteSentSnack.
  ///
  /// In en, this message translates to:
  /// **'Invite sent to {name}'**
  String groupInviteSentSnack(String name);

  /// No description provided for @groupInviteSendFailedFallback.
  ///
  /// In en, this message translates to:
  /// **'Could not send invite.'**
  String get groupInviteSendFailedFallback;

  /// No description provided for @groupInvitationsHeader.
  ///
  /// In en, this message translates to:
  /// **'INVITATIONS'**
  String get groupInvitationsHeader;

  /// No description provided for @groupInvitationsInviterFallback.
  ///
  /// In en, this message translates to:
  /// **'Someone'**
  String get groupInvitationsInviterFallback;

  /// No description provided for @groupInvitationsInvitedBy.
  ///
  /// In en, this message translates to:
  /// **'Invited by {name}'**
  String groupInvitationsInvitedBy(String name);

  /// No description provided for @groupInvitationsDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get groupInvitationsDecline;

  /// No description provided for @groupInvitationsAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get groupInvitationsAccept;

  /// No description provided for @groupInvitationsJoinedSnack.
  ///
  /// In en, this message translates to:
  /// **'Joined {name}'**
  String groupInvitationsJoinedSnack(String name);

  /// No description provided for @groupInvitationsAcceptFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not accept invitation'**
  String get groupInvitationsAcceptFailed;

  /// No description provided for @groupMembersCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 member'**
  String get groupMembersCountOne;

  /// No description provided for @groupMembersCountMany.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String groupMembersCountMany(int count);

  /// No description provided for @groupMembersUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get groupMembersUnknown;

  /// No description provided for @groupMembersOwnerBadge.
  ///
  /// In en, this message translates to:
  /// **'OWNER'**
  String get groupMembersOwnerBadge;

  /// No description provided for @groupWineCarouselDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get groupWineCarouselDetails;

  /// No description provided for @groupWineCarouselEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No wines shared yet'**
  String get groupWineCarouselEmptyTitle;

  /// No description provided for @groupWineCarouselEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Pick one from your cellar to kick off the list.'**
  String get groupWineCarouselEmptyBody;

  /// No description provided for @groupWineCarouselEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Share a wine'**
  String get groupWineCarouselEmptyCta;

  /// No description provided for @groupWineTypeRed.
  ///
  /// In en, this message translates to:
  /// **'RED'**
  String get groupWineTypeRed;

  /// No description provided for @groupWineTypeWhite.
  ///
  /// In en, this message translates to:
  /// **'WHITE'**
  String get groupWineTypeWhite;

  /// No description provided for @groupWineTypeRose.
  ///
  /// In en, this message translates to:
  /// **'ROSÉ'**
  String get groupWineTypeRose;

  /// No description provided for @groupWineTypeSparkling.
  ///
  /// In en, this message translates to:
  /// **'SPARKLING'**
  String get groupWineTypeSparkling;

  /// No description provided for @groupWineRatingSaveFirstSnack.
  ///
  /// In en, this message translates to:
  /// **'Save the wine first — tasting notes attach to it.'**
  String get groupWineRatingSaveFirstSnack;

  /// No description provided for @groupWineRatingNoCanonical.
  ///
  /// In en, this message translates to:
  /// **'Wine has no canonical identity yet — try again.'**
  String get groupWineRatingNoCanonical;

  /// No description provided for @groupWineRatingNoCanonicalShort.
  ///
  /// In en, this message translates to:
  /// **'Wine has no canonical identity yet.'**
  String get groupWineRatingNoCanonicalShort;

  /// No description provided for @groupWineRatingNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get groupWineRatingNotesHint;

  /// No description provided for @groupWineRatingOfflineRetry.
  ///
  /// In en, this message translates to:
  /// **'Offline · Retry'**
  String get groupWineRatingOfflineRetry;

  /// No description provided for @groupWineRatingSaveFailedRetry.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save · Retry'**
  String get groupWineRatingSaveFailedRetry;

  /// No description provided for @groupWineRatingSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved ✓'**
  String get groupWineRatingSaved;

  /// No description provided for @groupWineRatingSaveCta.
  ///
  /// In en, this message translates to:
  /// **'Save rating'**
  String get groupWineRatingSaveCta;

  /// No description provided for @groupWineRatingRemoveMine.
  ///
  /// In en, this message translates to:
  /// **'Remove my rating'**
  String get groupWineRatingRemoveMine;

  /// No description provided for @groupWineRatingUnshareDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from group?'**
  String get groupWineRatingUnshareDialogTitle;

  /// No description provided for @groupWineRatingUnshareDialogBody.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be removed from this group. Ratings from members will also be deleted.'**
  String groupWineRatingUnshareDialogBody(String name);

  /// No description provided for @groupWineRatingUnshareCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupWineRatingUnshareCancel;

  /// No description provided for @groupWineRatingUnshareConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get groupWineRatingUnshareConfirm;

  /// No description provided for @groupWineRatingMoreTooltip.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get groupWineRatingMoreTooltip;

  /// No description provided for @groupWineRatingUnshareMenu.
  ///
  /// In en, this message translates to:
  /// **'Remove from group'**
  String get groupWineRatingUnshareMenu;

  /// No description provided for @groupWineRatingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get groupWineRatingsTitle;

  /// No description provided for @groupWineRatingsCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 rating'**
  String get groupWineRatingsCountOne;

  /// No description provided for @groupWineRatingsCountMany.
  ///
  /// In en, this message translates to:
  /// **'{count} ratings'**
  String groupWineRatingsCountMany(int count);

  /// No description provided for @groupWineRatingsAvgLabel.
  ///
  /// In en, this message translates to:
  /// **'avg'**
  String get groupWineRatingsAvgLabel;

  /// No description provided for @groupWineRatingsBeFirst.
  ///
  /// In en, this message translates to:
  /// **'Be the first to rate'**
  String get groupWineRatingsBeFirst;

  /// No description provided for @groupWineRatingsSoloMe.
  ///
  /// In en, this message translates to:
  /// **'You\'re the first · invite others to rate'**
  String get groupWineRatingsSoloMe;

  /// No description provided for @groupShareWineTitle.
  ///
  /// In en, this message translates to:
  /// **'Share a wine'**
  String get groupShareWineTitle;

  /// No description provided for @groupShareWineErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load wines.'**
  String get groupShareWineErrorLoad;

  /// No description provided for @groupShareWineEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no wines yet.'**
  String get groupShareWineEmpty;

  /// No description provided for @groupShareWineSharedChip.
  ///
  /// In en, this message translates to:
  /// **'Shared'**
  String get groupShareWineSharedChip;

  /// No description provided for @groupShareWineSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Share to group'**
  String get groupShareWineSheetTitle;

  /// No description provided for @groupShareWineSheetEmpty.
  ///
  /// In en, this message translates to:
  /// **'You are not in any groups yet.'**
  String get groupShareWineSheetEmpty;

  /// No description provided for @groupShareWineSheetErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load groups.'**
  String get groupShareWineSheetErrorLoad;

  /// No description provided for @groupShareWineSheetAlreadyShared.
  ///
  /// In en, this message translates to:
  /// **'Already shared'**
  String get groupShareWineSheetAlreadyShared;

  /// No description provided for @groupShareWineSheetSharedSnack.
  ///
  /// In en, this message translates to:
  /// **'Shared to {name}'**
  String groupShareWineSheetSharedSnack(String name);

  /// No description provided for @groupShareWineRowMemberOne.
  ///
  /// In en, this message translates to:
  /// **'1 member'**
  String get groupShareWineRowMemberOne;

  /// No description provided for @groupShareWineRowMemberMany.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String groupShareWineRowMemberMany(int count);

  /// No description provided for @groupShareWineRowWineOne.
  ///
  /// In en, this message translates to:
  /// **'1 wine'**
  String get groupShareWineRowWineOne;

  /// No description provided for @groupShareWineRowWineMany.
  ///
  /// In en, this message translates to:
  /// **'{count} wines'**
  String groupShareWineRowWineMany(int count);

  /// No description provided for @groupShareMatchTitle.
  ///
  /// In en, this message translates to:
  /// **'Already in this group'**
  String get groupShareMatchTitle;

  /// No description provided for @groupShareMatchBody.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" looks like a wine a member already shared. Is it the same wine?'**
  String groupShareMatchBody(String name);

  /// No description provided for @groupShareMatchNone.
  ///
  /// In en, this message translates to:
  /// **'None of these — share separately'**
  String get groupShareMatchNone;

  /// No description provided for @groupShareMatchCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupShareMatchCancel;

  /// No description provided for @groupShareMatchSharedBy.
  ///
  /// In en, this message translates to:
  /// **'Shared by @{username}'**
  String groupShareMatchSharedBy(String username);

  /// No description provided for @groupFriendActionsInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite to a group'**
  String get groupFriendActionsInvite;

  /// No description provided for @groupFriendActionsPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite {name} to…'**
  String groupFriendActionsPickerTitle(String name);

  /// No description provided for @groupFriendActionsPickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No groups to invite to. Create or join one first.'**
  String get groupFriendActionsPickerEmpty;

  /// No description provided for @groupFriendActionsPickerErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load groups'**
  String get groupFriendActionsPickerErrorLoad;

  /// No description provided for @groupCalendarPastToggle.
  ///
  /// In en, this message translates to:
  /// **'Past tastings ({count})'**
  String groupCalendarPastToggle(int count);

  /// No description provided for @groupCalendarEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No tastings yet'**
  String get groupCalendarEmptyTitle;

  /// No description provided for @groupCalendarEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Schedule one to gather the group over a bottle.'**
  String get groupCalendarEmptyBody;

  /// No description provided for @groupCalendarEmptyCta.
  ///
  /// In en, this message translates to:
  /// **'Plan a tasting'**
  String get groupCalendarEmptyCta;

  /// No description provided for @groupWineDetailSectionRatings.
  ///
  /// In en, this message translates to:
  /// **'GROUP RATINGS'**
  String get groupWineDetailSectionRatings;

  /// No description provided for @groupWineDetailEmptyRatings.
  ///
  /// In en, this message translates to:
  /// **'No group ratings yet.'**
  String get groupWineDetailEmptyRatings;

  /// No description provided for @groupWineDetailStatGroupAvg.
  ///
  /// In en, this message translates to:
  /// **'Group avg'**
  String get groupWineDetailStatGroupAvg;

  /// No description provided for @groupWineDetailStatRatings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get groupWineDetailStatRatings;

  /// No description provided for @groupWineDetailStatNoRatings.
  ///
  /// In en, this message translates to:
  /// **'No ratings'**
  String get groupWineDetailStatNoRatings;

  /// No description provided for @groupWineDetailStatRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get groupWineDetailStatRegion;

  /// No description provided for @groupWineDetailStatCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get groupWineDetailStatCountry;

  /// No description provided for @groupWineDetailStatOrigin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get groupWineDetailStatOrigin;

  /// No description provided for @groupWineDetailSharedByEyebrow.
  ///
  /// In en, this message translates to:
  /// **'SHARED BY'**
  String get groupWineDetailSharedByEyebrow;

  /// No description provided for @groupWineDetailSharerFallback.
  ///
  /// In en, this message translates to:
  /// **'someone'**
  String get groupWineDetailSharerFallback;

  /// No description provided for @groupWineDetailMemberFallback.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get groupWineDetailMemberFallback;

  /// No description provided for @groupWineDetailRelJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get groupWineDetailRelJustNow;

  /// No description provided for @groupWineDetailRelMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String groupWineDetailRelMinutes(int count);

  /// No description provided for @groupWineDetailRelHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String groupWineDetailRelHours(int count);

  /// No description provided for @groupWineDetailRelDays.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String groupWineDetailRelDays(int count);

  /// No description provided for @groupWineDetailRelWeeks.
  ///
  /// In en, this message translates to:
  /// **'{count}w ago'**
  String groupWineDetailRelWeeks(int count);

  /// No description provided for @groupWineDetailRelMonths.
  ///
  /// In en, this message translates to:
  /// **'{count}mo ago'**
  String groupWineDetailRelMonths(int count);

  /// No description provided for @groupWineDetailRelYears.
  ///
  /// In en, this message translates to:
  /// **'{count}y ago'**
  String groupWineDetailRelYears(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

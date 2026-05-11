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

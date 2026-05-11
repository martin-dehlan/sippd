// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notificationsLoadError =>
      'Benachrichtigungseinstellungen konnten nicht geladen werden';

  @override
  String get sectionTastings => 'Tastings';

  @override
  String get sectionFriends => 'Freunde';

  @override
  String get sectionGroups => 'Gruppen';

  @override
  String get tileTastingRemindersLabel => 'Tasting-Erinnerungen';

  @override
  String get tileTastingRemindersSubtitle => 'Push vor Beginn eines Tastings';

  @override
  String get tileFriendActivityLabel => 'Freundesaktivität';

  @override
  String get tileFriendActivitySubtitle => 'Anfragen und Bestätigungen';

  @override
  String get tileGroupActivityLabel => 'Gruppenaktivität';

  @override
  String get tileGroupActivitySubtitle =>
      'Einladungen, Beitritte und neue Tastings';

  @override
  String get tileGroupWineSharedLabel => 'Neuer Wein geteilt';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Wenn ein Freund einen Wein zu deiner Gruppe hinzufügt';

  @override
  String get hoursPickerLabel => 'Benachrichtige mich';

  @override
  String get hoursPickerHint =>
      'Gilt für alle anstehenden Tastings — jederzeit änderbar.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · Debug';

  @override
  String get profileTileLanguageLabel => 'Sprache';

  @override
  String get languageSheetTitle => 'Sprache wählen';

  @override
  String get languageOptionSystem => 'Systemsprache';

  @override
  String get onbWelcomeTitle => 'Dein Wein-\ngedächtnis.';

  @override
  String get onbWelcomeBody =>
      'Bewerte die Weine, die du liebst. Vergiss sie nie. Verkoste sie mit Freunden.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Schon ein Konto? ';

  @override
  String get onbWelcomeSignIn => 'Anmelden';

  @override
  String get onbWhyEyebrow => 'Warum Sippd';

  @override
  String get onbWhyTitle => 'Für Leute,\ndie wirklich Wein trinken.';

  @override
  String get onbWhyPrinciple1Headline => 'Knipsen. Bewerten. Erinnern.';

  @override
  String get onbWhyPrinciple1Line => 'Drei Tipps, nächstes Jahr wiederfinden.';

  @override
  String get onbWhyPrinciple2Headline => 'Tastings mit Freunden.';

  @override
  String get onbWhyPrinciple2Line =>
      'Blindverkostungen, gemeinsame Bewertungen. Ohne Tabellen.';

  @override
  String get onbWhyPrinciple3Headline => 'Funktioniert offline.';

  @override
  String get onbWhyPrinciple3Line =>
      'Überall loggen. Synct, sobald du zu Hause bist.';

  @override
  String get onbLevelEyebrow => 'Über dich';

  @override
  String get onbLevelTitle => 'Wie tief steckst\ndu im Wein?';

  @override
  String get onbLevelSubtitle =>
      'Keine falsche Antwort. Wir passen Vorschläge an dein Tempo an.';

  @override
  String get onbLevelBeginnerLabel => 'Anfänger';

  @override
  String get onbLevelBeginnerSubtitle => 'Gerade angefangen';

  @override
  String get onbLevelCuriousLabel => 'Neugierig';

  @override
  String get onbLevelCuriousSubtitle => 'Ein paar Favoriten';

  @override
  String get onbLevelEnthusiastLabel => 'Enthusiast';

  @override
  String get onbLevelEnthusiastSubtitle => 'Ich weiß, was ich mag';

  @override
  String get onbLevelProLabel => 'Profi';

  @override
  String get onbLevelProSubtitle => 'Sommelier-Niveau';

  @override
  String get onbFreqEyebrow => 'Dein Rhythmus';

  @override
  String get onbFreqTitle => 'Wie oft öffnest\ndu eine Flasche?';

  @override
  String get onbFreqWeekly => 'Wöchentlich';

  @override
  String get onbFreqMonthly => 'Ein paar Mal im Monat';

  @override
  String get onbFreqRare => 'Hin und wieder';

  @override
  String get onbGoalsEyebrow => 'Deine Ziele';

  @override
  String get onbGoalsTitle => 'Was willst du\nvon Sippd?';

  @override
  String get onbGoalsSubtitle =>
      'Wähle eins oder mehrere. Kannst du später ändern.';

  @override
  String get onbGoalRemember => 'Lieblingsflaschen merken';

  @override
  String get onbGoalDiscover => 'Neue Stile entdecken';

  @override
  String get onbGoalSocial => 'Mit Freunden verkosten';

  @override
  String get onbGoalValue => 'Im Blick behalten, was ich zahle';

  @override
  String get onbStylesEyebrow => 'Deine Stile';

  @override
  String get onbStylesTitle => 'Wonach\ngreifst du?';

  @override
  String get onbStylesSubtitle =>
      'Wähle, was zu dir passt. Wir behalten deine Picks im Auge.';

  @override
  String get wineTypeRed => 'Rot';

  @override
  String get wineTypeWhite => 'Weiß';

  @override
  String get wineTypeRose => 'Rosé';

  @override
  String get wineTypeSparkling => 'Schaumwein';

  @override
  String get onbRespEyebrow => 'Eine Notiz von uns';

  @override
  String get onbRespTitle => 'Weniger trinken,\nmehr schmecken.';

  @override
  String get onbRespSubtitle =>
      'Sippd ist da, um Weine zu merken und zu bewerten, die du genossen hast — nicht, um Druck zu machen, mehr zu trinken. Keine Streaks, keine Tages-Quoten. Absichtlich.';

  @override
  String get onbRespHelpBody =>
      'Wenn Alkohol dich oder jemanden in deiner Nähe verletzt,\ngibt es kostenlose, vertrauliche Hilfe.';

  @override
  String get onbRespHelpCta => 'Hilfe finden';

  @override
  String get onbNameEyebrow => 'Fast geschafft';

  @override
  String get onbNameTitle => 'Wie sollen wir\ndich nennen?';

  @override
  String get onbNameSubtitle =>
      'Vorname, Spitzname — was passt. Wähl auch ein Icon.';

  @override
  String get onbNameHint => 'Dein Name';

  @override
  String get onbNameIconLabel => 'Wähl dein Icon';

  @override
  String get onbNameIconSubtitle => 'Erscheint als dein Avatar.';

  @override
  String get onbNotifEyebrow => 'Bleib am Ball';

  @override
  String get onbNotifTitle => 'Verpass nie wieder\neine gute Flasche.';

  @override
  String get onbNotifSubtitle =>
      'Wir melden uns, wenn Freunde ein Tasting starten oder dich in Gruppen einladen. Jederzeit abschaltbar.';

  @override
  String get onbNotifPreview =>
      'Tasting-Einladungen\nGruppen-Bewertungen\nFreundes-Aktivität';

  @override
  String get onbNotifTurnOn => 'Benachrichtigungen aktivieren';

  @override
  String get onbNotifNotNow => 'Nicht jetzt';

  @override
  String get onbLoaderAlmostThere => 'FAST GESCHAFFT';

  @override
  String get onbLoaderCrafting => 'Wir bauen dein Profil.';

  @override
  String get onbLoaderAllSet => 'Fertig.';

  @override
  String get onbLoaderStepMatching => 'Wir matchen deinen Geschmack';

  @override
  String get onbLoaderStepCurating => 'Wir kuratieren deine Stile';

  @override
  String get onbLoaderStepSetting => 'Wir richten dein Journal ein';

  @override
  String get onbLoaderSeeProfile => 'Profil ansehen';

  @override
  String get onbLoaderContinue => 'Weiter';

  @override
  String get onbResultsEyebrow => 'DEIN GESCHMACKSPROFIL';

  @override
  String get onbResultsLevelCard => 'Level';

  @override
  String get onbResultsFreqCard => 'Frequenz';

  @override
  String get onbResultsStylesCard => 'Stile';

  @override
  String get onbResultsGoalsCard => 'Ziele';

  @override
  String get onbArchSommTitle => 'Erfahrener Sommelier';

  @override
  String get onbArchSommSubtitle =>
      'Du kennst dein Terroir. Sippd merkt sich die Belege.';

  @override
  String get onbArchPalateTitle => 'Feiner Gaumen';

  @override
  String get onbArchPalateSubtitle =>
      'Nuancen-Jäger. Sippd hält die Details fest.';

  @override
  String get onbArchRegularTitle => 'Keller-Stammgast';

  @override
  String get onbArchRegularSubtitle =>
      'Eine Flasche pro Woche, Meinungen werden monatlich schärfer.';

  @override
  String get onbArchDevotedTitle => 'Hingegebener Verkoster';

  @override
  String get onbArchDevotedSubtitle =>
      'Ernsthaft bei jedem Schluck. Sippd behält deine Notizen.';

  @override
  String get onbArchRedTitle => 'Rotwein-Loyalist';

  @override
  String get onbArchRedSubtitle =>
      'Eine Traube pro Glas. Wir helfen dir, dich zu öffnen.';

  @override
  String get onbArchBubbleTitle => 'Bubble-Jäger';

  @override
  String get onbArchBubbleSubtitle =>
      'Perlen vor allem. Sippd merkt sich die guten.';

  @override
  String get onbArchOpenTitle => 'Offener Gaumen';

  @override
  String get onbArchOpenSubtitle =>
      'Rot, Weiß, Rosé, Sekt — alles willkommen. Log sie alle.';

  @override
  String get onbArchSteadyTitle => 'Treuer Schlückler';

  @override
  String get onbArchSteadySubtitle =>
      'Wein bleibt in der Rotation. Sippd hält den Faden.';

  @override
  String get onbArchNowAndThenTitle => 'Gelegenheits-Verkoster';

  @override
  String get onbArchNowAndThenSubtitle => 'Wein für die Momente, die zählen.';

  @override
  String get onbArchOccasionalTitle => 'Seltenes Glas';

  @override
  String get onbArchOccasionalSubtitle =>
      'Seltener Schluck, wert, erinnert zu werden.';

  @override
  String get onbArchFreshTitle => 'Frischer Gaumen';

  @override
  String get onbArchFreshSubtitle => 'Neuer Weg. Jede Flasche zählt ab hier.';

  @override
  String get onbArchCuriousTitle => 'Wein-Neugierig';

  @override
  String get onbArchCuriousSubtitle =>
      'Erzähl uns mehr, dein Profil wird schärfer.';

  @override
  String get onbCtaGetStarted => 'Loslegen';

  @override
  String get onbCtaIUnderstand => 'Verstanden';

  @override
  String get onbCtaContinue => 'Weiter';

  @override
  String get onbCtaSignInToSave => 'Anmelden zum Speichern';

  @override
  String get onbCtaSaveAndContinue => 'Speichern & weiter';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Level';

  @override
  String get tasteEditorFreq => 'Wie oft';

  @override
  String get tasteEditorStyles => 'Lieblings-Stile';

  @override
  String get tasteEditorGoals => 'Worauf du aus bist';

  @override
  String get tasteEditorFreqWeekly => 'Wöchentlich';

  @override
  String get tasteEditorFreqMonthly => 'Monatlich';

  @override
  String get tasteEditorFreqRare => 'Selten';

  @override
  String get tasteEditorGoalRemember => 'Merken';

  @override
  String get tasteEditorGoalDiscover => 'Entdecken';

  @override
  String get tasteEditorGoalSocial => 'Sozial';

  @override
  String get tasteEditorGoalValue => 'Preis';
}

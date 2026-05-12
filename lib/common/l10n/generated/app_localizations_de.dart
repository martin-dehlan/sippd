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

  @override
  String get authLoginWelcomeBack => 'Willkommen zurück';

  @override
  String get authLoginCreateAccount => 'Konto erstellen';

  @override
  String get authLoginDisplayNameLabel => 'Anzeigename';

  @override
  String get authLoginEmailLabel => 'E-Mail';

  @override
  String get authLoginPasswordLabel => 'Passwort';

  @override
  String get authLoginConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get authLoginDisplayNameMin => 'Mind. 2 Zeichen';

  @override
  String get authLoginDisplayNameMax => 'Max. 30 Zeichen';

  @override
  String get authLoginEmailInvalid => 'Gültige E-Mail erforderlich';

  @override
  String get authLoginPasswordMin => 'Mind. 8 Zeichen';

  @override
  String get authLoginPasswordRequired => 'Passwort eingeben';

  @override
  String get authLoginPasswordsDontMatch => 'Passwörter stimmen nicht überein';

  @override
  String get authLoginForgotPassword => 'Passwort vergessen?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Gib oben zuerst eine gültige E-Mail ein.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Konto konnte nicht erstellt werden. Versuch\'s nochmal.';

  @override
  String get authLoginSignInFailedFallback =>
      'Anmeldung fehlgeschlagen. Prüf deine Daten.';

  @override
  String get authLoginCreateAccountButton => 'Konto erstellen';

  @override
  String get authLoginSignInButton => 'Anmelden';

  @override
  String get authLoginToggleHaveAccount => 'Schon ein Konto? Anmelden';

  @override
  String get authLoginToggleNoAccount => 'Noch kein Konto? Registrieren';

  @override
  String get authOrDivider => 'oder';

  @override
  String get authGoogleContinue => 'Mit Google fortfahren';

  @override
  String get authGoogleFailed =>
      'Google-Anmeldung fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get authConfTitleReset => 'Reset-Link gesendet';

  @override
  String get authConfTitleSignup => 'Check dein Postfach';

  @override
  String get authConfIntroReset => 'Wir haben einen Reset-Link gesendet an';

  @override
  String get authConfIntroSignup =>
      'Wir haben einen Bestätigungslink gesendet an';

  @override
  String get authConfOutroReset =>
      '.\nTipp drauf, um ein neues Passwort zu setzen.';

  @override
  String get authConfOutroSignup =>
      '.\nTipp drauf, um dein Konto zu aktivieren.';

  @override
  String get authConfOpenMailApp => 'Mail-App öffnen';

  @override
  String get authConfResendEmail => 'E-Mail erneut senden';

  @override
  String get authConfResendSending => 'Senden…';

  @override
  String authConfResendIn(int seconds) {
    return 'Erneut in ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'E-Mail gesendet.';

  @override
  String get authConfResendFailedFallback =>
      'Senden fehlgeschlagen. Versuch\'s gleich nochmal.';

  @override
  String get authConfBackToSignIn => 'Zurück zur Anmeldung';

  @override
  String get authResetTitle => 'Neues Passwort setzen';

  @override
  String get authResetSubtitle =>
      'Wähl ein Passwort, das du noch nicht benutzt hast.';

  @override
  String get authResetNewPasswordLabel => 'Neues Passwort';

  @override
  String get authResetConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get authResetPasswordMin => 'Mind. 6 Zeichen';

  @override
  String get authResetPasswordsDontMatch => 'Passwörter stimmen nicht überein';

  @override
  String get authResetFailedFallback =>
      'Passwort konnte nicht aktualisiert werden. Nochmal versuchen.';

  @override
  String get authResetUpdateButton => 'Passwort aktualisieren';

  @override
  String get authResetUpdatedSnack => 'Passwort aktualisiert.';

  @override
  String get authProfileGuest => 'Gast';

  @override
  String get authProfileSectionAccount => 'Konto';

  @override
  String get authProfileSectionSupport => 'Support';

  @override
  String get authProfileSectionLegal => 'Rechtliches';

  @override
  String get authProfileEditProfile => 'Profil bearbeiten';

  @override
  String get authProfileFriends => 'Freunde';

  @override
  String get authProfileNotifications => 'Benachrichtigungen';

  @override
  String get authProfileCleanupDuplicates => 'Duplikate aufräumen';

  @override
  String get authProfileSubscription => 'Abo';

  @override
  String get authProfileChangePassword => 'Passwort ändern';

  @override
  String get authProfileContactUs => 'Kontaktiere uns';

  @override
  String get authProfileRateSippd => 'Sippd bewerten';

  @override
  String get authProfilePrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get authProfileTermsOfService => 'Nutzungsbedingungen';

  @override
  String get authProfileSignOut => 'Abmelden';

  @override
  String get authProfileSignIn => 'Anmelden';

  @override
  String get authProfileDeleteAccount => 'Konto löschen';

  @override
  String get authProfileViewFullStats => 'Alle Stats ansehen';

  @override
  String get authProfileChangePasswordDialogTitle => 'Passwort ändern?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'Wir senden einen Reset-Link an $email. Tipp aus dem Postfach drauf, um ein neues Passwort zu setzen.';
  }

  @override
  String get authProfileCancel => 'Abbrechen';

  @override
  String get authProfileSendLink => 'Link senden';

  @override
  String get authProfileSendLinkFailedTitle =>
      'Link konnte nicht gesendet werden';

  @override
  String get authProfileSendLinkFailedFallback => 'Versuch\'s gleich nochmal.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return '$url konnte nicht geöffnet werden';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Konto löschen?';

  @override
  String get authProfileDeleteDialogBody =>
      'Dies löscht dein Profil, Weine, Bewertungen, Tastings, Gruppenmitgliedschaften und Freunde dauerhaft. Kann nicht rückgängig gemacht werden.';

  @override
  String get authProfileDeleteTypeConfirm => 'Tipp DELETE zur Bestätigung:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Löschen';

  @override
  String get authProfileDeleteFailedFallback => 'Löschen fehlgeschlagen.';

  @override
  String get winesListSubtitle => 'Dein Wein-Ranking';

  @override
  String get winesListSortRating => 'Sortierung: Bewertung';

  @override
  String get winesListSortRecent => 'Sortierung: Neueste';

  @override
  String get winesListSortName => 'Sortierung: Name';

  @override
  String get winesListTooltipStats => 'Deine Stats';

  @override
  String get winesListTooltipAddWine => 'Wein hinzufügen';

  @override
  String get winesListErrorLoad => 'Weine konnten nicht geladen werden';

  @override
  String get winesEmptyTitle => 'Noch keine Weine';

  @override
  String get winesEmptyFilteredTitle => 'Kein Wein passt zum Filter';

  @override
  String get winesEmptyFilteredBody => 'Versuch einen anderen Filter';

  @override
  String get winesEmptyAddWineCta => 'Wein hinzufügen';

  @override
  String get winesAddSaveLabel => 'Wein speichern';

  @override
  String get winesAddDiscardTitle => 'Wein verwerfen?';

  @override
  String get winesAddDiscardBody =>
      'Du hast diesen Wein noch nicht gespeichert. Beim Verlassen gehen deine Änderungen verloren.';

  @override
  String get winesAddDiscardKeepEditing => 'Weiter bearbeiten';

  @override
  String get winesAddDiscardConfirm => 'Verwerfen';

  @override
  String get winesAddDuplicateTitle => 'Sieht nach einem Duplikat aus';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Du hast „$name“ schon mit demselben Jahrgang, Weingut und derselben Rebsorte erfasst. Bestehenden Eintrag öffnen oder trotzdem neu anlegen?';
  }

  @override
  String get winesAddDuplicateCancel => 'Abbrechen';

  @override
  String get winesAddDuplicateAddAnyway => 'Trotzdem anlegen';

  @override
  String get winesAddDuplicateOpenExisting => 'Bestehenden öffnen';

  @override
  String get winesDetailNotFound => 'Wein nicht gefunden';

  @override
  String get winesDetailErrorLoad => 'Wein konnte nicht geladen werden';

  @override
  String get winesDetailMenuCompare => 'Vergleichen mit …';

  @override
  String get winesDetailMenuShareRating => 'Bewertung teilen';

  @override
  String get winesDetailMenuShareToGroup => 'In Gruppe teilen';

  @override
  String get winesDetailMenuEdit => 'Wein bearbeiten';

  @override
  String get winesDetailMenuTastingNotesPro => 'Tasting-Notes (Pro)';

  @override
  String get winesDetailMenuDelete => 'Wein löschen';

  @override
  String get winesDetailStatRating => 'Bewertung';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Preis';

  @override
  String get winesDetailStatRegion => 'Region';

  @override
  String get winesDetailStatCountry => 'Land';

  @override
  String get winesDetailSectionNotes => 'NOTIZEN';

  @override
  String get winesDetailSectionPlace => 'ORT';

  @override
  String get winesDetailPlaceEmpty => 'Kein Ort hinterlegt';

  @override
  String get winesDetailDeleteTitle => 'Wein löschen?';

  @override
  String get winesDetailDeleteBody => 'Das lässt sich nicht rückgängig machen.';

  @override
  String get winesDetailDeleteCancel => 'Abbrechen';

  @override
  String get winesDetailDeleteConfirm => 'Löschen';

  @override
  String get winesEditErrorLoad => 'Wein konnte nicht geladen werden';

  @override
  String get winesEditErrorMemories =>
      'Erinnerungen konnten nicht geladen werden';

  @override
  String get winesEditNotFound => 'Wein nicht gefunden';

  @override
  String get winesCleanupTitle => 'Duplikate aufräumen';

  @override
  String get winesCleanupErrorLoad => 'Duplikate konnten nicht geladen werden';

  @override
  String get winesCleanupEmptyTitle => 'Keine Duplikate zum Aufräumen';

  @override
  String get winesCleanupEmptyBody =>
      'Deine Weine sind sauber. Wir prüfen automatisch auf ähnliche Namen und Weingüter.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% Übereinstimmung';
  }

  @override
  String get winesCleanupKeepA => 'A behalten';

  @override
  String get winesCleanupKeepB => 'B behalten';

  @override
  String get winesCleanupSkippedSnack =>
      'Übersprungen — erscheint beim nächsten Besuch erneut.';

  @override
  String get winesCleanupDifferentWines => 'Das sind verschiedene Weine';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'In „$name“ zusammenführen?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Jede Bewertung, jedes Teilen und jede Statistik, die auf „$loser“ zeigte, wandert zu „$keeper“. Das lässt sich nicht rückgängig machen.';
  }

  @override
  String get winesCleanupMergeCancel => 'Abbrechen';

  @override
  String get winesCleanupMergeConfirm => 'Zusammenführen';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'In „$name“ zusammengeführt.';
  }

  @override
  String get winesCleanupMergeFailedFallback =>
      'Zusammenführen fehlgeschlagen.';

  @override
  String get winesCompareHeader => 'VERGLEICH';

  @override
  String get winesComparePickerSubtitle => 'Wähl den zweiten Wein.';

  @override
  String get winesComparePickerEmptyTitle => 'Noch keine weiteren Weine';

  @override
  String get winesComparePickerEmptyBody =>
      'Füg mindestens einen weiteren Wein hinzu, um zu vergleichen.';

  @override
  String get winesComparePickerErrorFallback =>
      'Weine konnten nicht geladen werden.';

  @override
  String get winesCompareMissingSameWine =>
      'Wähl einen anderen Wein zum Vergleichen.';

  @override
  String get winesCompareMissingDefault =>
      'Beide Weine konnten nicht geladen werden.';

  @override
  String get winesCompareErrorFallback => 'Weine konnten nicht geladen werden.';

  @override
  String get winesCompareSectionAtAGlance => 'Auf einen Blick';

  @override
  String get winesCompareSectionTasting => 'Tasting-Profil';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Körper, Tannin, Säure, Süße, Holz, Abgang.';

  @override
  String get winesCompareSectionNotes => 'Notizen';

  @override
  String get winesCompareAttrType => 'TYP';

  @override
  String get winesCompareAttrVintage => 'JAHRGANG';

  @override
  String get winesCompareAttrGrape => 'REBSORTE';

  @override
  String get winesCompareAttrOrigin => 'HERKUNFT';

  @override
  String get winesCompareAttrPrice => 'PREIS';

  @override
  String get winesCompareNotesEyebrow => 'NOTIZEN';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'WEIN $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Sieh Körper, Tannin, Säure und mehr direkt nebeneinander.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Mit Pro freischalten';

  @override
  String get winesCompareTastingEmpty =>
      'Füg bei einem der Weine Tasting-Notes hinzu, um sie hier verglichen zu sehen.';

  @override
  String get winesFormHintName => 'Weinname';

  @override
  String get winesFormSubmitDefault => 'Wein speichern';

  @override
  String get winesFormPhotoLabel => 'Foto';

  @override
  String get winesFormStatRating => 'Bewertung';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Preis';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Region';

  @override
  String get winesFormStatCountry => 'Land';

  @override
  String get winesFormChipWinery => 'Weingut';

  @override
  String get winesFormChipGrape => 'Rebsorte';

  @override
  String get winesFormChipYear => 'Jahr';

  @override
  String get winesFormChipNotes => 'Notizen';

  @override
  String get winesFormChipNotesFilled => 'Notizen ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Tippen, um Ort hinzuzufügen';

  @override
  String get winesFormWineryTitle => 'Weingut';

  @override
  String get winesFormWineryHint => 'z. B. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Tasting-Notes';

  @override
  String get winesFormNotesHint => 'Aromen, Körper, Abgang …';

  @override
  String get winesFormTypeRed => 'Rot';

  @override
  String get winesFormTypeWhite => 'Weiß';

  @override
  String get winesFormTypeRose => 'Rosé';

  @override
  String get winesFormTypeSparkling => 'Schaumwein';

  @override
  String get winesMemoriesHeader => 'Erinnerungen';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Erinnerungen ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Hinzufügen';

  @override
  String get winesMemoriesRemoveTitle => 'Erinnerung entfernen?';

  @override
  String get winesMemoriesRemoveBody =>
      'Damit verschwindet dieses Foto vom Wein.';

  @override
  String get winesMemoriesRemoveCancel => 'Abbrechen';

  @override
  String get winesMemoriesRemoveConfirm => 'Entfernen';

  @override
  String get winesPhotoSourceTake => 'Foto aufnehmen';

  @override
  String get winesPhotoSourceGallery => 'Aus Galerie wählen';

  @override
  String get winesGrapeSheetTitle => 'Rebsorte';

  @override
  String get winesGrapeSheetHint => 'z. B. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => '„';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '“ als eigenen Eintrag';

  @override
  String get winesGrapeSheetEmpty => 'Noch keine Rebsorten verfügbar.';

  @override
  String get winesGrapeSheetErrorLoad =>
      'Rebsorten-Katalog konnte nicht geladen werden.';

  @override
  String get winesGrapeSheetUseTyped => 'Eingegebenes übernehmen';

  @override
  String get winesRegionSheetTitle => 'Weinregion';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Wähl, aus welcher Region in $country der Wein stammt — oder überspring es, wenn du unsicher bist.';
  }

  @override
  String get winesRegionSheetSkip => 'Überspringen';

  @override
  String get winesRegionSheetSearchHint => 'Region suchen …';

  @override
  String get winesRegionSheetClear => 'Region löschen';

  @override
  String get winesRegionSheetOther => 'Andere Region …';

  @override
  String get winesRegionSheetOtherTitle => 'Region';

  @override
  String get winesRegionSheetOtherHint => 'z. B. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Land suchen …';

  @override
  String get winesCountrySheetTopHeader => 'Top-Weinländer';

  @override
  String get winesCountrySheetOtherHeader => 'Weitere Länder';

  @override
  String get winesRatingSheetSaveCta => 'Bewertung speichern';

  @override
  String get winesRatingSheetCancel => 'Abbrechen';

  @override
  String get winesRatingSheetSaveError => 'Speichern fehlgeschlagen.';

  @override
  String get winesRatingHeaderLabel => 'DEINE BEWERTUNG';

  @override
  String get winesRatingChipTasting => 'Tasting-Notes';

  @override
  String get winesRatingInputLabel => 'Bewertung';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Speicher den Wein zuerst — Tasting-Notes hängen an der Canonical-ID.';

  @override
  String get winesExpertSheetTitle => 'Tasting-Notes';

  @override
  String get winesExpertSheetSubtitle => 'WSET-Wahrnehmungen';

  @override
  String get winesExpertSheetSave => 'Speichern';

  @override
  String get winesExpertAxisBody => 'Körper';

  @override
  String get winesExpertAxisTannin => 'Tannin';

  @override
  String get winesExpertAxisAcidity => 'Säure';

  @override
  String get winesExpertAxisSweetness => 'Süße';

  @override
  String get winesExpertAxisOak => 'Holz';

  @override
  String get winesExpertAxisFinish => 'Abgang';

  @override
  String get winesExpertAxisAromas => 'Aromen';

  @override
  String get winesExpertBodyLow => 'leicht';

  @override
  String get winesExpertBodyHigh => 'voll';

  @override
  String get winesExpertTanninLow => 'weich';

  @override
  String get winesExpertTanninHigh => 'fest';

  @override
  String get winesExpertAcidityLow => 'weich';

  @override
  String get winesExpertAcidityHigh => 'frisch';

  @override
  String get winesExpertSweetnessLow => 'trocken';

  @override
  String get winesExpertSweetnessHigh => 'süß';

  @override
  String get winesExpertOakLow => 'ohne Holz';

  @override
  String get winesExpertOakHigh => 'stark';

  @override
  String get winesExpertFinishShort => 'Kurz';

  @override
  String get winesExpertFinishMedium => 'Mittel';

  @override
  String get winesExpertFinishLong => 'Lang';

  @override
  String get winesExpertSummaryHeader => 'TASTING-NOTES';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMEN';

  @override
  String get winesExpertSummaryAxisBody => 'KÖRPER';

  @override
  String get winesExpertSummaryAxisTannin => 'TANNIN';

  @override
  String get winesExpertSummaryAxisAcidity => 'SÄURE';

  @override
  String get winesExpertSummaryAxisSweetness => 'SÜSSE';

  @override
  String get winesExpertSummaryAxisOak => 'HOLZ';

  @override
  String get winesExpertSummaryAxisFinish => 'ABGANG';

  @override
  String get winesExpertDescriptorBody1 => 'sehr leicht';

  @override
  String get winesExpertDescriptorBody2 => 'leicht';

  @override
  String get winesExpertDescriptorBody3 => 'mittel';

  @override
  String get winesExpertDescriptorBody4 => 'voll';

  @override
  String get winesExpertDescriptorBody5 => 'schwer';

  @override
  String get winesExpertDescriptorTannin1 => 'seidig';

  @override
  String get winesExpertDescriptorTannin2 => 'weich';

  @override
  String get winesExpertDescriptorTannin3 => 'mittel';

  @override
  String get winesExpertDescriptorTannin4 => 'fest';

  @override
  String get winesExpertDescriptorTannin5 => 'packend';

  @override
  String get winesExpertDescriptorAcidity1 => 'flach';

  @override
  String get winesExpertDescriptorAcidity2 => 'weich';

  @override
  String get winesExpertDescriptorAcidity3 => 'ausgewogen';

  @override
  String get winesExpertDescriptorAcidity4 => 'frisch';

  @override
  String get winesExpertDescriptorAcidity5 => 'scharf';

  @override
  String get winesExpertDescriptorSweetness1 => 'knochentrocken';

  @override
  String get winesExpertDescriptorSweetness2 => 'trocken';

  @override
  String get winesExpertDescriptorSweetness3 => 'halbtrocken';

  @override
  String get winesExpertDescriptorSweetness4 => 'süß';

  @override
  String get winesExpertDescriptorSweetness5 => 'üppig';

  @override
  String get winesExpertDescriptorOak1 => 'ohne Holz';

  @override
  String get winesExpertDescriptorOak2 => 'dezent';

  @override
  String get winesExpertDescriptorOak3 => 'präsent';

  @override
  String get winesExpertDescriptorOak4 => 'holzbetont';

  @override
  String get winesExpertDescriptorOak5 => 'stark';

  @override
  String get winesExpertDescriptorFinish1 => 'kurz';

  @override
  String get winesExpertDescriptorFinish2 => 'mittel';

  @override
  String get winesExpertDescriptorFinish3 => 'lang';

  @override
  String get winesCanonicalPromptTitle => 'Derselbe Wein?';

  @override
  String get winesCanonicalPromptBody =>
      'Sieht ähnlich aus zu einem Wein, der schon im Katalog ist. Verknüpfen hält deine Stats und Matches sauber.';

  @override
  String get winesCanonicalPromptInputLabel => 'Was du hinzufügst';

  @override
  String get winesCanonicalPromptExistingLabel => 'BEREITS IM KATALOG';

  @override
  String get winesCanonicalPromptDifferent => 'Nein, das ist ein anderer Wein';

  @override
  String get winesFriendRatingsHeader => 'FREUNDE, DIE BEWERTET HABEN';

  @override
  String get winesFriendRatingsFallback => 'Freund:in';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count weitere';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Alle';

  @override
  String get winesTypeFilterRed => 'Rot';

  @override
  String get winesTypeFilterWhite => 'Weiß';

  @override
  String get winesTypeFilterRose => 'Rosé';

  @override
  String get winesTypeFilterSparkling => 'Schaumwein';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Deine Wein-Reise, sichtbar gemacht';

  @override
  String get winesStatsPreviewBadge => 'VORSCHAU';

  @override
  String get winesStatsPreviewHint =>
      'Das siehst du nach ein paar Bewertungen.';

  @override
  String get winesStatsEmptyEyebrow => 'LOS GEHT’S';

  @override
  String get winesStatsEmptyTitle => 'Deine Stats starten mit einer Bewertung';

  @override
  String get winesStatsEmptyBody =>
      'Bewerte deinen ersten Wein, um Geschmack, Regionen und Wert hier sichtbar zu machen.';

  @override
  String get winesStatsEmptyCta => 'Wein bewerten';

  @override
  String get winesStatsHeroLabel => 'DEIN SCHNITT';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'persönlich';

  @override
  String get winesStatsHeroChipGroup => 'Gruppe';

  @override
  String get winesStatsHeroChipTasting => 'Tasting';

  @override
  String get winesStatsSectionTypeBreakdown => 'Weintypen-Verteilung';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Wie sich dein Geschmack auf die vier Stile aufteilt.';

  @override
  String get winesStatsSectionTopRated => 'Beste Bewertungen';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Dein persönliches Podest.';

  @override
  String get winesStatsSectionTimeline => 'Timeline';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Monat für Monat — die Weine, die dein Jahr geprägt haben.';

  @override
  String get winesStatsSectionPartners => 'Trinkpartner:innen';

  @override
  String get winesStatsSectionPartnersSubtitle =>
      'Mit wem du am meisten verkostest.';

  @override
  String get winesStatsSectionPrices => 'Preise & Wert';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Summe der hinterlegten Flaschenpreise deiner bewerteten Weine — nicht der tatsächliche Konsum.';

  @override
  String get winesStatsSectionPlaces => 'Wo du Wein getrunken hast';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Jeder Wein, den du mit einem Ort erfasst hast.';

  @override
  String get winesStatsSectionRegions => 'Top-Regionen';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'Woher die meisten deiner Flaschen kommen.';

  @override
  String get winesStatsPartnersErrorTitle =>
      'Partner konnten nicht geladen werden';

  @override
  String get winesStatsPartnersErrorBody =>
      'Zieh runter oder komm gleich nochmal vorbei.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Gemeinsam bewerten';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Sobald du und ein:e Freund:in denselben Wein in einer Gruppe bewertet, taucht sie:er hier auf.';

  @override
  String get winesStatsPartnersCta => 'Gruppen öffnen';

  @override
  String get winesStatsPriceEmptyTitle => 'Preis hinzufügen';

  @override
  String get winesStatsPriceEmptyBody =>
      'Trag ein, was du gezahlt hast — und schalt damit Ausgaben, Schnitt und Best-Value-Picks frei.';

  @override
  String get winesStatsPriceEmptyCta => 'Wein bearbeiten';

  @override
  String get winesStatsPlacesEmptyTitle => 'Ort hinzufügen';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Setz einen Pin auf einen Wein, um deine Wein-Orte zu kartieren — Bars, Dinner, Trips.';

  @override
  String get winesStatsPlacesEmptyCta => 'Wein bearbeiten';

  @override
  String get winesStatsRegionsEmptyTitle => 'Region hinzufügen';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Markier Weine mit Region oder Land, um zu sehen, wohin dein Geschmack lehnt.';

  @override
  String get winesStatsRegionsEmptyCta => 'Wein bearbeiten';

  @override
  String get winesStatsPartnersHint =>
      'Zählt Weine, die ihr gemeinsam in Gruppen bewertet habt.';

  @override
  String get winesStatsPartnersFallback => 'Wein-Freund:in';

  @override
  String get winesStatsSpendingLabel => 'BEWERTETES PORTFOLIO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Weine mit Preis',
      one: '1 Wein mit Preis',
    );
    return 'über $_temp0 · Ø $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Teuerster';

  @override
  String get winesStatsSpendingBestValue => 'Bestes P/L';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count weitere';
  }

  @override
  String get winesStatsProLockTitle => 'Schalt 3 weitere Insights frei';

  @override
  String get winesStatsProLockBody =>
      'Sieh, woher deine Flaschen kommen, was du ausgibst und welche Regionen du am meisten unterstützt.';

  @override
  String get winesStatsProLockPillPrices => 'Preise';

  @override
  String get winesStatsProLockPillWhere => 'Wo';

  @override
  String get winesStatsProLockPillRegions => 'Top-Regionen';

  @override
  String get winesStatsProLockCta => 'Mit Pro freischalten';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 früherer Monat';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count frühere Monate';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Weine',
      one: '1 Wein',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Orte',
      one: '1 Ort',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Schließen';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'Wein';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'Weine';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Am meisten getrunken';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Best bewertet';

  @override
  String get tastingCreateHeader => 'NEUE VERKOSTUNG';

  @override
  String get tastingEditHeader => 'VERKOSTUNG BEARBEITEN';

  @override
  String get tastingFieldTitleLabel => 'Titel';

  @override
  String get tastingFieldDateLabel => 'Datum';

  @override
  String get tastingFieldTimeLabel => 'Uhrzeit';

  @override
  String get tastingFieldPlaceLabel => 'Ort';

  @override
  String get tastingFieldDescriptionLabel => 'Beschreibung';

  @override
  String get tastingFieldTapToAdd => 'Tippen zum Hinzufügen';

  @override
  String get tastingFieldOpenLineupLabel => 'Offenes Line-up';

  @override
  String get tastingFieldOpenLineupHint =>
      'Weine kommen dazu, wie sie aufgemacht werden';

  @override
  String get tastingTitleSheetTitle => 'Titel der Verkostung';

  @override
  String get tastingTitleSheetHint => 'z. B. Barolo-Abend';

  @override
  String get tastingDescriptionSheetTitle => 'Beschreibung';

  @override
  String get tastingDescriptionSheetHint => 'Worum geht’s?';

  @override
  String get tastingCreateSubmitCta => 'Verkostung anlegen';

  @override
  String get tastingEditSubmitCta => 'Änderungen speichern';

  @override
  String get tastingCreateFailedSnack =>
      'Verkostung konnte nicht angelegt werden';

  @override
  String get tastingUpdateFailedSnack =>
      'Verkostung konnte nicht aktualisiert werden';

  @override
  String get tastingDetailNotFound => 'Verkostung nicht gefunden';

  @override
  String get tastingDetailErrorLoad => 'Verkostung konnte nicht geladen werden';

  @override
  String get tastingDetailMenuAddToCalendar => 'Zum Kalender hinzufügen';

  @override
  String get tastingDetailMenuShare => 'Teilen';

  @override
  String get tastingDetailMenuEdit => 'Verkostung bearbeiten';

  @override
  String get tastingDetailMenuCancel => 'Verkostung absagen';

  @override
  String get tastingDetailCancelDialogTitle => 'Verkostung absagen?';

  @override
  String get tastingDetailCancelDialogBody =>
      'Damit wird sie für alle entfernt.';

  @override
  String get tastingDetailCancelDialogKeep => 'Behalten';

  @override
  String get tastingDetailCancelDialogConfirm => 'Absagen';

  @override
  String get tastingDetailEndDialogTitle => 'Verkostung beenden?';

  @override
  String get tastingDetailEndDialogBody =>
      'Damit wird das Recap gesperrt. Teilnehmende können kurz danach noch Bewertungen abgeben.';

  @override
  String get tastingDetailEndDialogKeep => 'Weitermachen';

  @override
  String get tastingDetailEndDialogConfirm => 'Beenden';

  @override
  String get tastingCalendarFailedSnack =>
      'Kalender konnte nicht geöffnet werden';

  @override
  String get tastingLifecycleUpcoming => 'GEPLANT';

  @override
  String get tastingLifecycleLive => 'LIVE';

  @override
  String get tastingLifecycleConcluded => 'BEENDET';

  @override
  String get tastingLifecycleStartCta => 'Verkostung starten';

  @override
  String get tastingLifecycleEndCta => 'Verkostung beenden';

  @override
  String get tastingDetailSectionPeople => 'Leute';

  @override
  String get tastingDetailSectionPlace => 'Ort';

  @override
  String get tastingDetailSectionWines => 'WEINE';

  @override
  String get tastingDetailAddWines => 'Weine hinzufügen';

  @override
  String get tastingDetailNoAttendees => 'Noch niemand eingeladen.';

  @override
  String get tastingDetailUnknownAttendee => 'Unbekannt';

  @override
  String get tastingDetailRsvpYour => 'Deine Antwort';

  @override
  String get tastingDetailRsvpGoing => 'Dabei';

  @override
  String get tastingDetailRsvpMaybe => 'Vielleicht';

  @override
  String get tastingDetailRsvpDeclined => 'Nein';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count dabei';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count vielleicht';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count abgesagt';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count ausstehend';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Dabei';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Vielleicht';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'Abgesagt';

  @override
  String get tastingDetailAttendeesSheetPending => 'Ausstehend';

  @override
  String get tastingEmptyOpenActiveTitle => 'Das Line-up wächst nach und nach';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Alle Dabei-Gäste können Flaschen ergänzen';

  @override
  String get tastingEmptyDefaultTitle => 'Noch keine Weine im Line-up';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Weine können hinzugefügt werden, sobald die Verkostung startet';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Weine werden am Abend selbst hinzugefügt';

  @override
  String get tastingEmptyPlannedHost =>
      'Tippe auf „Weine hinzufügen“, um das Line-up zu bauen';

  @override
  String get tastingEmptyPlannedGuest =>
      'Der Host hat noch keine Weine hinzugefügt';

  @override
  String get tastingRecapResultsHeader => 'ERGEBNISSE';

  @override
  String get tastingRecapShareCta => 'Recap teilen';

  @override
  String get tastingRecapTopWineEyebrow => 'WEIN DES ABENDS';

  @override
  String get tastingRecapEmpty =>
      'Für diese Verkostung wurden noch keine Bewertungen abgegeben.';

  @override
  String get tastingRecapRowNoRatings => 'keine Bewertungen';

  @override
  String get tastingRecapGroupFallback => 'Gruppenverkostung';

  @override
  String get tastingPickerSheetTitle => 'Weine zum Line-up hinzufügen';

  @override
  String get tastingPickerEmpty => 'Du hast noch keine Weine.';

  @override
  String get tastingPickerErrorFallback =>
      'Weine konnten nicht geladen werden.';

  @override
  String get tastingPickerSubmitDefault => 'Weine hinzufügen';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Weine hinzufügen',
      one: '1 Wein hinzufügen',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Hinzugefügt';
}

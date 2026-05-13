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
  String get onbWelcomeTitle => 'Deine Wein-\nmomente.';

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
  String get winesDetailSectionPlace => 'ORTE';

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
  String get winesEditErrorMemories => 'Momente konnten nicht geladen werden';

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
  String get winesMemoriesHeader => 'Momente';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Momente ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Hinzufügen';

  @override
  String get winesMemoriesRemoveTitle => 'Moment entfernen?';

  @override
  String get winesMemoriesRemoveBody =>
      'Damit verschwindet dieser Moment vom Wein.';

  @override
  String get winesMemoriesRemoveCancel => 'Abbrechen';

  @override
  String get winesMemoriesRemoveConfirm => 'Entfernen';

  @override
  String get momentSheetNewTitle => 'Neuer Moment';

  @override
  String get momentSheetEditTitle => 'Moment bearbeiten';

  @override
  String get momentFieldPhotos => 'Fotos';

  @override
  String get momentFieldWhen => 'Wann';

  @override
  String get momentFieldOccasion => 'Anlass';

  @override
  String get momentFieldCompanions => 'Mit';

  @override
  String get momentFieldPlace => 'Wo';

  @override
  String get momentFieldFood => 'Dazu gegessen';

  @override
  String get momentFieldNote => 'Notiz';

  @override
  String get momentFieldVisibility => 'Sichtbarkeit';

  @override
  String get momentAddPhoto => 'Foto hinzufügen';

  @override
  String get momentPhotoCap => 'Bis zu 10 Fotos';

  @override
  String get momentOccasionDinner => 'Dinner';

  @override
  String get momentOccasionDate => 'Date';

  @override
  String get momentOccasionCelebration => 'Feier';

  @override
  String get momentOccasionTasting => 'Tasting';

  @override
  String get momentOccasionCasual => 'Locker';

  @override
  String get momentOccasionBirthday => 'Geburtstag';

  @override
  String get momentCompanionsAddFriend => 'Freund hinzufügen';

  @override
  String get momentPlaceHint => 'Restaurant oder Ort';

  @override
  String get momentFoodHint => 'Wozu hast du ihn getrunken?';

  @override
  String get momentNoteHint => 'Was willst du dir merken?';

  @override
  String get momentVisibilityFriends => 'Freunde';

  @override
  String get momentVisibilityPrivate => 'Privat';

  @override
  String get momentSave => 'Moment speichern';

  @override
  String get momentSaveError => 'Moment konnte nicht gespeichert werden';

  @override
  String get momentEdit => 'Bearbeiten';

  @override
  String get momentDelete => 'Löschen';

  @override
  String get momentDeleteConfirmTitle => 'Moment löschen?';

  @override
  String get momentDeleteConfirmBody =>
      'Dieser Moment und alle Fotos werden dauerhaft gelöscht.';

  @override
  String get momentUseAsShowcase => 'Als Hauptfoto setzen';

  @override
  String get momentTastingAdd => 'Tasting-Moment hinzufügen';

  @override
  String get momentValidationEmpty => 'Füge ein Foto oder eine Notiz hinzu';

  @override
  String get momentSectionHeader => 'Momente';

  @override
  String get momentSectionAdd => 'Neu';

  @override
  String get momentSectionEmpty => 'Noch keine Momente — tippe auf Neu.';

  @override
  String momentMetaWith(String names) {
    return 'Mit $names';
  }

  @override
  String get momentUseCurrentLocation => 'Aktuellen Standort nutzen';

  @override
  String get momentLocationDenied => 'Standortzugriff verweigert';

  @override
  String get momentLocationOff => 'Ortungsdienste aktivieren';

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

  @override
  String get groupListHeader => 'GRUPPEN';

  @override
  String get groupListSubtitle => 'Gemeinsam probieren';

  @override
  String get groupListSortRecent => 'Sortierung: neu';

  @override
  String get groupListSortName => 'Sortierung: Name';

  @override
  String get groupListCreateTooltip => 'Gruppe erstellen';

  @override
  String get groupListJoinTitle => 'Gruppe beitreten';

  @override
  String get groupListJoinSubtitle => 'Einladungscode eingeben';

  @override
  String get groupListJoinNotFound => 'Gruppe nicht gefunden';

  @override
  String get groupListErrorLoad => 'Gruppen konnten nicht geladen werden';

  @override
  String get groupListEmptyTitle => 'Noch keine Gruppen';

  @override
  String get groupListEmptyBody =>
      'Erstelle eine oder tritt einer bei, um Weine zu teilen';

  @override
  String get groupListEmptyCta => 'Gruppe erstellen';

  @override
  String get groupCreateSourceCamera => 'Kamera';

  @override
  String get groupCreateSourceGallery => 'Galerie';

  @override
  String get groupCreateSourceRemovePhoto => 'Foto entfernen';

  @override
  String get groupCreatePickFailedFallback => 'Auswahl fehlgeschlagen.';

  @override
  String get groupCreateUploadFailedFallback => 'Foto-Upload fehlgeschlagen.';

  @override
  String get groupCreateFailedFallback =>
      'Gruppe konnte nicht erstellt werden. Bitte erneut versuchen.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get groupCreateTitle => 'Neue Gruppe';

  @override
  String get groupCreateNameHint => 'Gruppenname';

  @override
  String get groupCreateSubmit => 'Erstellen';

  @override
  String get groupJoinTitle => 'Einladungscode';

  @override
  String get groupJoinHint => 'z. B. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Beitreten';

  @override
  String get groupDetailNotFound => 'Gruppe nicht gefunden';

  @override
  String get groupDetailErrorLoad => 'Gruppe konnte nicht geladen werden';

  @override
  String get groupDetailSectionSharedWines => 'Geteilte Weine';

  @override
  String get groupDetailSectionTastings => 'Verkostungen';

  @override
  String get groupDetailActionShare => 'Teilen';

  @override
  String get groupDetailActionPlan => 'Planen';

  @override
  String get groupDetailMenuEdit => 'Gruppe bearbeiten';

  @override
  String get groupDetailMenuDelete => 'Gruppe löschen';

  @override
  String get groupDetailMenuLeave => 'Gruppe verlassen';

  @override
  String get groupDetailLeaveDialogTitle => 'Gruppe verlassen?';

  @override
  String get groupDetailLeaveDialogBody =>
      'Du kannst später mit dem Einladungscode wieder beitreten.';

  @override
  String get groupDetailLeaveDialogCancel => 'Abbrechen';

  @override
  String get groupDetailLeaveDialogConfirm => 'Verlassen';

  @override
  String get groupDetailDeleteDialogTitle => 'Gruppe löschen?';

  @override
  String get groupDetailDeleteDialogBody =>
      'Die Gruppe und ihre geteilten Weine werden für alle entfernt.';

  @override
  String get groupDetailDeleteDialogCancel => 'Abbrechen';

  @override
  String get groupDetailDeleteDialogConfirm => 'Löschen';

  @override
  String get groupSettingsEditTitle => 'Gruppe bearbeiten';

  @override
  String get groupSettingsNameLabel => 'Name';

  @override
  String get groupSettingsSourceCamera => 'Kamera';

  @override
  String get groupSettingsSourceGallery => 'Galerie';

  @override
  String get groupSettingsRemovePhoto => 'Foto entfernen';

  @override
  String get groupSettingsUploadFailedFallback => 'Upload fehlgeschlagen.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Löschen fehlgeschlagen.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get groupSettingsSave => 'Speichern';

  @override
  String get groupInviteEyebrow => 'EINLADUNG';

  @override
  String get groupInviteFriendsEyebrow => 'FREUNDE EINLADEN';

  @override
  String get groupInviteCodeCopied => 'Einladungscode kopiert';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Tritt „$groupName“ auf Sippd bei 🍷\n\n$url\n\nOder gib den Code ein: $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Tritt $groupName auf Sippd bei';
  }

  @override
  String get groupInviteActionCopy => 'Code kopieren';

  @override
  String get groupInviteActionShare => 'Link teilen';

  @override
  String get groupInviteFriendsEmpty => 'Keine Freunde zum Einladen verfügbar.';

  @override
  String get groupInviteFriendsErrorLoad =>
      'Freunde konnten nicht geladen werden';

  @override
  String get groupInviteFriendFallback => 'Freund:in';

  @override
  String get groupInviteUnknownName => 'Unbekannt';

  @override
  String groupInviteSentSnack(String name) {
    return 'Einladung an $name gesendet';
  }

  @override
  String get groupInviteSendFailedFallback =>
      'Einladung konnte nicht gesendet werden.';

  @override
  String get groupInvitationsHeader => 'EINLADUNGEN';

  @override
  String get groupInvitationsInviterFallback => 'Jemand';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Eingeladen von $name';
  }

  @override
  String get groupInvitationsDecline => 'Ablehnen';

  @override
  String get groupInvitationsAccept => 'Annehmen';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return '$name beigetreten';
  }

  @override
  String get groupInvitationsAcceptFailed =>
      'Einladung konnte nicht angenommen werden';

  @override
  String get groupMembersCountOne => '1 Mitglied';

  @override
  String groupMembersCountMany(int count) {
    return '$count Mitglieder';
  }

  @override
  String get groupMembersUnknown => 'Unbekannt';

  @override
  String get groupMembersOwnerBadge => 'INHABER:IN';

  @override
  String get groupWineCarouselDetails => 'Details';

  @override
  String get groupWineCarouselEmptyTitle => 'Noch keine Weine geteilt';

  @override
  String get groupWineCarouselEmptyBody =>
      'Wähle einen aus deiner Sammlung, um die Liste zu starten.';

  @override
  String get groupWineCarouselEmptyCta => 'Wein teilen';

  @override
  String get groupWineTypeRed => 'ROT';

  @override
  String get groupWineTypeWhite => 'WEISS';

  @override
  String get groupWineTypeRose => 'ROSÉ';

  @override
  String get groupWineTypeSparkling => 'SCHAUMWEIN';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Speichere den Wein zuerst – Notizen werden daran angehängt.';

  @override
  String get groupWineRatingNoCanonical =>
      'Wein hat noch keine kanonische Identität – bitte erneut versuchen.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'Wein hat noch keine kanonische Identität.';

  @override
  String get groupWineRatingNotesHint => 'Notiz hinzufügen';

  @override
  String get groupWineRatingOfflineRetry => 'Offline · Erneut versuchen';

  @override
  String get groupWineRatingSaveFailedRetry =>
      'Speichern fehlgeschlagen · Erneut';

  @override
  String get groupWineRatingSaved => 'Gespeichert ✓';

  @override
  String get groupWineRatingSaveCta => 'Bewertung speichern';

  @override
  String get groupWineRatingRemoveMine => 'Meine Bewertung entfernen';

  @override
  String get groupWineRatingUnshareDialogTitle => 'Aus Gruppe entfernen?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '„$name“ wird aus dieser Gruppe entfernt. Bewertungen der Mitglieder werden ebenfalls gelöscht.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Abbrechen';

  @override
  String get groupWineRatingUnshareConfirm => 'Entfernen';

  @override
  String get groupWineRatingMoreTooltip => 'Mehr';

  @override
  String get groupWineRatingUnshareMenu => 'Aus Gruppe entfernen';

  @override
  String get groupWineRatingsTitle => 'Bewertungen';

  @override
  String get groupWineRatingsCountOne => '1 Bewertung';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count Bewertungen';
  }

  @override
  String get groupWineRatingsAvgLabel => 'Ø';

  @override
  String get groupWineRatingsBeFirst => 'Sei der/die Erste';

  @override
  String get groupWineRatingsSoloMe =>
      'Du bist der/die Erste · lade andere zum Bewerten ein';

  @override
  String get groupShareWineTitle => 'Wein teilen';

  @override
  String get groupShareWineErrorLoad => 'Weine konnten nicht geladen werden.';

  @override
  String get groupShareWineEmpty => 'Du hast noch keine Weine.';

  @override
  String get groupShareWineSharedChip => 'Geteilt';

  @override
  String get groupShareWineSheetTitle => 'Mit Gruppe teilen';

  @override
  String get groupShareWineSheetEmpty => 'Du bist noch in keiner Gruppe.';

  @override
  String get groupShareWineSheetErrorLoad =>
      'Gruppen konnten nicht geladen werden.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Bereits geteilt';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Mit $name geteilt';
  }

  @override
  String get groupShareWineRowMemberOne => '1 Mitglied';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count Mitglieder';
  }

  @override
  String get groupShareWineRowWineOne => '1 Wein';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count Weine';
  }

  @override
  String get groupShareMatchTitle => 'Bereits in dieser Gruppe';

  @override
  String groupShareMatchBody(String name) {
    return '„$name“ sieht aus wie ein Wein, den jemand bereits geteilt hat. Ist es derselbe Wein?';
  }

  @override
  String get groupShareMatchNone => 'Keiner davon – separat teilen';

  @override
  String get groupShareMatchCancel => 'Abbrechen';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Geteilt von @$username';
  }

  @override
  String get groupFriendActionsInvite => 'In eine Gruppe einladen';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return '$name einladen in…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'Keine Gruppen zum Einladen. Erstelle oder tritt zuerst einer bei.';

  @override
  String get groupFriendActionsPickerErrorLoad =>
      'Gruppen konnten nicht geladen werden';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Vergangene Verkostungen ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'Noch keine Verkostungen';

  @override
  String get groupCalendarEmptyBody =>
      'Plane eine, um die Gruppe um eine Flasche zu versammeln.';

  @override
  String get groupCalendarEmptyCta => 'Verkostung planen';

  @override
  String get groupWineDetailSectionRatings => 'GRUPPENBEWERTUNGEN';

  @override
  String get groupWineDetailEmptyRatings => 'Noch keine Gruppenbewertungen.';

  @override
  String get groupWineDetailStatGroupAvg => 'Gruppen-Ø';

  @override
  String get groupWineDetailStatRatings => 'Bewertungen';

  @override
  String get groupWineDetailStatNoRatings => 'Keine Bewertungen';

  @override
  String get groupWineDetailStatRegion => 'Region';

  @override
  String get groupWineDetailStatCountry => 'Land';

  @override
  String get groupWineDetailStatOrigin => 'Herkunft';

  @override
  String get groupWineDetailSharedByEyebrow => 'GETEILT VON';

  @override
  String get groupWineDetailSharerFallback => 'jemand';

  @override
  String get groupWineDetailMemberFallback => 'Mitglied';

  @override
  String get groupWineDetailRelJustNow => 'gerade eben';

  @override
  String groupWineDetailRelMinutes(int count) {
    return 'vor ${count}m';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return 'vor ${count}h';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return 'vor ${count}T';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return 'vor ${count}W';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return 'vor ${count}M';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return 'vor ${count}J';
  }

  @override
  String get friendsHeader => 'FREUNDE';

  @override
  String get friendsSubtitle => 'Verkoste mit Leuten, die du kennst';

  @override
  String get friendsSearchHint => 'Nach Username oder Name suchen';

  @override
  String get friendsSearchEmpty => 'Keine Nutzer gefunden';

  @override
  String get friendsSearchErrorFallback => 'Suche konnte nicht geladen werden.';

  @override
  String get friendsUnknownUser => 'Unbekannt';

  @override
  String friendsRequestsHeader(int count) {
    return 'Anfragen ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'Warten auf Antwort ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Anfrage gesendet';

  @override
  String get friendsRequestSubtitle => 'möchte mit dir befreundet sein';

  @override
  String get friendsActionCancel => 'Abbrechen';

  @override
  String get friendsActionAdd => 'Hinzufügen';

  @override
  String get friendsCancelDialogFallbackUser => 'diesen Nutzer';

  @override
  String get friendsCancelDialogTitle => 'Anfrage zurückziehen?';

  @override
  String friendsCancelDialogBody(String name) {
    return 'Deine Freundschaftsanfrage an $name zurückziehen?';
  }

  @override
  String get friendsCancelDialogKeep => 'Beibehalten';

  @override
  String get friendsCancelDialogConfirm => 'Anfrage zurückziehen';

  @override
  String get friendsListHeader => 'Deine Freunde';

  @override
  String get friendsListErrorFallback =>
      'Freunde konnten nicht geladen werden.';

  @override
  String get friendsRemoveDialogTitle => 'Freund entfernen?';

  @override
  String friendsRemoveDialogBody(String name) {
    return '$name aus deinen Freunden entfernen?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Entfernen';

  @override
  String get friendsSendRequestErrorFallback =>
      'Anfrage konnte nicht gesendet werden.';

  @override
  String get friendsStatusChipFriend => 'Freund';

  @override
  String get friendsStatusChipPending => 'Ausstehend';

  @override
  String get friendsEmptyDefaultName => 'Ein Freund';

  @override
  String get friendsEmptyTitle => 'Hol deinen Verkostungskreis dazu';

  @override
  String get friendsEmptyBody =>
      'Sippd wird mit Freunden besser. Schick eine Einladung — sie landen direkt auf deinem Profil.';

  @override
  String get friendsEmptyInviteCta => 'Freunde einladen';

  @override
  String get friendsEmptyFindCta => 'Per Username finden';

  @override
  String get friendsProfileNotFound => 'Profil nicht gefunden';

  @override
  String get friendsProfileErrorLoad => 'Profil konnte nicht geladen werden';

  @override
  String get friendsProfileNameFallback => 'Freund';

  @override
  String get friendsProfileRecentWinesHeader => 'LETZTE WEINE';

  @override
  String get friendsProfileWinesErrorLoad =>
      'Weine konnten nicht geladen werden';

  @override
  String get friendsProfileStatWines => 'Weine';

  @override
  String get friendsProfileStatAvg => 'Ø';

  @override
  String get friendsProfileStatCountry => 'Land';

  @override
  String get friendsProfileStatCountries => 'Länder';

  @override
  String get paywallPitchEyebrow => 'Sippd Pro';

  @override
  String get paywallPitchHeadline => 'Sieh, wie du\nwirklich schmeckst.';

  @override
  String get paywallPitchSubhead =>
      'Kartografiere jede Flasche, finde Freunde, die wie du trinken, und tauche tiefer in jede Verkostung ein.';

  @override
  String get paywallBenefitFriendsTitle =>
      'Unbegrenzte Gruppen & Freundes-Match';

  @override
  String get paywallBenefitFriendsSubtitle =>
      'Hol deine Crew dazu. Sieh, wer wie du trinkt.';

  @override
  String get paywallBenefitCompassTitle => 'Geschmackskompass & tiefe Stats';

  @override
  String get paywallBenefitCompassSubtitle =>
      'Deine Wein-Persönlichkeit, kartiert.';

  @override
  String get paywallBenefitNotesTitle => 'Experten-Verkostungsnotizen';

  @override
  String get paywallBenefitNotesSubtitle => 'Nase · Körper · Tannine · Abgang.';

  @override
  String get paywallPlanMonthly => 'Monatlich';

  @override
  String get paywallPlanAnnual => 'Jährlich';

  @override
  String get paywallPlanLifetime => 'Lifetime';

  @override
  String get paywallPlanSubtitleMonthly => 'Jederzeit kündbar';

  @override
  String get paywallPlanSubtitleAnnual => 'Am beliebtesten';

  @override
  String get paywallPlanSubtitleLifetime =>
      'Limitiertes Launch-Angebot · einmal zahlen';

  @override
  String get paywallPlanBadgeAnnual => 'AM BELIEBTESTEN';

  @override
  String get paywallPlanBadgeLifetime => 'FOUNDERS EDITION';

  @override
  String paywallPlanSavingsVsMonthly(int pct) {
    return 'Spare $pct% gegenüber monatlich';
  }

  @override
  String get paywallTrialTodayTitle => 'Heute';

  @override
  String get paywallTrialTodaySubtitle => 'Voller Pro-Zugang freigeschaltet.';

  @override
  String get paywallTrialDay5Title => 'Tag 5';

  @override
  String get paywallTrialDay5Subtitle => 'Wir erinnern dich vor der Abbuchung.';

  @override
  String get paywallTrialDay7Title => 'Tag 7';

  @override
  String get paywallTrialDay7Subtitle => 'Probezeit endet. Jederzeit kündbar.';

  @override
  String get paywallCtaContinue => 'Weiter';

  @override
  String get paywallCtaSelectPlan => 'Plan wählen';

  @override
  String get paywallCtaStartTrial => '7 Tage kostenlos testen';

  @override
  String get paywallCtaMaybeLater => 'Vielleicht später';

  @override
  String get paywallCtaRestore => 'Käufe wiederherstellen';

  @override
  String get paywallFooterDisclosure =>
      'Jederzeit kündbar · abgerechnet über Apple oder Google';

  @override
  String get paywallPlansLoadError => 'Pläne konnten nicht geladen werden';

  @override
  String get paywallPlansEmpty => 'Noch keine Pläne verfügbar.';

  @override
  String get paywallErrorPurchaseFailed =>
      'Kauf fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get paywallErrorRestoreFailed =>
      'Käufe konnten nicht wiederhergestellt werden.';

  @override
  String get paywallRestoreWelcomeBack => 'Willkommen zurück bei Sippd Pro!';

  @override
  String get paywallRestoreNoneFound => 'Kein aktives Abo gefunden.';

  @override
  String get paywallSubscriptionTitle => 'Abonnement';

  @override
  String get paywallSubscriptionBrand => 'Sippd Pro';

  @override
  String get paywallSubscriptionChipActive => 'AKTIV';

  @override
  String get paywallSubscriptionChipTrial => 'PROBEZEIT';

  @override
  String get paywallSubscriptionChipEnding => 'ENDET';

  @override
  String get paywallSubscriptionChipLifetime => 'LIFETIME';

  @override
  String get paywallSubscriptionChipTest => 'TESTMODUS';

  @override
  String get paywallSubscriptionPlanTest => 'Testmodus';

  @override
  String get paywallSubscriptionPlanLifetime => 'Lifetime';

  @override
  String get paywallSubscriptionPlanAnnual => 'Jährlich';

  @override
  String get paywallSubscriptionPlanMonthly => 'Monatlich';

  @override
  String get paywallSubscriptionPlanWeekly => 'Wöchentlich';

  @override
  String get paywallSubscriptionPlanGeneric => 'Pro-Plan';

  @override
  String get paywallSubscriptionPeriodYear => '/ Jahr';

  @override
  String get paywallSubscriptionPeriodMonth => '/ Monat';

  @override
  String get paywallSubscriptionPeriodWeek => '/ Woche';

  @override
  String get paywallSubscriptionPeriodLifetime => 'einmalig';

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
  String get paywallSubscriptionStorePromo => 'Promo-Freischaltung';

  @override
  String paywallSubscriptionBilledVia(String store) {
    return 'Abrechnung über $store';
  }

  @override
  String get paywallSubscriptionStatusTestNoSub =>
      'Pro-Features lokal freigeschaltet · kein echtes Abo';

  @override
  String get paywallSubscriptionStatusTestLocal =>
      'Pro-Features lokal freigeschaltet';

  @override
  String get paywallSubscriptionStatusLifetime =>
      'Lifetime-Zugang — für immer deins';

  @override
  String get paywallSubscriptionStatusEndingNoDate => 'Wird nicht verlängert';

  @override
  String paywallSubscriptionStatusEndingWithDate(String date) {
    return 'Zugang bis $date · wird nicht verlängert';
  }

  @override
  String get paywallSubscriptionStatusTrialActive => 'Probezeit aktiv';

  @override
  String get paywallSubscriptionStatusTrialEndsToday => 'Probezeit endet heute';

  @override
  String get paywallSubscriptionStatusTrialEndsTomorrow =>
      'Probezeit endet morgen';

  @override
  String paywallSubscriptionStatusTrialEndsInDays(int days) {
    return 'Probezeit endet in $days Tagen';
  }

  @override
  String get paywallSubscriptionStatusActive => 'Aktiv';

  @override
  String paywallSubscriptionStatusRenewsOn(String date) {
    return 'Verlängert sich am $date';
  }

  @override
  String get paywallSubscriptionSectionIncluded => 'In Pro enthalten';

  @override
  String get paywallSubscriptionSectionManage => 'Verwalten';

  @override
  String get paywallSubscriptionRowChangePlan => 'Plan ändern';

  @override
  String get paywallSubscriptionRowRestore => 'Käufe wiederherstellen';

  @override
  String get paywallSubscriptionRowCancel => 'Abo kündigen';

  @override
  String get paywallSubscriptionDisclosure =>
      'Abos werden über Apple oder Google abgerechnet. Verwalte sie in den Store-Einstellungen.';

  @override
  String get paywallSubscriptionOpenError =>
      'Abo-Einstellungen konnten nicht geöffnet werden.';

  @override
  String get paywallMonthShortJan => 'Jan';

  @override
  String get paywallMonthShortFeb => 'Feb';

  @override
  String get paywallMonthShortMar => 'Mär';

  @override
  String get paywallMonthShortApr => 'Apr';

  @override
  String get paywallMonthShortMay => 'Mai';

  @override
  String get paywallMonthShortJun => 'Jun';

  @override
  String get paywallMonthShortJul => 'Jul';

  @override
  String get paywallMonthShortAug => 'Aug';

  @override
  String get paywallMonthShortSep => 'Sep';

  @override
  String get paywallMonthShortOct => 'Okt';

  @override
  String get paywallMonthShortNov => 'Nov';

  @override
  String get paywallMonthShortDec => 'Dez';

  @override
  String get tasteTraitBody => 'Körper';

  @override
  String get tasteTraitTannin => 'Tannin';

  @override
  String get tasteTraitAcidity => 'Säure';

  @override
  String get tasteTraitSweetness => 'Süße';

  @override
  String get tasteTraitOak => 'Holz';

  @override
  String get tasteTraitIntensity => 'Intensität';

  @override
  String get tasteTraitSweetShort => 'Süß';

  @override
  String get tasteTraitBodyLow => 'Leicht, süffig';

  @override
  String get tasteTraitBodyMid => 'Ausgewogen';

  @override
  String get tasteTraitBodyHigh => 'Kräftig, vollmundig';

  @override
  String get tasteTraitTanninLow => 'Weich, samtig';

  @override
  String get tasteTraitTanninMid => 'Mittlerer Griff';

  @override
  String get tasteTraitTanninHigh => 'Griffig, strukturiert';

  @override
  String get tasteTraitAcidityLow => 'Weich, rund';

  @override
  String get tasteTraitAcidityMid => 'Ausgewogen';

  @override
  String get tasteTraitAcidityHigh => 'Frisch, lebhaft';

  @override
  String get tasteTraitSweetnessLow => 'Knochentrocken';

  @override
  String get tasteTraitSweetnessMid => 'Halbtrocken';

  @override
  String get tasteTraitSweetnessHigh => 'Süßlich';

  @override
  String get tasteTraitOakLow => 'Ohne Holz, frisch';

  @override
  String get tasteTraitOakMid => 'Hauch von Holz';

  @override
  String get tasteTraitOakHigh => 'Holzbetont';

  @override
  String get tasteTraitIntensityLow => 'Zurückhaltend';

  @override
  String get tasteTraitIntensityMid => 'Ausdrucksstark';

  @override
  String get tasteTraitIntensityHigh => 'Intensiv, aromatisch';

  @override
  String tasteDnaBodyLowPct(int pct) {
    return 'Du magst leichte Weine · $pct%';
  }

  @override
  String tasteDnaBodyMidPct(int pct) {
    return 'Ausgewogener Körper · $pct%';
  }

  @override
  String tasteDnaBodyHighPct(int pct) {
    return 'Du magst kräftige Weine · $pct%';
  }

  @override
  String tasteDnaTanninLowPct(int pct) {
    return 'Weiche Tannine · $pct%';
  }

  @override
  String tasteDnaTanninMidPct(int pct) {
    return 'Mittleres Tannin · $pct%';
  }

  @override
  String tasteDnaTanninHighPct(int pct) {
    return 'Kräftige, griffige Tannine · $pct%';
  }

  @override
  String tasteDnaAcidityLowPct(int pct) {
    return 'Weiche Säure · $pct%';
  }

  @override
  String tasteDnaAcidityMidPct(int pct) {
    return 'Ausgewogene Säure · $pct%';
  }

  @override
  String tasteDnaAcidityHighPct(int pct) {
    return 'Säurebetont · $pct%';
  }

  @override
  String tasteDnaSweetnessLowPct(int pct) {
    return 'Knochentrocken · $pct%';
  }

  @override
  String tasteDnaSweetnessMidPct(int pct) {
    return 'Tendenz halbtrocken · $pct%';
  }

  @override
  String tasteDnaSweetnessHighPct(int pct) {
    return 'Eher süß · $pct%';
  }

  @override
  String tasteDnaOakLowPct(int pct) {
    return 'Ohne Holz / frisch · $pct%';
  }

  @override
  String tasteDnaOakMidPct(int pct) {
    return 'Etwas Holz · $pct%';
  }

  @override
  String tasteDnaOakHighPct(int pct) {
    return 'Holzliebhaber · $pct%';
  }

  @override
  String tasteDnaIntensityLowPct(int pct) {
    return 'Zurückhaltende Aromatik · $pct%';
  }

  @override
  String tasteDnaIntensityMidPct(int pct) {
    return 'Ausdrucksstark · $pct%';
  }

  @override
  String tasteDnaIntensityHighPct(int pct) {
    return 'Intensive Aromatik · $pct%';
  }

  @override
  String get tasteDnaNotEnoughYet =>
      'Noch nicht genug bewertete Weine — bleib dran';

  @override
  String get tasteArchetypeBoldRedHunter => 'Kraftvoller Rotwein-Jäger';

  @override
  String get tasteArchetypeBoldRedHunterTagline =>
      'Vollmundige, tanninreiche Rotweine sind dein Zuhause.';

  @override
  String get tasteArchetypeElegantBurgundian => 'Eleganter Burgunder-Fan';

  @override
  String get tasteArchetypeElegantBurgundianTagline =>
      'Leichtere Rotweine mit lebhafter Säure prägen deinen Gaumen.';

  @override
  String get tasteArchetypeAromaticWhiteLover =>
      'Aromatische Weißwein-Liebhaberin';

  @override
  String get tasteArchetypeAromaticWhiteLoverTagline =>
      'Frische, ausdrucksstarke Weißweine mit klarer Säure.';

  @override
  String get tasteArchetypeSparklingSociable => 'Geselliger Schaumwein-Fan';

  @override
  String get tasteArchetypeSparklingSociableTagline =>
      'Perlen und helle Weine prägen deine Sammlung.';

  @override
  String get tasteArchetypeClassicStructure => 'Klassische Struktur';

  @override
  String get tasteArchetypeClassicStructureTagline =>
      'Zurückhaltende, essensfreundliche Weine mit lebhafter Säure.';

  @override
  String get tasteArchetypeSunRipenedBold => 'Sonnengereift & Kräftig';

  @override
  String get tasteArchetypeSunRipenedBoldTagline =>
      'Üppige Frucht, holzfreundliche Weine aus sonnenverwöhnten Lagen.';

  @override
  String get tasteArchetypeDessertOffDry => 'Dessert / Halbtrocken';

  @override
  String get tasteArchetypeDessertOffDryTagline =>
      'Du magst Flaschen mit einem Hauch Süße.';

  @override
  String get tasteArchetypeNaturalLowIntervention => 'Natural / Wenig Eingriff';

  @override
  String get tasteArchetypeNaturalLowInterventionTagline =>
      'Ohne Holz, leichter — das Frische-Lager.';

  @override
  String get tasteArchetypeCrispMineralFan => 'Mineralisch & Knackig';

  @override
  String get tasteArchetypeCrispMineralFanTagline =>
      'Straffe, mineralische, säurebetonte Stile sind deine Handschrift.';

  @override
  String get tasteArchetypeEclecticExplorer => 'Eklektischer Entdecker';

  @override
  String get tasteArchetypeEclecticExplorerTagline =>
      'Breiter Gaumen — du kostest quer durch die Weinwelt.';

  @override
  String get tasteArchetypeCuriousNewcomer => 'Neugieriger Neuling';

  @override
  String get tasteArchetypeCuriousNewcomerTagline =>
      'Bewerte ein paar Weine mehr und dein Profil zeigt sich.';

  @override
  String get tasteCompassModeStyle => 'Stil';

  @override
  String get tasteCompassModeWorld => 'Welt';

  @override
  String get tasteCompassModeGrapes => 'Rebsorten';

  @override
  String get tasteCompassModeDna => 'DNA';

  @override
  String get tasteCompassMetricCount => 'Anzahl';

  @override
  String get tasteCompassMetricRating => 'Bewertung';

  @override
  String get tasteCompassContinentEurope => 'Europa';

  @override
  String get tasteCompassContinentNorthAmerica => 'Nordamerika';

  @override
  String get tasteCompassContinentSouthAmerica => 'Südamerika';

  @override
  String get tasteCompassContinentAfrica => 'Afrika';

  @override
  String get tasteCompassContinentAsia => 'Asien';

  @override
  String get tasteCompassContinentOceania => 'Ozeanien';

  @override
  String tasteCompassStyleNoneYet(String label) {
    return 'Noch keine $label-Weine';
  }

  @override
  String tasteCompassStyleSummaryOne(int count, String label, String avg) {
    return '$count $label-Wein · $avg★ Ø';
  }

  @override
  String tasteCompassStyleSummaryMany(int count, String label, String avg) {
    return '$count $label-Weine · $avg★ Ø';
  }

  @override
  String tasteCompassWorldNoneYet(String label) {
    return 'Noch keine Flaschen aus $label';
  }

  @override
  String tasteCompassWorldSummaryOne(String label, String avg) {
    return '1 Flasche aus $label · $avg★ Ø';
  }

  @override
  String tasteCompassWorldSummaryMany(int count, String label, String avg) {
    return '$count Flaschen aus $label · $avg★ Ø';
  }

  @override
  String get tasteCompassGrapeEmptySlot =>
      'Leerer Platz — bewerte mehr Rebsorten';

  @override
  String tasteCompassGrapeSummaryOne(String name, String avg) {
    return '$name · 1 Flasche · $avg★ Ø';
  }

  @override
  String tasteCompassGrapeSummaryMany(String name, int count, String avg) {
    return '$name · $count Flaschen · $avg★ Ø';
  }

  @override
  String get tasteCompassTitleDefault => 'Geschmacks-Kompass';

  @override
  String get tasteCompassEmptyPromptOne =>
      'Bewerte 1 weiteren Wein, um den Kompass freizuschalten.';

  @override
  String tasteCompassEmptyPromptMany(int count) {
    return 'Bewerte $count weitere Weine, um den Kompass freizuschalten.';
  }

  @override
  String get tasteCompassNotEnoughData =>
      'Noch nicht genug Daten für diesen Modus.';

  @override
  String get tasteCompassDnaNeedsGrapes =>
      'DNA braucht ein paar Weine mit erkannter Rebsorte. Wähle eine kanonische Rebsorte für deine Weine, um diese Ansicht freizuschalten.';

  @override
  String get tasteCompassEyebrowPersonality => 'DEINE WEIN-PERSÖNLICHKEIT';

  @override
  String get tasteCompassTentativeHint =>
      'Vorläufig — bewerte mehr Weine für ein klareres Bild';

  @override
  String get tasteCompassTopRegions => 'Top-Regionen';

  @override
  String get tasteCompassTopCountries => 'Top-Länder';

  @override
  String get tasteCompassFooterWinesOne => '1 Wein';

  @override
  String tasteCompassFooterWinesMany(int count) {
    return '$count Weine';
  }

  @override
  String tasteCompassFooterAvg(String avg) {
    return '$avg ★ Ø';
  }

  @override
  String get tasteHeroEyebrow => 'PERSÖNLICHKEIT';

  @override
  String get tasteHeroPromptCuriousOne =>
      'Bewerte 1 weiteren Wein, um deine Persönlichkeit zu zeigen.';

  @override
  String tasteHeroPromptCuriousMany(int count) {
    return 'Bewerte $count weitere Weine, um deine Persönlichkeit zu zeigen.';
  }

  @override
  String get tasteHeroAlmostThere => 'Fast geschafft';

  @override
  String get tasteHeroPromptThinDnaOne =>
      'Markiere bei 1 weiteren Wein eine kanonische Rebsorte, um deinen Archetyp freizuschalten.';

  @override
  String tasteHeroPromptThinDnaMany(int count) {
    return 'Markiere bei $count weiteren Weinen eine kanonische Rebsorte, um deinen Archetyp freizuschalten.';
  }

  @override
  String tasteHeroMatchExact(int score) {
    return '$score% Match';
  }

  @override
  String tasteHeroMatchTentative(int score) {
    return '~$score% Match';
  }

  @override
  String get tasteHeroWinesOne => '1 Wein';

  @override
  String tasteHeroWinesMany(int count) {
    return '$count Weine';
  }

  @override
  String tasteHeroAvg(String avg) {
    return '$avg★ Ø';
  }

  @override
  String get tasteHeroShare => 'Teilen';

  @override
  String get tasteTraitsHeading => 'MERKMALE';

  @override
  String get tasteTraitsProDivider => 'PRO';

  @override
  String get tasteTraitsUnlockAll => 'Alle Merkmale mit Pro freischalten';

  @override
  String get tasteMatchLabel => 'Geschmacks-Match';

  @override
  String get tasteMatchConfidenceStrong => 'Stark';

  @override
  String get tasteMatchConfidenceSolid => 'Solide';

  @override
  String get tasteMatchConfidenceEarly => 'Früh';

  @override
  String tasteMatchSupportingOne(String dnaPart) {
    return 'Basierend auf 1 gemeinsamen Region/Typ-Bereich$dnaPart.';
  }

  @override
  String tasteMatchSupportingMany(int overlap, String dnaPart) {
    return 'Basierend auf $overlap gemeinsamen Region/Typ-Bereichen$dnaPart.';
  }

  @override
  String get tasteMatchSupportingDnaPart => ' + WSET-Stil-Überschneidung';

  @override
  String get tasteMatchSignalStrong => 'Starkes Signal.';

  @override
  String get tasteMatchSignalSolid => 'Solides Signal.';

  @override
  String get tasteMatchSignalEarly =>
      'Frühes Signal — bewerte weiter, um es zu schärfen.';

  @override
  String get tasteMatchBreakdownBucket => 'Region- & Typ-Passung';

  @override
  String get tasteMatchBreakdownDna => 'Stil-DNA-Passung';

  @override
  String get tasteMatchEmptyNotEnough =>
      'Noch nicht genug Weine zum Vergleichen — bewerte ein paar Flaschen mehr, um Geschmacks-Match freizuschalten.';

  @override
  String get tasteMatchEmptyNoOverlap =>
      'Ihr habt noch keine Weine aus den gleichen Regionen oder Typen bewertet. Match entsteht, sobald sich euer Geschmack überschneidet.';

  @override
  String tasteFriendUpsellTitle(String name) {
    return 'Sieh, wie $name schmeckt';
  }

  @override
  String get tasteFriendUpsellBody =>
      'Vergleicht eure Gaumen, findet Weine, die ihr beide liebt, und seht, wo euer Geschmack auseinandergeht.';

  @override
  String get tasteFriendUpsellPillMatch => 'Geschmacks-Match';

  @override
  String get tasteFriendUpsellPillShared => 'Gemeinsame Flaschen';

  @override
  String get tasteFriendUpsellCta => 'Sippd Pro freischalten';

  @override
  String get tasteFriendSharedHeading => 'WEINE, DIE IHR BEIDE BEWERTET HABT';

  @override
  String tasteFriendSharedMore(int count) {
    return '+ $count weitere';
  }

  @override
  String get tasteFriendRatingYou => 'du';

  @override
  String get tasteFriendRatingThem => 'sie';

  @override
  String shareRatedOn(String date) {
    return 'BEWERTET · $date';
  }

  @override
  String get shareRatingDenominator => '/ 10';

  @override
  String shareFooterRateYours(String url) {
    return 'bewerte deine auf $url';
  }

  @override
  String shareFooterFindYours(String url) {
    return 'finde deinen Geschmack auf $url';
  }

  @override
  String shareFooterHostYours(String url) {
    return 'veranstalte deine auf $url';
  }

  @override
  String shareFooterJoinAt(String url) {
    return 'mitmachen auf $url';
  }

  @override
  String get shareCompassEyebrow => 'WEIN-PERSÖNLICHKEIT';

  @override
  String get shareCompassWhatDefinesMe => 'WAS MICH AUSMACHT';

  @override
  String get shareCompassSampleSizeOne => 'basierend auf 1 Wein';

  @override
  String shareCompassSampleSizeMany(int count) {
    return 'basierend auf $count Weinen';
  }

  @override
  String shareCompassPhrase(String descriptor, String trait) {
    return '$descriptor $trait';
  }

  @override
  String shareCompassShareText(String archetype, String url) {
    return 'Meine Wein-Persönlichkeit: $archetype · finde deine auf $url';
  }

  @override
  String get shareTastingEyebrow => 'GRUPPENVERKOSTUNG';

  @override
  String get shareTastingTopWine => 'TOP-WEIN DES ABENDS';

  @override
  String get shareTastingLineup => 'LINEUP';

  @override
  String shareTastingMore(int count) {
    return '+ $count weitere';
  }

  @override
  String get shareTastingAttendeesOne => '1 Verkoster';

  @override
  String shareTastingAttendeesMany(int count) {
    return '$count Verkoster';
  }

  @override
  String shareTastingShareTextTop(String wine, String avg, String url) {
    return '$wine hat den Abend gewonnen mit $avg/10 · auf Sippd veranstaltet · $url';
  }

  @override
  String shareTastingShareTextTitle(String title, String url) {
    return '$title · auf Sippd veranstaltet · $url';
  }

  @override
  String shareRatingShareText(String wine, String rating, String url) {
    return 'Gerade $wine mit $rating/10 auf Sippd bewertet · $url';
  }

  @override
  String get shareInviteEyebrow => 'EINE EINLADUNG';

  @override
  String get shareInviteHero => 'Lass uns gemeinsam\nverkosten.';

  @override
  String get shareInviteSub => 'Bewerten. Erinnern. Teilen.';

  @override
  String get shareInviteWantsToTaste => 'möchte mit dir verkosten';

  @override
  String shareInviteFallbackText(String name, String url) {
    return '$name möchte mit dir auf Sippd verkosten · $url';
  }

  @override
  String shareInviteImageText(String url) {
    return 'Komm zu mir auf Sippd 🍷  $url';
  }

  @override
  String get shareInviteSubject => 'Komm zu mir auf Sippd';

  @override
  String get shareRatingPromptSavedBadge => 'WEIN GESPEICHERT';

  @override
  String get shareRatingPromptTitle => 'Deine Karte ist fertig';

  @override
  String get shareRatingPromptBody =>
      'Schick sie Freunden oder poste sie in deiner Story.';

  @override
  String get shareRatingPromptCta => 'Karte teilen';

  @override
  String get shareRatingPromptPreparing => 'Wird vorbereitet…';

  @override
  String get shareRatingPromptDismiss => 'Nicht jetzt';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonClear => 'Löschen';

  @override
  String get commonGotIt => 'Verstanden';

  @override
  String get commonOptional => '(optional)';

  @override
  String get commonOffline => 'Offline';

  @override
  String get commonOfflineMessage =>
      'Du bist offline. Verbinde dich neu und versuch\'s nochmal.';

  @override
  String get commonNetworkErrorMessage =>
      'Netzwerkfehler. Prüfe deine Verbindung.';

  @override
  String get commonSomethingWentWrong => 'Etwas ist schiefgelaufen.';

  @override
  String get commonErrorViewOfflineTitle => 'Du bist offline';

  @override
  String get commonErrorViewOfflineSubtitle =>
      'Verbinde dich neu, um das zu laden.';

  @override
  String get commonErrorViewGenericTitle => 'Konnte nicht geladen werden';

  @override
  String get commonErrorViewGenericSubtitle =>
      'Zum Aktualisieren ziehen oder später nochmal versuchen.';

  @override
  String get commonInlineCouldntSaveRetry =>
      'Speichern fehlgeschlagen · Erneut';

  @override
  String get commonInlineOfflineRetry => 'Offline · Erneut';

  @override
  String get commonPhotoDialogCameraTitle => 'Kamerazugriff aus';

  @override
  String get commonPhotoDialogCameraBody =>
      'Sippd braucht Kamerazugriff, um Weinfotos aufzunehmen. Aktiviere ihn in den Einstellungen.';

  @override
  String get commonPhotoDialogPhotosTitle => 'Fotozugriff aus';

  @override
  String get commonPhotoDialogPhotosBody =>
      'Sippd braucht Zugriff auf deine Fotos, um Bilder anzuhängen. Aktiviere ihn in den Einstellungen.';

  @override
  String get commonPhotoErrorSnack =>
      'Foto konnte nicht geladen werden. Versuch\'s nochmal.';

  @override
  String get commonPriceSheetTitle => 'Flaschenpreis';

  @override
  String get commonYearPickerTitle => 'Jahrgang';

  @override
  String get locSheetTitle => 'Wo hast du ihn getrunken?';

  @override
  String get locSearchHint => 'Ort suchen...';

  @override
  String get locNoResults => 'Keine Orte gefunden';

  @override
  String get locSearchFailed => 'Suche fehlgeschlagen';

  @override
  String get locUseMyLocation => 'Meinen aktuellen Standort nutzen';

  @override
  String get locFindingLocation => 'Standort wird gesucht…';

  @override
  String get locReadCurrentFailed =>
      'Aktueller Standort konnte nicht ermittelt werden';

  @override
  String get locServicesDisabled => 'Ortungsdienste sind deaktiviert';

  @override
  String get locPermissionDenied => 'Standortberechtigung verweigert';

  @override
  String get profileEditTitle => 'Profil bearbeiten';

  @override
  String get profileEditSectionProfile => 'Profil';

  @override
  String get profileEditFieldUsername => 'Benutzername';

  @override
  String get profileEditFieldDisplayName => 'Anzeigename';

  @override
  String profileEditDisplayNameHintWithUsername(String username) {
    return 'z. B. $username';
  }

  @override
  String get profileEditDisplayNameHintGeneric => 'Wie sollen wir dich nennen?';

  @override
  String get profileEditDisplayNameHelper =>
      'Wird in Gruppen und Tastings angezeigt. Leer lassen, um deinen Benutzernamen zu nutzen.';

  @override
  String get profileEditSectionTaste => 'Dein Geschmack';

  @override
  String get profileEditSectionTasteSubtitle =>
      'Justiere, was Sippd über dich lernt. Jederzeit änderbar.';

  @override
  String get profileEditAvatarUpdateFailed =>
      'Foto konnte nicht aktualisiert werden. Versuch\'s nochmal.';

  @override
  String get profileEditUploadFailed => 'Upload fehlgeschlagen.';

  @override
  String get profileEditSaveChangesFailed =>
      'Änderungen konnten nicht gespeichert werden. Versuch\'s nochmal.';

  @override
  String get profileAvatarTakePhoto => 'Foto aufnehmen';

  @override
  String get profileAvatarChooseGallery => 'Aus Galerie wählen';

  @override
  String get profileAvatarRemove => 'Foto entfernen';

  @override
  String get profileUsernameTooShort => 'Mindestens 3 Zeichen';

  @override
  String get profileUsernameInvalid => 'Nur Buchstaben, Zahlen, . und _';

  @override
  String get profileUsernameTaken => 'Schon vergeben';

  @override
  String get profileUsernameAvailable => 'Verfügbar';

  @override
  String get profileUsernameChecking => 'Wird geprüft…';

  @override
  String get profileUsernameHelperIdle =>
      '3–20 Zeichen · Buchstaben, Zahlen, . und _';

  @override
  String get profileChooseUsernameTitle => 'Wähle einen Benutzernamen';

  @override
  String get profileChooseUsernameSubtitle =>
      'So finden dich Freunde auf Sippd.';

  @override
  String get profileChooseUsernameHint => 'benutzername';

  @override
  String get profileChooseUsernameContinue => 'Weiter';

  @override
  String get profileChooseUsernameSaveFailed =>
      'Benutzername konnte nicht gespeichert werden. Versuch\'s nochmal.';

  @override
  String get errNetworkDefault =>
      'Keine Internetverbindung. Lokale Daten werden verwendet.';

  @override
  String get errOffline =>
      'Du bist offline. Verbinde dich neu, um es erneut zu versuchen.';

  @override
  String errDatabase(String msg) {
    return 'Fehler in den lokalen Daten: $msg';
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
    return '$resource nicht gefunden.';
  }

  @override
  String get errNotFoundDefault => 'Nicht gefunden.';

  @override
  String get errUnauthorized => 'Bitte melde dich an, um fortzufahren.';

  @override
  String errServer(int code) {
    return 'Serverfehler ($code). Versuch\'s nochmal.';
  }

  @override
  String get errServerNoCode => 'Serverfehler. Versuch\'s nochmal.';

  @override
  String get errUnknown =>
      'Etwas ist schiefgelaufen. Bitte versuch\'s nochmal.';

  @override
  String routeNotFound(String uri) {
    return 'Seite nicht gefunden: $uri';
  }
}

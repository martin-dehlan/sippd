// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get notificationsTitle => 'Meldingen';

  @override
  String get notificationsLoadError => 'Kon meldingsinstellingen niet laden';

  @override
  String get sectionTastings => 'Proeverijen';

  @override
  String get sectionFriends => 'Vrienden';

  @override
  String get sectionGroups => 'Groepen';

  @override
  String get tileTastingRemindersLabel => 'Proeverij-herinneringen';

  @override
  String get tileTastingRemindersSubtitle =>
      'Seintje voordat een proeverij begint';

  @override
  String get tileFriendActivityLabel => 'Vriendenactiviteit';

  @override
  String get tileFriendActivitySubtitle => 'Verzoeken en acceptaties';

  @override
  String get tileGroupActivityLabel => 'Groepsactiviteit';

  @override
  String get tileGroupActivitySubtitle =>
      'Uitnodigingen, deelnames en nieuwe proeverijen';

  @override
  String get tileGroupWineSharedLabel => 'Nieuwe wijn gedeeld';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Als een vriend een wijn aan je groep toevoegt';

  @override
  String get hoursPickerLabel => 'Waarschuw me vooraf';

  @override
  String get hoursPickerHint =>
      'Geldt voor alle aankomende proeverijen — wijzig wanneer je wilt.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}u';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Taal';

  @override
  String get languageSheetTitle => 'Kies taal';

  @override
  String get languageOptionSystem => 'Systeemtaal';

  @override
  String get onbWelcomeTitle => 'Jouw wijn-\nmomenten.';

  @override
  String get onbWelcomeBody =>
      'Beoordeel de wijnen waar je van houdt. Onthoud ze voorgoed. Proef samen met vrienden.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Heb je al een account? ';

  @override
  String get onbWelcomeSignIn => 'Inloggen';

  @override
  String get onbWhyEyebrow => 'Waarom Sippd';

  @override
  String get onbWhyTitle => 'Gemaakt voor mensen\ndie echt wijn drinken.';

  @override
  String get onbWhyPrinciple1Headline => 'Foto. Beoordeel. Onthoud.';

  @override
  String get onbWhyPrinciple1Line => 'Drie tikken, volgend jaar zo terug.';

  @override
  String get onbWhyPrinciple2Headline => 'Proeverijen met vrienden.';

  @override
  String get onbWhyPrinciple2Line =>
      'Blind proeven, gedeelde scores. Geen spreadsheets.';

  @override
  String get onbWhyPrinciple3Headline => 'Werkt offline.';

  @override
  String get onbWhyPrinciple3Line =>
      'Noteer waar je ook bent. Synct zodra je thuis bent.';

  @override
  String get onbLevelEyebrow => 'Over jou';

  @override
  String get onbLevelTitle => 'Hoe diep zit je\nin de wijn?';

  @override
  String get onbLevelSubtitle =>
      'Geen fout antwoord. We stemmen suggesties af op jouw tempo.';

  @override
  String get onbLevelBeginnerLabel => 'Beginner';

  @override
  String get onbLevelBeginnerSubtitle => 'Net begonnen';

  @override
  String get onbLevelCuriousLabel => 'Nieuwsgierig';

  @override
  String get onbLevelCuriousSubtitle => 'Een paar favorieten';

  @override
  String get onbLevelEnthusiastLabel => 'Liefhebber';

  @override
  String get onbLevelEnthusiastSubtitle => 'Ik weet wat ik lekker vind';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Sommelierniveau';

  @override
  String get onbFreqEyebrow => 'Jouw ritme';

  @override
  String get onbFreqTitle => 'Hoe vaak open je\neen fles?';

  @override
  String get onbFreqWeekly => 'Wekelijks';

  @override
  String get onbFreqMonthly => 'Een paar keer per maand';

  @override
  String get onbFreqRare => 'Af en toe';

  @override
  String get onbGoalsEyebrow => 'Jouw doelen';

  @override
  String get onbGoalsTitle => 'Wat wil je\nuit Sippd halen?';

  @override
  String get onbGoalsSubtitle =>
      'Kies er één of meer. Je kunt dit later aanpassen.';

  @override
  String get onbGoalRemember => 'Flessen onthouden die ik lekker vind';

  @override
  String get onbGoalDiscover => 'Nieuwe stijlen ontdekken';

  @override
  String get onbGoalSocial => 'Proeven met vrienden';

  @override
  String get onbGoalValue => 'Bijhouden wat ik betaal';

  @override
  String get onbStylesEyebrow => 'Jouw stijlen';

  @override
  String get onbStylesTitle => 'Waar grijp je\nnaar?';

  @override
  String get onbStylesSubtitle =>
      'Vink aan wat bij je past. We houden je keuzes in de gaten.';

  @override
  String get wineTypeRed => 'Rood';

  @override
  String get wineTypeWhite => 'Wit';

  @override
  String get wineTypeRose => 'Rosé';

  @override
  String get wineTypeSparkling => 'Mousserend';

  @override
  String get onbRespEyebrow => 'Een woordje van ons';

  @override
  String get onbRespTitle => 'Drink minder,\nproef meer.';

  @override
  String get onbRespSubtitle =>
      'Sippd is om wijnen die je hebt genoten te onthouden en te beoordelen — niet om je te pushen meer te drinken. Geen reeksen of dagelijkse quota. Met opzet.';

  @override
  String get onbRespHelpBody =>
      'Als alcohol jou of iemand dicht bij je schaadt,\nis er gratis en vertrouwelijke hulp.';

  @override
  String get onbRespHelpCta => 'Vind hulp';

  @override
  String get onbNameEyebrow => 'Bijna klaar';

  @override
  String get onbNameTitle => 'Hoe noemen\nwe jou?';

  @override
  String get onbNameSubtitle =>
      'Voornaam, bijnaam — wat je maar wilt. Kies ook een icoon.';

  @override
  String get onbNameHint => 'Je naam';

  @override
  String get onbNameIconLabel => 'Kies je icoon';

  @override
  String get onbNameIconSubtitle => 'Verschijnt als je avatar.';

  @override
  String get onbNotifEyebrow => 'Blijf op de hoogte';

  @override
  String get onbNotifTitle => 'Mis nooit meer een\ngeweldige fles.';

  @override
  String get onbNotifSubtitle =>
      'We tikken je op de schouder als vrienden een proeverij starten of je uitnodigen voor een groep. Je kunt dit altijd uitzetten.';

  @override
  String get onbNotifPreview =>
      'Proeverij-uitnodigingen\nGroepsbeoordelingen\nVriendenactiviteit';

  @override
  String get onbNotifTurnOn => 'Meldingen aanzetten';

  @override
  String get onbNotifNotNow => 'Niet nu';

  @override
  String get onbLoaderAlmostThere => 'BIJNA KLAAR';

  @override
  String get onbLoaderCrafting => 'Je profiel wordt gemaakt.';

  @override
  String get onbLoaderAllSet => 'Klaar.';

  @override
  String get onbLoaderStepMatching => 'Je smaak afstemmen';

  @override
  String get onbLoaderStepCurating => 'Je stijlen samenstellen';

  @override
  String get onbLoaderStepSetting => 'Je dagboek inrichten';

  @override
  String get onbLoaderSeeProfile => 'Bekijk je profiel';

  @override
  String get onbLoaderContinue => 'Doorgaan';

  @override
  String get onbResultsEyebrow => 'JOUW SMAAKPROFIEL';

  @override
  String get onbResultsLevelCard => 'Niveau';

  @override
  String get onbResultsFreqCard => 'Frequentie';

  @override
  String get onbResultsStylesCard => 'Stijlen';

  @override
  String get onbResultsGoalsCard => 'Doelen';

  @override
  String get onbArchSommTitle => 'Doorgewinterde somm';

  @override
  String get onbArchSommSubtitle =>
      'Je kent je terroir. Sippd bewaart de bewijzen.';

  @override
  String get onbArchPalateTitle => 'Scherp gehemelte';

  @override
  String get onbArchPalateSubtitle => 'Nuancejager. Sippd vangt het detail.';

  @override
  String get onbArchRegularTitle => 'Vaste klant';

  @override
  String get onbArchRegularSubtitle =>
      'Een fles per week, elke maand scherpere meningen.';

  @override
  String get onbArchDevotedTitle => 'Toegewijde proever';

  @override
  String get onbArchDevotedSubtitle =>
      'Serieus bij elk glas. Sippd bewaart je notities.';

  @override
  String get onbArchRedTitle => 'Roodliefhebber';

  @override
  String get onbArchRedSubtitle =>
      'Eén druif per glas. Wij helpen je verbreden.';

  @override
  String get onbArchBubbleTitle => 'Bubbeljager';

  @override
  String get onbArchBubbleSubtitle =>
      'Bubbels boven alles. Sippd noteert de goede.';

  @override
  String get onbArchOpenTitle => 'Open gehemelte';

  @override
  String get onbArchOpenSubtitle =>
      'Rood, wit, roze, mousserend — alles welkom. Noteer ze allemaal.';

  @override
  String get onbArchSteadyTitle => 'Vaste proever';

  @override
  String get onbArchSteadySubtitle =>
      'Wijn blijft in de rotatie. Sippd houdt de draad vast.';

  @override
  String get onbArchNowAndThenTitle => 'Af-en-toe-proever';

  @override
  String get onbArchNowAndThenSubtitle =>
      'Wijn voor de momenten die ertoe doen.';

  @override
  String get onbArchOccasionalTitle => 'Af en toe een glas';

  @override
  String get onbArchOccasionalSubtitle => 'Zeldzaam glas, het onthouden waard.';

  @override
  String get onbArchFreshTitle => 'Vers gehemelte';

  @override
  String get onbArchFreshSubtitle => 'Nieuwe reis. Elke fles telt vanaf nu.';

  @override
  String get onbArchCuriousTitle => 'Wijn-nieuwsgierig';

  @override
  String get onbArchCuriousSubtitle =>
      'Vertel ons meer en je profiel wordt scherper.';

  @override
  String get onbCtaGetStarted => 'Beginnen';

  @override
  String get onbCtaIUnderstand => 'Begrepen';

  @override
  String get onbCtaContinue => 'Doorgaan';

  @override
  String get onbCtaSignInToSave => 'Log in om op te slaan';

  @override
  String get onbCtaSaveAndContinue => 'Opslaan en doorgaan';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Niveau';

  @override
  String get tasteEditorFreq => 'Hoe vaak';

  @override
  String get tasteEditorStyles => 'Favoriete stijlen';

  @override
  String get tasteEditorGoals => 'Wat je zoekt';

  @override
  String get tasteEditorFreqWeekly => 'Wekelijks';

  @override
  String get tasteEditorFreqMonthly => 'Maandelijks';

  @override
  String get tasteEditorFreqRare => 'Zelden';

  @override
  String get tasteEditorGoalRemember => 'Onthouden';

  @override
  String get tasteEditorGoalDiscover => 'Ontdekken';

  @override
  String get tasteEditorGoalSocial => 'Sociaal';

  @override
  String get tasteEditorGoalValue => 'Waarde';

  @override
  String get authLoginWelcomeBack => 'Welkom terug';

  @override
  String get authLoginCreateAccount => 'Maak je account';

  @override
  String get authLoginDisplayNameLabel => 'Weergavenaam';

  @override
  String get authLoginEmailLabel => 'E-mail';

  @override
  String get authLoginPasswordLabel => 'Wachtwoord';

  @override
  String get authLoginConfirmPasswordLabel => 'Wachtwoord bevestigen';

  @override
  String get authLoginDisplayNameMin => 'Min. 2 tekens';

  @override
  String get authLoginDisplayNameMax => 'Max. 30 tekens';

  @override
  String get authLoginEmailInvalid => 'Geldig e-mailadres vereist';

  @override
  String get authLoginPasswordMin => 'Min. 8 tekens';

  @override
  String get authLoginPasswordRequired => 'Voer een wachtwoord in';

  @override
  String get authLoginPasswordsDontMatch => 'Wachtwoorden komen niet overeen';

  @override
  String get authLoginForgotPassword => 'Wachtwoord vergeten?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Voer eerst een geldig e-mailadres in hierboven.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Kon account niet aanmaken. Probeer het opnieuw.';

  @override
  String get authLoginSignInFailedFallback =>
      'Inloggen mislukt. Controleer je gegevens.';

  @override
  String get authLoginCreateAccountButton => 'Account aanmaken';

  @override
  String get authLoginSignInButton => 'Inloggen';

  @override
  String get authLoginToggleHaveAccount => 'Heb je al een account? Log in';

  @override
  String get authLoginToggleNoAccount => 'Nog geen account? Meld je aan';

  @override
  String get authOrDivider => 'of';

  @override
  String get authGoogleContinue => 'Doorgaan met Google';

  @override
  String get authGoogleFailed =>
      'Inloggen met Google mislukt. Probeer het opnieuw.';

  @override
  String get authConfTitleReset => 'Reset-link verstuurd';

  @override
  String get authConfTitleSignup => 'Check je inbox';

  @override
  String get authConfIntroReset => 'We hebben een reset-link gestuurd naar';

  @override
  String get authConfIntroSignup =>
      'We hebben een bevestigingslink gestuurd naar';

  @override
  String get authConfOutroReset =>
      '.\nTik erop om een nieuw wachtwoord in te stellen.';

  @override
  String get authConfOutroSignup => '.\nTik erop om je account te activeren.';

  @override
  String get authConfOpenMailApp => 'Mail-app openen';

  @override
  String get authConfNoMailApps => 'No mail app found on this device';

  @override
  String get authConfResendEmail => 'Mail opnieuw versturen';

  @override
  String get authConfResendSending => 'Versturen…';

  @override
  String authConfResendIn(int seconds) {
    return 'Opnieuw in ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'Mail verstuurd.';

  @override
  String get authConfResendFailedFallback =>
      'Kon niet versturen. Probeer het zo opnieuw.';

  @override
  String get authConfBackToSignIn => 'Terug naar inloggen';

  @override
  String get authResetTitle => 'Stel een nieuw wachtwoord in';

  @override
  String get authResetSubtitle =>
      'Kies een wachtwoord dat je nog niet eerder hebt gebruikt.';

  @override
  String get authResetNewPasswordLabel => 'Nieuw wachtwoord';

  @override
  String get authResetConfirmPasswordLabel => 'Wachtwoord bevestigen';

  @override
  String get authResetPasswordMin => 'Min. 6 tekens';

  @override
  String get authResetPasswordsDontMatch => 'Wachtwoorden komen niet overeen';

  @override
  String get authResetFailedFallback =>
      'Kon wachtwoord niet bijwerken. Probeer het opnieuw.';

  @override
  String get authResetUpdateButton => 'Wachtwoord bijwerken';

  @override
  String get authResetUpdatedSnack => 'Wachtwoord bijgewerkt.';

  @override
  String get authProfileGuest => 'Gast';

  @override
  String get authProfileSectionAccount => 'Account';

  @override
  String get authProfileSectionSupport => 'Support';

  @override
  String get authProfileSectionLegal => 'Juridisch';

  @override
  String get authProfileEditProfile => 'Profiel bewerken';

  @override
  String get authProfileFriends => 'Vrienden';

  @override
  String get authProfileNotifications => 'Meldingen';

  @override
  String get authProfileAnimations => 'Animations';

  @override
  String get animationsTitle => 'Animations';

  @override
  String get animationsMasterLabel => 'Animations';

  @override
  String get animationsMasterSubtitle => 'Subtle motion throughout the app';

  @override
  String get animationsScreenTransitionsLabel => 'Screen transitions';

  @override
  String get animationsScreenTransitionsSubtitle =>
      'Pages fade and slide in when opened';

  @override
  String get animationsListEntrancesLabel => 'List & card entrances';

  @override
  String get animationsListEntrancesSubtitle =>
      'Cards gently stagger into view';

  @override
  String get animationsTabCrossfadeLabel => 'Tab crossfade';

  @override
  String get animationsTabCrossfadeSubtitle => 'Soft fade when switching tabs';

  @override
  String get animationsValueAnimationsLabel => 'Counting numbers & bars';

  @override
  String get animationsValueAnimationsSubtitle =>
      'Stats and ratings animate to their value';

  @override
  String get animationsReducedBySystemNote =>
      'Your device\'s Reduce Motion setting is on, so in-app animations stay off.';

  @override
  String get authProfileCleanupDuplicates => 'Duplicaten opruimen';

  @override
  String get authProfileSubscription => 'Abonnement';

  @override
  String get authProfileChangePassword => 'Wachtwoord wijzigen';

  @override
  String get authProfileContactUs => 'Neem contact op';

  @override
  String get authProfileRateSippd => 'Beoordeel Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Privacybeleid';

  @override
  String get authProfileTermsOfService => 'Servicevoorwaarden';

  @override
  String get authProfileSignOut => 'Uitloggen';

  @override
  String get authProfileSignIn => 'Inloggen';

  @override
  String get authProfileDeleteAccount => 'Account verwijderen';

  @override
  String get authProfileViewFullStats => 'Bekijk alle stats';

  @override
  String get authProfileChangePasswordDialogTitle => 'Wachtwoord wijzigen?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'We sturen een reset-link naar $email. Tik erop vanuit je inbox om een nieuw wachtwoord in te stellen.';
  }

  @override
  String get authProfileCancel => 'Annuleren';

  @override
  String get authProfileSendLink => 'Link versturen';

  @override
  String get authProfileSendLinkFailedTitle => 'Kon link niet versturen';

  @override
  String get authProfileSendLinkFailedFallback => 'Probeer het zo opnieuw.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'Kon $url niet openen';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Account verwijderen?';

  @override
  String get authProfileDeleteDialogBody =>
      'Hiermee verwijder je permanent je profiel, wijnen, beoordelingen, proeverijen, groepslidmaatschappen en vrienden. Kan niet ongedaan worden gemaakt.';

  @override
  String get authProfileDeleteTypeConfirm => 'Typ DELETE om te bevestigen:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Verwijderen';

  @override
  String get authProfileDeleteFailedFallback => 'Verwijderen mislukt.';

  @override
  String get winesListSubtitle => 'Jouw wijnranglijst';

  @override
  String get winesListSortRating => 'Sorteer: cijfer';

  @override
  String get winesListSortRecent => 'Sorteer: recent';

  @override
  String get winesListSortName => 'Sorteer: naam';

  @override
  String get winesListTooltipStats => 'Jouw stats';

  @override
  String get winesListTooltipAddWine => 'Wijn toevoegen';

  @override
  String get winesListErrorLoad => 'Kon wijnen niet laden';

  @override
  String get winesEmptyTitle => 'Nog geen wijnen';

  @override
  String get winesEmptyFilteredTitle => 'Geen wijnen voldoen aan filter';

  @override
  String get winesEmptyFilteredBody => 'Probeer een ander filter';

  @override
  String get winesEmptyAddWineCta => 'Wijn toevoegen';

  @override
  String get winesAddSaveLabel => 'Wijn opslaan';

  @override
  String get winesAddDiscardTitle => 'Nieuwe wijn weggooien?';

  @override
  String get winesAddDiscardBody =>
      'Je hebt deze wijn nog niet opgeslagen. Als je nu weggaat, gaan je wijzigingen verloren.';

  @override
  String get winesAddDiscardKeepEditing => 'Verder bewerken';

  @override
  String get winesAddDiscardConfirm => 'Weggooien';

  @override
  String get winesAddDuplicateTitle => 'Lijkt op een duplicaat';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Je hebt \"$name\" al genoteerd met hetzelfde jaar, wijnhuis en druif. Open het bestaande exemplaar of voeg toch een nieuwe toe?';
  }

  @override
  String get winesAddDuplicateCancel => 'Annuleren';

  @override
  String get winesAddDuplicateAddAnyway => 'Toch toevoegen';

  @override
  String get winesAddDuplicateOpenExisting => 'Bestaande openen';

  @override
  String get winesDetailNotFound => 'Wijn niet gevonden';

  @override
  String get winesDetailErrorLoad => 'Kon wijn niet laden';

  @override
  String get winesDetailMenuCompare => 'Vergelijk met…';

  @override
  String get winesDetailMenuShareRating => 'Cijfer delen';

  @override
  String get winesDetailMenuShareToGroup => 'Delen met groep';

  @override
  String get winesDetailMenuEdit => 'Wijn bewerken';

  @override
  String get winesDetailMenuTastingNotesPro => 'Proefnotities (Pro)';

  @override
  String get winesDetailMenuDelete => 'Wijn verwijderen';

  @override
  String get winesDetailStatRating => 'Cijfer';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Prijs';

  @override
  String get winesDetailStatRegion => 'Regio';

  @override
  String get winesDetailStatCountry => 'Land';

  @override
  String get winesDetailSectionNotes => 'NOTITIES';

  @override
  String get winesDetailSectionPlace => 'PLEKKEN';

  @override
  String get winesDetailPlaceEmpty => 'Geen plek ingesteld';

  @override
  String get winesDetailDeleteTitle => 'Wijn verwijderen?';

  @override
  String get winesDetailDeleteBody => 'Dit kan niet ongedaan worden gemaakt.';

  @override
  String get winesDetailDeleteCancel => 'Annuleren';

  @override
  String get winesDetailDeleteConfirm => 'Verwijderen';

  @override
  String get winesEditErrorLoad => 'Kon wijn niet laden';

  @override
  String get winesEditErrorMemories => 'Kon momenten niet laden';

  @override
  String get winesEditNotFound => 'Wijn niet gevonden';

  @override
  String get winesCleanupTitle => 'Duplicaten opruimen';

  @override
  String get winesCleanupErrorLoad => 'Kon duplicaten niet laden';

  @override
  String get winesCleanupEmptyTitle => 'Geen duplicaten om op te ruimen';

  @override
  String get winesCleanupEmptyBody =>
      'Je wijnen zijn netjes. We checken automatisch op bijna-identieke namen en wijnhuizen.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% match';
  }

  @override
  String get winesCleanupKeepA => 'Houd A';

  @override
  String get winesCleanupKeepB => 'Houd B';

  @override
  String get winesCleanupSkippedSnack =>
      'Voor nu overgeslagen — komt volgende keer weer terug.';

  @override
  String get winesCleanupDifferentWines => 'Het zijn verschillende wijnen';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'Samenvoegen in \"$name\"?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Elke beoordeling, groepsdeling en stat die naar \"$loser\" wees, verhuist naar \"$keeper\". Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get winesCleanupMergeCancel => 'Annuleren';

  @override
  String get winesCleanupMergeConfirm => 'Samenvoegen';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Samengevoegd in \"$name\".';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Samenvoegen mislukt.';

  @override
  String get winesCompareHeader => 'VERGELIJKEN';

  @override
  String get winesComparePickerSubtitle => 'Kies de tweede wijn.';

  @override
  String get winesComparePickerEmptyTitle => 'Nog geen andere wijnen';

  @override
  String get winesComparePickerEmptyBody =>
      'Voeg minstens één wijn meer toe om te vergelijken.';

  @override
  String get winesComparePickerErrorFallback => 'Kon wijnen niet laden.';

  @override
  String get winesCompareMissingSameWine =>
      'Kies een andere wijn om te vergelijken.';

  @override
  String get winesCompareMissingDefault => 'Kon beide wijnen niet laden.';

  @override
  String get winesCompareErrorFallback => 'Kon wijnen niet laden.';

  @override
  String get winesCompareSectionAtAGlance => 'In één oogopslag';

  @override
  String get winesCompareSectionTasting => 'Proefprofiel';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Body, tannine, zuren, zoetheid, hout, afdronk.';

  @override
  String get winesCompareSectionNotes => 'Notities';

  @override
  String get winesCompareAttrType => 'TYPE';

  @override
  String get winesCompareAttrVintage => 'JAAR';

  @override
  String get winesCompareAttrGrape => 'DRUIF';

  @override
  String get winesCompareAttrOrigin => 'HERKOMST';

  @override
  String get winesCompareAttrPrice => 'PRIJS';

  @override
  String get winesCompareNotesEyebrow => 'NOTITIES';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'WIJN $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Vergelijk body, tannine, zuren en meer naast elkaar.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Ontgrendel met Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Voeg proefnotities toe aan een van de wijnen om ze hier vergeleken te zien.';

  @override
  String get winesFormHintName => 'Wijnnaam';

  @override
  String get winesFormSubmitDefault => 'Wijn opslaan';

  @override
  String get winesFormPhotoLabel => 'Foto';

  @override
  String get winesFormPlaceSectionHeader => 'Eerste Sipp';

  @override
  String get winesFormStatRating => 'Cijfer';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Prijs';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Regio';

  @override
  String get winesFormStatCountry => 'Land';

  @override
  String get winesFormChipWinery => 'Wijnhuis';

  @override
  String get winesFormChipGrape => 'Druif';

  @override
  String get winesFormChipYear => 'Jaar';

  @override
  String get winesFormChipNotes => 'Notities';

  @override
  String get winesFormChipNotesFilled => 'Notities ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Waar dronk je \'m?';

  @override
  String get winesFormWineryTitle => 'Wijnhuis';

  @override
  String get winesFormWineryHint => 'bv. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Proefnotities';

  @override
  String get winesFormNotesHint => 'Aroma\'s, body, afdronk…';

  @override
  String get winesFormTypeRed => 'Rood';

  @override
  String get winesFormTypeWhite => 'Wit';

  @override
  String get winesFormTypeRose => 'Rosé';

  @override
  String get winesFormTypeSparkling => 'Mousserend';

  @override
  String get winesMemoriesHeader => 'Momenten';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Momenten ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Toevoegen';

  @override
  String get winesMemoriesRemoveTitle => 'Moment verwijderen?';

  @override
  String get winesMemoriesRemoveBody =>
      'Hiermee haal je dit moment van de wijn af.';

  @override
  String get winesMemoriesRemoveCancel => 'Annuleren';

  @override
  String get winesMemoriesRemoveConfirm => 'Verwijderen';

  @override
  String get momentSheetNewTitle => 'Nieuw moment';

  @override
  String get momentSheetEditTitle => 'Moment bewerken';

  @override
  String get momentFieldPhotos => 'Foto\'s';

  @override
  String get momentFieldWhen => 'Wanneer';

  @override
  String get momentFieldOccasion => 'Gelegenheid';

  @override
  String get momentFieldCompanions => 'Met';

  @override
  String get momentFieldPlace => 'Waar';

  @override
  String get momentFieldFood => 'Gecombineerd met';

  @override
  String get momentFieldNote => 'Notitie';

  @override
  String get momentFieldVisibility => 'Zichtbaarheid';

  @override
  String get momentAddPhoto => 'Foto toevoegen';

  @override
  String get momentPhotoCap => 'Tot 10 foto\'s';

  @override
  String get momentOccasionDinner => 'Diner';

  @override
  String get momentOccasionDate => 'Date';

  @override
  String get momentOccasionCelebration => 'Feest';

  @override
  String get momentOccasionTasting => 'Proeverij';

  @override
  String get momentOccasionCasual => 'Casual';

  @override
  String get momentOccasionBirthday => 'Verjaardag';

  @override
  String get momentCompanionsAddFriend => 'Vriend toevoegen';

  @override
  String get momentCompanionsEmpty => 'Nog geen vrienden om te taggen.';

  @override
  String get friendsProfileSharedMoments => 'Gedeelde momenten';

  @override
  String get winesShareToFriend => 'Delen met vriend';

  @override
  String winesShareSuccess(String name) {
    return 'Wijn gedeeld met $name';
  }

  @override
  String get winesShareError => 'Kon niet delen — probeer opnieuw';

  @override
  String get winesSharePickFriendsTitle => 'Delen met';

  @override
  String get winesExpertProUnlock => 'Ontgrendel met Pro';

  @override
  String get momentShowcaseApplied => 'Ingesteld als hoofdfoto van de wijn.';

  @override
  String get momentShowcaseError =>
      'Kon niet als hoofdfoto instellen. Probeer het opnieuw.';

  @override
  String get momentPlaceHint => 'Restaurant of plek';

  @override
  String get momentFoodHint => 'Waarmee combineerde je \'m?';

  @override
  String get momentNoteHint => 'Iets om te onthouden?';

  @override
  String get momentVisibilityFriends => 'Vrienden';

  @override
  String get momentVisibilityPrivate => 'Privé';

  @override
  String get momentSave => 'Moment opslaan';

  @override
  String get momentSaveError => 'Kon moment niet opslaan';

  @override
  String get momentEdit => 'Bewerken';

  @override
  String get momentDelete => 'Verwijderen';

  @override
  String get momentDeleteConfirmTitle => 'Moment verwijderen?';

  @override
  String get momentDeleteConfirmBody =>
      'Dit verwijdert dit moment en zijn foto\'s permanent.';

  @override
  String get momentUseAsShowcase => 'Als uitgelichte foto gebruiken';

  @override
  String get momentTastingAdd => 'Proeverij-moment toevoegen';

  @override
  String get momentValidationEmpty =>
      'Voeg een foto of notitie toe om op te slaan';

  @override
  String get momentSectionHeader => 'Momenten';

  @override
  String get momentSectionAdd => 'Nieuw';

  @override
  String get momentSectionEmpty => 'Nog geen momenten — tik op +.';

  @override
  String momentMetaWith(String names) {
    return 'Met $names';
  }

  @override
  String get winesPhotoSourceTake => 'Foto maken';

  @override
  String get winesPhotoSourceGallery => 'Kies uit galerij';

  @override
  String get winesGrapeSheetTitle => 'Druivenras';

  @override
  String get winesGrapeSheetHint => 'bv. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Gebruik \"';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '\" als eigen invoer';

  @override
  String get winesGrapeSheetEmpty => 'Nog geen druiven beschikbaar.';

  @override
  String get winesGrapeSheetErrorLoad => 'Kon druivencatalogus niet laden.';

  @override
  String get winesGrapeSheetUseTyped => 'Gebruik wat ik typte';

  @override
  String get winesRegionSheetTitle => 'Wijnregio';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Kies uit welk deel van $country de wijn komt — of sla over als je het niet zeker weet.';
  }

  @override
  String get winesRegionSheetSkip => 'Overslaan';

  @override
  String get winesRegionSheetSearchHint => 'Zoek regio...';

  @override
  String get winesRegionSheetClear => 'Regio wissen';

  @override
  String get winesRegionSheetOther => 'Andere regio…';

  @override
  String get winesRegionSheetOtherTitle => 'Regio';

  @override
  String get winesRegionSheetOtherHint => 'bv. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Zoek land...';

  @override
  String get winesCountrySheetTopHeader => 'Top wijnlanden';

  @override
  String get winesCountrySheetOtherHeader => 'Andere landen';

  @override
  String get winesRatingSheetSaveCta => 'Cijfer opslaan';

  @override
  String get winesRatingSheetCancel => 'Annuleren';

  @override
  String get winesRatingSheetSaveError => 'Kon niet opslaan.';

  @override
  String get winesRatingHeaderLabel => 'JOUW CIJFER';

  @override
  String get winesRatingChipTasting => 'Proefnotities';

  @override
  String get winesRatingInputLabel => 'Cijfer';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Sla de wijn eerst op — proefnotities koppelen aan de canonieke id.';

  @override
  String get winesExpertSheetTitle => 'Proefnotities';

  @override
  String get winesExpertSheetSubtitle => 'WSET-achtige waarnemingen';

  @override
  String get winesExpertSheetSave => 'Opslaan';

  @override
  String get winesExpertAxisBody => 'Body';

  @override
  String get winesExpertAxisTannin => 'Tannine';

  @override
  String get winesExpertAxisAcidity => 'Zuren';

  @override
  String get winesExpertAxisSweetness => 'Zoetheid';

  @override
  String get winesExpertAxisOak => 'Hout';

  @override
  String get winesExpertAxisFinish => 'Afdronk';

  @override
  String get winesExpertAxisAromas => 'Aroma\'s';

  @override
  String get winesExpertBodyLow => 'licht';

  @override
  String get winesExpertBodyHigh => 'vol';

  @override
  String get winesExpertTanninLow => 'zacht';

  @override
  String get winesExpertTanninHigh => 'stevig';

  @override
  String get winesExpertAcidityLow => 'zacht';

  @override
  String get winesExpertAcidityHigh => 'fris';

  @override
  String get winesExpertSweetnessLow => 'droog';

  @override
  String get winesExpertSweetnessHigh => 'zoet';

  @override
  String get winesExpertOakLow => 'ongehout';

  @override
  String get winesExpertOakHigh => 'zwaar';

  @override
  String get winesExpertFinishShort => 'Kort';

  @override
  String get winesExpertFinishMedium => 'Middel';

  @override
  String get winesExpertFinishLong => 'Lang';

  @override
  String get winesExpertSummaryHeader => 'PROEFNOTITIES';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMA\'S';

  @override
  String get winesExpertSummaryAxisBody => 'BODY';

  @override
  String get winesExpertSummaryAxisTannin => 'TANNINE';

  @override
  String get winesExpertSummaryAxisAcidity => 'ZUREN';

  @override
  String get winesExpertSummaryAxisSweetness => 'ZOETHEID';

  @override
  String get winesExpertSummaryAxisOak => 'HOUT';

  @override
  String get winesExpertSummaryAxisFinish => 'AFDRONK';

  @override
  String get winesExpertDescriptorBody1 => 'heel licht';

  @override
  String get winesExpertDescriptorBody2 => 'licht';

  @override
  String get winesExpertDescriptorBody3 => 'middel';

  @override
  String get winesExpertDescriptorBody4 => 'vol';

  @override
  String get winesExpertDescriptorBody5 => 'zwaar';

  @override
  String get winesExpertDescriptorTannin1 => 'zijdezacht';

  @override
  String get winesExpertDescriptorTannin2 => 'zacht';

  @override
  String get winesExpertDescriptorTannin3 => 'middel';

  @override
  String get winesExpertDescriptorTannin4 => 'ferm';

  @override
  String get winesExpertDescriptorTannin5 => 'stevig';

  @override
  String get winesExpertDescriptorAcidity1 => 'vlak';

  @override
  String get winesExpertDescriptorAcidity2 => 'zacht';

  @override
  String get winesExpertDescriptorAcidity3 => 'in balans';

  @override
  String get winesExpertDescriptorAcidity4 => 'fris';

  @override
  String get winesExpertDescriptorAcidity5 => 'scherp';

  @override
  String get winesExpertDescriptorSweetness1 => 'kurkdroog';

  @override
  String get winesExpertDescriptorSweetness2 => 'droog';

  @override
  String get winesExpertDescriptorSweetness3 => 'halfdroog';

  @override
  String get winesExpertDescriptorSweetness4 => 'zoet';

  @override
  String get winesExpertDescriptorSweetness5 => 'weelderig';

  @override
  String get winesExpertDescriptorOak1 => 'ongehout';

  @override
  String get winesExpertDescriptorOak2 => 'subtiel';

  @override
  String get winesExpertDescriptorOak3 => 'aanwezig';

  @override
  String get winesExpertDescriptorOak4 => 'houtgedreven';

  @override
  String get winesExpertDescriptorOak5 => 'zwaar';

  @override
  String get winesExpertDescriptorFinish1 => 'kort';

  @override
  String get winesExpertDescriptorFinish2 => 'middel';

  @override
  String get winesExpertDescriptorFinish3 => 'lang';

  @override
  String get winesCanonicalPromptTitle => 'Dezelfde wijn?';

  @override
  String get winesCanonicalPromptBody =>
      'Lijkt op een wijn die al in de catalogus staat. Koppelen houdt je stats en matches accuraat.';

  @override
  String get winesCanonicalPromptInputLabel => 'Wat je toevoegt';

  @override
  String get winesCanonicalPromptExistingLabel => 'AL IN CATALOGUS';

  @override
  String get winesCanonicalPromptDifferent => 'Nee, dit is een andere wijn';

  @override
  String get winesFriendRatingsHeader => 'VRIENDEN DIE BEOORDEELDEN';

  @override
  String get winesFriendRatingsFallback => 'Vriend';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count meer';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Alle';

  @override
  String get winesTypeFilterRed => 'Rood';

  @override
  String get winesTypeFilterWhite => 'Wit';

  @override
  String get winesTypeFilterRose => 'Rosé';

  @override
  String get winesTypeFilterSparkling => 'Mousserend';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Jouw wijnreis, in beeld';

  @override
  String get winesStatsPreviewBadge => 'VOORBEELD';

  @override
  String get winesStatsPreviewHint => 'Wat je ziet na een paar beoordelingen.';

  @override
  String get winesStatsEmptyEyebrow => 'BEGINNEN';

  @override
  String get winesStatsEmptyTitle => 'Je stats beginnen met een cijfer';

  @override
  String get winesStatsEmptyBody =>
      'Beoordeel je eerste wijn om hier je smaak, regio\'s en waarde tot leven te brengen.';

  @override
  String get winesStatsEmptyCta => 'Beoordeel een wijn';

  @override
  String get winesStatsHeroLabel => 'JOUW GEMIDDELDE';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'persoonlijk';

  @override
  String get winesStatsHeroChipGroup => 'groep';

  @override
  String get winesStatsHeroChipTasting => 'proeverij';

  @override
  String get winesStatsSectionTypeBreakdown => 'Verdeling per type';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Hoe je smaak verdeeld is over de vier stijlen.';

  @override
  String get winesStatsSectionTopRated => 'Hoogst beoordeeld';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Jouw persoonlijke podium.';

  @override
  String get winesStatsSectionTimeline => 'Tijdlijn';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Maand voor maand, de wijnen die je jaar schreven.';

  @override
  String get winesStatsSectionPartners => 'Drinkmaatjes';

  @override
  String get winesStatsSectionPartnersSubtitle =>
      'Met wie je het meest proeft.';

  @override
  String get winesStatsSectionPrices => 'Prijzen & waarde';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Som van flesprijzen genoteerd op je beoordeelde wijnen — niet de werkelijke consumptie-uitgaven.';

  @override
  String get winesStatsSectionPlaces => 'Waar je je wijnen tegenkwam';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Eén pin per wijn, je eerste Sipp.';

  @override
  String get winesStatsSectionRegions => 'Topregio\'s';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'Waar de meeste van je flessen vandaan komen.';

  @override
  String get winesStatsPartnersErrorTitle => 'Kon maatjes niet laden';

  @override
  String get winesStatsPartnersErrorBody => 'Trek omlaag of kom zo terug.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Samen proeven';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Zodra jij en een vriend dezelfde wijn in een groep beoordelen, verschijnen ze hier.';

  @override
  String get winesStatsPartnersCta => 'Open groepen';

  @override
  String get winesStatsPriceEmptyTitle => 'Voeg een prijs toe';

  @override
  String get winesStatsPriceEmptyBody =>
      'Noteer wat je betaalde om uitgaven, gemiddelde prijs en beste keuzes te ontgrendelen.';

  @override
  String get winesStatsPriceEmptyCta => 'Bewerk een wijn';

  @override
  String get winesStatsPlacesEmptyTitle => 'Voeg een locatie toe';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Zet een pin op een wijn om in kaart te brengen waar je drinkt — bars, diners, trips.';

  @override
  String get winesStatsPlacesEmptyCta => 'Bewerk een wijn';

  @override
  String get winesStatsRegionsEmptyTitle => 'Voeg een regio toe';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Tag wijnen met een regio of land om te zien waar je smaak naartoe neigt.';

  @override
  String get winesStatsRegionsEmptyCta => 'Bewerk een wijn';

  @override
  String get winesStatsPartnersHint =>
      'Telt wijnen die samen zijn beoordeeld in gedeelde groepen.';

  @override
  String get winesStatsPartnersFallback => 'Wijnmaatje';

  @override
  String get winesStatsSpendingLabel => 'BEOORDEELDE PORTFOLIO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wijnen met prijs',
      one: '1 wijn met prijs',
    );
    return 'over $_temp0 · gem. $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Duurst';

  @override
  String get winesStatsSpendingBestValue => 'Beste prijs-kwaliteit';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count meer';
  }

  @override
  String get winesStatsProLockTitle => 'Ontgrendel 3 extra inzichten';

  @override
  String get winesStatsProLockBody =>
      'Zie waar je flessen vandaan kwamen, wat je uitgeeft en op welke regio\'s je het meest inzet.';

  @override
  String get winesStatsProLockPillPrices => 'Prijzen';

  @override
  String get winesStatsProLockPillWhere => 'Waar';

  @override
  String get winesStatsProLockPillRegions => 'Topregio\'s';

  @override
  String get winesStatsProLockCta => 'Ontgrendel met Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 eerdere maand';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count eerdere maanden';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wijnen',
      one: '1 wijn',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plekken',
      one: '1 plek',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Sluiten';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'wijn';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'wijnen';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Meest gedronken';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Best beoordeeld';

  @override
  String get tastingCreateHeader => 'NIEUWE PROEVERIJ';

  @override
  String get tastingEditHeader => 'PROEVERIJ BEWERKEN';

  @override
  String get tastingFieldTitleLabel => 'Titel';

  @override
  String get tastingFieldDateLabel => 'Datum';

  @override
  String get tastingFieldTimeLabel => 'Tijd';

  @override
  String get tastingFieldPlaceLabel => 'Plek';

  @override
  String get tastingFieldDescriptionLabel => 'Beschrijving';

  @override
  String get tastingFieldTapToAdd => 'Tik om toe te voegen';

  @override
  String get tastingFieldOpenLineupLabel => 'Open line-up';

  @override
  String get tastingFieldOpenLineupHint =>
      'Voeg wijnen toe zodra ze binnenkomen';

  @override
  String get tastingTitleSheetTitle => 'Proeverij-titel';

  @override
  String get tastingTitleSheetHint => 'bv. Barolo-avond';

  @override
  String get tastingDescriptionSheetTitle => 'Beschrijving';

  @override
  String get tastingDescriptionSheetHint => 'Waar gaat dit over?';

  @override
  String get tastingCreateSubmitCta => 'Proeverij aanmaken';

  @override
  String get tastingEditSubmitCta => 'Wijzigingen opslaan';

  @override
  String get tastingCreateFailedSnack => 'Kon proeverij niet aanmaken';

  @override
  String get tastingUpdateFailedSnack => 'Kon proeverij niet bijwerken';

  @override
  String get tastingDetailNotFound => 'Proeverij niet gevonden';

  @override
  String get tastingDetailErrorLoad => 'Kon proeverij niet laden';

  @override
  String get tastingDetailMenuAddToCalendar => 'Aan agenda toevoegen';

  @override
  String get tastingDetailMenuShare => 'Delen';

  @override
  String get tastingDetailMenuEdit => 'Proeverij bewerken';

  @override
  String get tastingDetailMenuCancel => 'Proeverij annuleren';

  @override
  String get tastingDetailCancelDialogTitle => 'Proeverij annuleren?';

  @override
  String get tastingDetailCancelDialogBody =>
      'Hiermee verwijder je \'m voor iedereen.';

  @override
  String get tastingDetailCancelDialogKeep => 'Behouden';

  @override
  String get tastingDetailCancelDialogConfirm => 'Annuleren';

  @override
  String get tastingDetailEndDialogTitle => 'Proeverij beëindigen?';

  @override
  String get tastingDetailEndDialogBody =>
      'Hiermee vergrendel je de recap. Deelnemers kunnen daarna nog kort beoordelingen toevoegen.';

  @override
  String get tastingDetailEndDialogKeep => 'Doorgaan';

  @override
  String get tastingDetailEndDialogConfirm => 'Beëindigen';

  @override
  String get tastingCalendarFailedSnack => 'Kon agenda niet openen';

  @override
  String get tastingLifecycleUpcoming => 'AANKOMEND';

  @override
  String get tastingLifecycleLive => 'LIVE';

  @override
  String get tastingLifecycleConcluded => 'AFGEROND';

  @override
  String get tastingLifecycleStartCta => 'Proeverij starten';

  @override
  String get tastingLifecycleEndCta => 'Proeverij beëindigen';

  @override
  String get tastingDetailSectionPeople => 'Mensen';

  @override
  String get tastingDetailSectionPlace => 'Plek';

  @override
  String get tastingDetailSectionWines => 'WIJNEN';

  @override
  String get tastingDetailAddWines => 'Wijnen toevoegen';

  @override
  String get tastingDetailNoAttendees => 'Nog niemand uitgenodigd.';

  @override
  String get tastingDetailUnknownAttendee => 'Onbekend';

  @override
  String get tastingDetailRsvpYour => 'Jouw antwoord';

  @override
  String get tastingDetailRsvpGoing => 'Ga';

  @override
  String get tastingDetailRsvpMaybe => 'Misschien';

  @override
  String get tastingDetailRsvpDeclined => 'Nee';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count gaan';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count misschien';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count afgezegd';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count in afwachting';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Gaan';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Misschien';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'Afgezegd';

  @override
  String get tastingDetailAttendeesSheetPending => 'In afwachting';

  @override
  String get tastingEmptyOpenActiveTitle => 'De line-up vult zich gaandeweg';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Iedereen die gaat kan flessen toevoegen zodra ze verschijnen';

  @override
  String get tastingEmptyDefaultTitle => 'Nog geen wijnen in de line-up';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Wijnen kunnen worden toegevoegd zodra de proeverij begint';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Wijnen worden tijdens de avond toegevoegd';

  @override
  String get tastingEmptyPlannedHost =>
      'Tik op \"Wijnen toevoegen\" om de line-up samen te stellen';

  @override
  String get tastingEmptyPlannedGuest =>
      'De gastheer heeft nog geen wijnen toegevoegd';

  @override
  String get tastingRecapResultsHeader => 'RESULTATEN';

  @override
  String get tastingRecapShareCta => 'Recap delen';

  @override
  String get tastingRecapTopWineEyebrow => 'TOPWIJN VAN DE AVOND';

  @override
  String get tastingRecapEmpty =>
      'Nog geen beoordelingen ingediend voor deze proeverij.';

  @override
  String get tastingRecapRowNoRatings => 'geen beoordelingen';

  @override
  String get tastingRecapGroupFallback => 'Groepsproeverij';

  @override
  String get tastingPickerSheetTitle => 'Wijnen aan line-up toevoegen';

  @override
  String get tastingPickerEmpty => 'Je hebt nog geen wijnen.';

  @override
  String get tastingPickerErrorFallback => 'Kon wijnen niet laden.';

  @override
  String get tastingPickerSubmitDefault => 'Wijnen toevoegen';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Voeg $count wijnen toe',
      one: 'Voeg 1 wijn toe',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Toegevoegd';

  @override
  String get groupListHeader => 'GROEPEN';

  @override
  String get groupListSubtitle => 'Samen proeven';

  @override
  String get groupListSortRecent => 'Sorteer: recent';

  @override
  String get groupListSortName => 'Sorteer: naam';

  @override
  String get groupListCreateTooltip => 'Groep aanmaken';

  @override
  String get groupListJoinTitle => 'Lid worden van een groep';

  @override
  String get groupListJoinSubtitle => 'Voer een uitnodigingscode in';

  @override
  String get groupListJoinNotFound => 'Groep niet gevonden';

  @override
  String get groupListErrorLoad => 'Kon groepen niet laden';

  @override
  String get groupListEmptyTitle => 'Nog geen groepen';

  @override
  String get groupListEmptyBody =>
      'Maak er een aan of word lid om wijnen te delen';

  @override
  String get groupListEmptyCta => 'Groep aanmaken';

  @override
  String get groupCreateSourceCamera => 'Camera';

  @override
  String get groupCreateSourceGallery => 'Galerij';

  @override
  String get groupCreateSourceRemovePhoto => 'Foto verwijderen';

  @override
  String get groupCreatePickFailedFallback => 'Selecteren mislukt.';

  @override
  String get groupCreateUploadFailedFallback => 'Uploaden van foto mislukt.';

  @override
  String get groupCreateFailedFallback =>
      'Kon groep niet aanmaken. Probeer het opnieuw.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Opslaan mislukt: $error';
  }

  @override
  String get groupCreateTitle => 'Nieuwe groep';

  @override
  String get groupCreateNameHint => 'Groepsnaam';

  @override
  String get groupCreateSubmit => 'Aanmaken';

  @override
  String get groupJoinTitle => 'Uitnodigingscode';

  @override
  String get groupJoinHint => 'bv. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Lid worden';

  @override
  String get groupDetailNotFound => 'Groep niet gevonden';

  @override
  String get groupDetailErrorLoad => 'Kon groep niet laden';

  @override
  String get groupDetailSectionSharedWines => 'Gedeelde wijnen';

  @override
  String get groupDetailSectionTastings => 'Proeverijen';

  @override
  String get groupDetailActionShare => 'Delen';

  @override
  String get groupDetailActionPlan => 'Plannen';

  @override
  String get groupDetailMenuEdit => 'Groep bewerken';

  @override
  String get groupDetailMenuDelete => 'Groep verwijderen';

  @override
  String get groupDetailMenuLeave => 'Groep verlaten';

  @override
  String get groupDetailLeaveDialogTitle => 'Groep verlaten?';

  @override
  String get groupDetailLeaveDialogBody =>
      'Je kunt later opnieuw lid worden met de uitnodigingscode.';

  @override
  String get groupDetailLeaveDialogCancel => 'Annuleren';

  @override
  String get groupDetailLeaveDialogConfirm => 'Verlaten';

  @override
  String get groupDetailDeleteDialogTitle => 'Groep verwijderen?';

  @override
  String get groupDetailDeleteDialogBody =>
      'De groep en zijn gedeelde wijnen worden voor iedereen verwijderd.';

  @override
  String get groupDetailDeleteDialogCancel => 'Annuleren';

  @override
  String get groupDetailDeleteDialogConfirm => 'Verwijderen';

  @override
  String get groupSettingsEditTitle => 'Groep bewerken';

  @override
  String get groupSettingsNameLabel => 'Naam';

  @override
  String get groupSettingsSourceCamera => 'Camera';

  @override
  String get groupSettingsSourceGallery => 'Galerij';

  @override
  String get groupSettingsRemovePhoto => 'Foto verwijderen';

  @override
  String get groupSettingsUploadFailedFallback => 'Uploaden mislukt.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Verwijderen mislukt.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Opslaan mislukt: $error';
  }

  @override
  String get groupSettingsSave => 'Opslaan';

  @override
  String get groupInviteEyebrow => 'UITNODIGING';

  @override
  String get groupInviteFriendsEyebrow => 'VRIENDEN UITNODIGEN';

  @override
  String get groupInviteCodeCopied => 'Uitnodigingscode gekopieerd';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Word lid van \"$groupName\" op Sippd 🍷\n\n$url\n\nOf voer code in: $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Word lid van $groupName op Sippd';
  }

  @override
  String get groupInviteActionCopy => 'Code kopiëren';

  @override
  String get groupInviteActionShare => 'Link delen';

  @override
  String get groupInviteFriendsEmpty =>
      'Geen vrienden beschikbaar om uit te nodigen.';

  @override
  String get groupInviteFriendsAllInvited =>
      'Al je vrienden zitten al in deze groep of zijn uitgenodigd.';

  @override
  String get groupInviteFriendsErrorLoad => 'Kon vrienden niet laden';

  @override
  String get groupInviteFriendFallback => 'vriend';

  @override
  String get groupInviteUnknownName => 'Onbekend';

  @override
  String groupInviteSentSnack(String name) {
    return 'Uitnodiging gestuurd naar $name';
  }

  @override
  String get groupInviteSendFailedFallback => 'Kon uitnodiging niet versturen.';

  @override
  String get groupInvitationsHeader => 'UITNODIGINGEN';

  @override
  String get groupInvitationsInviterFallback => 'Iemand';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Uitgenodigd door $name';
  }

  @override
  String get groupInvitationsDecline => 'Weigeren';

  @override
  String get groupInvitationsAccept => 'Accepteren';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return 'Je bent lid van $name';
  }

  @override
  String get groupInvitationsAcceptFailed => 'Kon uitnodiging niet accepteren';

  @override
  String get groupMembersCountOne => '1 lid';

  @override
  String groupMembersCountMany(int count) {
    return '$count leden';
  }

  @override
  String get groupMembersUnknown => 'Onbekend';

  @override
  String get groupMembersOwnerBadge => 'EIGENAAR';

  @override
  String get groupWineCarouselDetails => 'Details';

  @override
  String get groupWineCarouselEmptyTitle => 'Nog geen wijn gedeeld';

  @override
  String get groupWineCarouselEmptyBody =>
      'Kies er een uit je collectie om de lijst te starten.';

  @override
  String get groupWineCarouselEmptyCta => 'Deel een wijn';

  @override
  String get groupWineTypeRed => 'ROOD';

  @override
  String get groupWineTypeWhite => 'WIT';

  @override
  String get groupWineTypeRose => 'ROSÉ';

  @override
  String get groupWineTypeSparkling => 'MOUSSEREND';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Sla de wijn eerst op — proefnotities koppelen eraan.';

  @override
  String get groupWineRatingNoCanonical =>
      'Wijn heeft nog geen canonieke identiteit — probeer opnieuw.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'Wijn heeft nog geen canonieke identiteit.';

  @override
  String get groupWineRatingNotesHint => 'Voeg een notitie toe';

  @override
  String get groupWineRatingOfflineRetry => 'Offline · Opnieuw';

  @override
  String get groupWineRatingSaveFailedRetry => 'Kon niet opslaan · Opnieuw';

  @override
  String get groupWineRatingSaved => 'Opgeslagen ✓';

  @override
  String get groupWineRatingSaveCta => 'Beoordeling opslaan';

  @override
  String get groupWineRatingRemoveMine => 'Mijn beoordeling verwijderen';

  @override
  String get groupWineRatingUnshareDialogTitle => 'Uit groep verwijderen?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '\"$name\" wordt uit deze groep verwijderd. Beoordelingen van leden worden ook verwijderd.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Annuleren';

  @override
  String get groupWineRatingUnshareConfirm => 'Verwijderen';

  @override
  String get groupWineRatingMoreTooltip => 'Meer';

  @override
  String get groupWineRatingUnshareMenu => 'Uit groep verwijderen';

  @override
  String get groupWineRatingsTitle => 'Beoordelingen';

  @override
  String get groupWineRatingsCountOne => '1 beoordeling';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count beoordelingen';
  }

  @override
  String get groupWineRatingsAvgLabel => 'gem.';

  @override
  String get groupWineRatingsBeFirst => 'Wees de eerste die beoordeelt';

  @override
  String get groupWineRatingsSoloMe =>
      'Jij bent de eerste · nodig anderen uit om te beoordelen';

  @override
  String get groupShareWineTitle => 'Deel een wijn';

  @override
  String get groupShareWineErrorLoad => 'Kon wijnen niet laden.';

  @override
  String get groupShareWineEmpty => 'Je hebt nog geen wijnen.';

  @override
  String get groupShareWineSharedChip => 'Gedeeld';

  @override
  String get groupShareWineSheetTitle => 'Delen met groep';

  @override
  String get groupShareWineSheetEmpty => 'Je zit nog in geen enkele groep.';

  @override
  String get groupShareWineSheetErrorLoad => 'Kon groepen niet laden.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Al gedeeld';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Gedeeld met $name';
  }

  @override
  String get groupShareWineRowMemberOne => '1 lid';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count leden';
  }

  @override
  String get groupShareWineRowWineOne => '1 wijn';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count wijnen';
  }

  @override
  String get groupShareMatchTitle => 'Al in deze groep';

  @override
  String groupShareMatchBody(String name) {
    return '\"$name\" lijkt op een wijn die een lid al heeft gedeeld. Is het dezelfde wijn?';
  }

  @override
  String get groupShareMatchNone => 'Geen van deze — los delen';

  @override
  String get groupShareMatchCancel => 'Annuleren';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Gedeeld door @$username';
  }

  @override
  String get groupFriendActionsInvite => 'Uitnodigen voor een groep';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return 'Nodig $name uit voor…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'Geen groepen om voor uit te nodigen. Maak er eerst een aan of word lid.';

  @override
  String get groupFriendActionsPickerErrorLoad => 'Kon groepen niet laden';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Eerdere proeverijen ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'Nog geen proeverijen';

  @override
  String get groupCalendarEmptyBody =>
      'Plan er een om de groep rond een fles te verzamelen.';

  @override
  String get groupCalendarEmptyCta => 'Plan een proeverij';

  @override
  String get groupWineDetailSectionRatings => 'GROEPSBEOORDELINGEN';

  @override
  String get groupWineDetailEmptyRatings => 'Nog geen groepsbeoordelingen.';

  @override
  String get groupWineDetailStatGroupAvg => 'Groepsgem.';

  @override
  String get groupWineDetailStatRatings => 'Beoordelingen';

  @override
  String get groupWineDetailStatNoRatings => 'Geen beoordelingen';

  @override
  String get groupWineDetailStatRegion => 'Regio';

  @override
  String get groupWineDetailStatCountry => 'Land';

  @override
  String get groupWineDetailStatOrigin => 'Herkomst';

  @override
  String get groupWineDetailSharedByEyebrow => 'GEDEELD DOOR';

  @override
  String get groupWineDetailSharerFallback => 'iemand';

  @override
  String get groupWineDetailMemberFallback => 'Lid';

  @override
  String get groupWineDetailRelJustNow => 'zojuist';

  @override
  String groupWineDetailRelMinutes(int count) {
    return '${count}m geleden';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return '${count}u geleden';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return '${count}d geleden';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return '${count}w geleden';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return '${count}mnd geleden';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return '${count}j geleden';
  }

  @override
  String get friendsHeader => 'VRIENDEN';

  @override
  String get friendsSubtitle => 'Proef met mensen die je kent';

  @override
  String get friendsSearchHint => 'Zoek op gebruikersnaam of naam';

  @override
  String get friendsSearchEmpty => 'Geen gebruikers gevonden';

  @override
  String get friendsSearchErrorFallback => 'Kon zoekopdracht niet laden.';

  @override
  String get friendsUnknownUser => 'Onbekend';

  @override
  String friendsRequestsHeader(int count) {
    return 'Verzoeken ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'Wachten op antwoord ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Verzoek verstuurd';

  @override
  String get friendsRequestSubtitle => 'wil vrienden worden';

  @override
  String get friendsActionCancel => 'Annuleren';

  @override
  String get friendsActionAdd => 'Toevoegen';

  @override
  String get friendsCancelDialogFallbackUser => 'deze gebruiker';

  @override
  String get friendsCancelDialogTitle => 'Verzoek annuleren?';

  @override
  String friendsCancelDialogBody(String name) {
    return 'Je vriendschapsverzoek aan $name annuleren?';
  }

  @override
  String get friendsCancelDialogKeep => 'Behouden';

  @override
  String get friendsCancelDialogConfirm => 'Verzoek annuleren';

  @override
  String get friendsListHeader => 'Jouw vrienden';

  @override
  String get friendsListErrorFallback => 'Kon vrienden niet laden.';

  @override
  String get friendsRemoveDialogTitle => 'Vriend verwijderen?';

  @override
  String friendsRemoveDialogBody(String name) {
    return '$name uit je vrienden verwijderen?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Verwijderen';

  @override
  String get friendsSendRequestErrorFallback => 'Kon verzoek niet versturen.';

  @override
  String get friendsStatusChipFriend => 'Vriend';

  @override
  String get friendsStatusChipPending => 'In afwachting';

  @override
  String get friendsEmptyDefaultName => 'Een vriend';

  @override
  String get friendsEmptyTitle => 'Breng je proefkring mee';

  @override
  String get friendsEmptyBody =>
      'Sippd wordt beter met vrienden. Stuur een uitnodiging — ze landen direct op je profiel.';

  @override
  String get friendsEmptyInviteCta => 'Vrienden uitnodigen';

  @override
  String get friendsEmptyFindCta => 'Zoek op gebruikersnaam';

  @override
  String get friendsProfileNotFound => 'Profiel niet gevonden';

  @override
  String get friendsProfileErrorLoad => 'Kon profiel niet laden';

  @override
  String get friendsProfileNameFallback => 'Vriend';

  @override
  String get friendsProfileRecentWinesHeader => 'RECENTE WIJNEN';

  @override
  String get friendsProfileWinesErrorLoad => 'Kon wijnen niet laden';

  @override
  String get friendsProfileStatWines => 'Wijnen';

  @override
  String get friendsProfileStatAvg => 'Gem.';

  @override
  String get friendsProfileStatCountry => 'Land';

  @override
  String get friendsProfileStatCountries => 'Landen';

  @override
  String get paywallPitchEyebrow => 'Sippd Pro';

  @override
  String get paywallPitchHeadline => 'Zie hoe je\necht proeft.';

  @override
  String get paywallPitchSubhead =>
      'Breng elke fles in kaart, match met vrienden die drinken zoals jij en duik dieper in elke proeverij.';

  @override
  String get paywallBenefitFriendsTitle => 'Onbeperkte groepen & vriendenmatch';

  @override
  String get paywallBenefitFriendsSubtitle =>
      'Breng je kring mee. Zie wie drinkt zoals jij.';

  @override
  String get paywallBenefitCompassTitle => 'Smaakkompas & diepe stats';

  @override
  String get paywallBenefitCompassSubtitle =>
      'Jouw wijnpersoonlijkheid, in kaart.';

  @override
  String get paywallBenefitNotesTitle => 'Expert-proefnotities';

  @override
  String get paywallBenefitNotesSubtitle => 'Neus · body · tannines · afdronk.';

  @override
  String get paywallPlanMonthly => 'Maandelijks';

  @override
  String get paywallPlanAnnual => 'Jaarlijks';

  @override
  String get paywallPlanLifetime => 'Levenslang';

  @override
  String get paywallPlanSubtitleMonthly => 'Altijd opzegbaar';

  @override
  String get paywallPlanSubtitleAnnual => 'Populairst';

  @override
  String get paywallPlanSubtitleLifetime =>
      'Beperkte lanceringsaanbieding · eenmalig betalen';

  @override
  String get paywallPlanBadgeAnnual => 'POPULAIRST';

  @override
  String get paywallPlanBadgeLifetime => 'OPRICHTERSEDITIE';

  @override
  String paywallPlanSavingsVsMonthly(int pct) {
    return 'Bespaar $pct% t.o.v. maandelijks';
  }

  @override
  String get paywallTrialTodayTitle => 'Vandaag';

  @override
  String get paywallTrialTodaySubtitle => 'Volledige Pro-toegang ontgrendeld.';

  @override
  String get paywallTrialDay5Title => 'Dag 5';

  @override
  String get paywallTrialDay5Subtitle =>
      'We herinneren je voor de afschrijving.';

  @override
  String get paywallTrialDay7Title => 'Dag 7';

  @override
  String get paywallTrialDay7Subtitle =>
      'Proefperiode eindigt. Altijd opzegbaar.';

  @override
  String get paywallCtaContinue => 'Doorgaan';

  @override
  String get paywallCtaSelectPlan => 'Kies een plan';

  @override
  String get paywallCtaStartTrial => 'Start gratis proefperiode van 7 dagen';

  @override
  String get paywallCtaMaybeLater => 'Misschien later';

  @override
  String get paywallCtaRestore => 'Aankopen herstellen';

  @override
  String get paywallFooterDisclosure =>
      'Altijd opzegbaar · gefactureerd door Apple of Google';

  @override
  String get paywallPlansLoadError => 'Kon plannen niet laden';

  @override
  String get paywallPlansEmpty => 'Nog geen plannen beschikbaar.';

  @override
  String get paywallErrorPurchaseFailed =>
      'Aankoop mislukt. Probeer het opnieuw.';

  @override
  String get paywallErrorRestoreFailed => 'Kon aankopen niet herstellen.';

  @override
  String get paywallRestoreWelcomeBack => 'Welkom terug bij Sippd Pro!';

  @override
  String get paywallRestoreNoneFound => 'Geen actief abonnement gevonden.';

  @override
  String get paywallSubscriptionTitle => 'Abonnement';

  @override
  String get paywallSubscriptionBrand => 'Sippd Pro';

  @override
  String get paywallSubscriptionChipActive => 'ACTIEF';

  @override
  String get paywallSubscriptionChipTrial => 'PROEF';

  @override
  String get paywallSubscriptionChipEnding => 'EINDIGT';

  @override
  String get paywallSubscriptionChipLifetime => 'LEVENSLANG';

  @override
  String get paywallSubscriptionChipTest => 'TESTMODUS';

  @override
  String get paywallSubscriptionPlanTest => 'Testmodus';

  @override
  String get paywallSubscriptionPlanLifetime => 'Levenslang';

  @override
  String get paywallSubscriptionPlanAnnual => 'Jaarlijks';

  @override
  String get paywallSubscriptionPlanMonthly => 'Maandelijks';

  @override
  String get paywallSubscriptionPlanWeekly => 'Wekelijks';

  @override
  String get paywallSubscriptionPlanGeneric => 'Pro-plan';

  @override
  String get paywallSubscriptionPeriodYear => '/ jaar';

  @override
  String get paywallSubscriptionPeriodMonth => '/ maand';

  @override
  String get paywallSubscriptionPeriodWeek => '/ week';

  @override
  String get paywallSubscriptionPeriodLifetime => 'eenmalig';

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
  String get paywallSubscriptionStorePromo => 'Promotoegang';

  @override
  String paywallSubscriptionBilledVia(String store) {
    return 'Gefactureerd via $store';
  }

  @override
  String get paywallSubscriptionStatusTestNoSub =>
      'Pro-functies lokaal ontgrendeld · geen echt abonnement';

  @override
  String get paywallSubscriptionStatusTestLocal =>
      'Pro-functies lokaal ontgrendeld';

  @override
  String get paywallSubscriptionStatusLifetime =>
      'Levenslange toegang — voor altijd van jou';

  @override
  String get paywallSubscriptionStatusEndingNoDate => 'Wordt niet verlengd';

  @override
  String paywallSubscriptionStatusEndingWithDate(String date) {
    return 'Toegang tot $date · wordt niet verlengd';
  }

  @override
  String get paywallSubscriptionStatusTrialActive => 'Proefperiode actief';

  @override
  String get paywallSubscriptionStatusTrialEndsToday =>
      'Proefperiode eindigt vandaag';

  @override
  String get paywallSubscriptionStatusTrialEndsTomorrow =>
      'Proefperiode eindigt morgen';

  @override
  String paywallSubscriptionStatusTrialEndsInDays(int days) {
    return 'Proefperiode eindigt over $days dagen';
  }

  @override
  String get paywallSubscriptionStatusActive => 'Actief';

  @override
  String paywallSubscriptionStatusRenewsOn(String date) {
    return 'Verlengt op $date';
  }

  @override
  String get paywallSubscriptionSectionIncluded => 'Inbegrepen bij Pro';

  @override
  String get paywallSubscriptionSectionManage => 'Beheren';

  @override
  String get paywallSubscriptionRowChangePlan => 'Plan wijzigen';

  @override
  String get paywallSubscriptionRowRestore => 'Aankopen herstellen';

  @override
  String get paywallSubscriptionRowCancel => 'Abonnement opzeggen';

  @override
  String get paywallSubscriptionDisclosure =>
      'Abonnementen worden gefactureerd door Apple of Google. Beheer ze in de store-instellingen.';

  @override
  String get paywallSubscriptionOpenError =>
      'Kon abonnementsinstellingen niet openen.';

  @override
  String get paywallMonthShortJan => 'jan';

  @override
  String get paywallMonthShortFeb => 'feb';

  @override
  String get paywallMonthShortMar => 'mrt';

  @override
  String get paywallMonthShortApr => 'apr';

  @override
  String get paywallMonthShortMay => 'mei';

  @override
  String get paywallMonthShortJun => 'jun';

  @override
  String get paywallMonthShortJul => 'jul';

  @override
  String get paywallMonthShortAug => 'aug';

  @override
  String get paywallMonthShortSep => 'sep';

  @override
  String get paywallMonthShortOct => 'okt';

  @override
  String get paywallMonthShortNov => 'nov';

  @override
  String get paywallMonthShortDec => 'dec';

  @override
  String get tasteTraitBody => 'Body';

  @override
  String get tasteTraitTannin => 'Tannine';

  @override
  String get tasteTraitAcidity => 'Zuren';

  @override
  String get tasteTraitSweetness => 'Zoetheid';

  @override
  String get tasteTraitOak => 'Hout';

  @override
  String get tasteTraitIntensity => 'Intensiteit';

  @override
  String get tasteTraitSweetShort => 'Zoet';

  @override
  String get tasteTraitBodyLow => 'Licht, makkelijk drinkbaar';

  @override
  String get tasteTraitBodyMid => 'In balans';

  @override
  String get tasteTraitBodyHigh => 'Stevig, vol van body';

  @override
  String get tasteTraitTanninLow => 'Zacht, weinig grip';

  @override
  String get tasteTraitTanninMid => 'Gemiddelde grip';

  @override
  String get tasteTraitTanninHigh => 'Grippy, gestructureerd';

  @override
  String get tasteTraitAcidityLow => 'Zacht, rond';

  @override
  String get tasteTraitAcidityMid => 'In balans';

  @override
  String get tasteTraitAcidityHigh => 'Fris, helder';

  @override
  String get tasteTraitSweetnessLow => 'Kurkdroog';

  @override
  String get tasteTraitSweetnessMid => 'Halfdroog';

  @override
  String get tasteTraitSweetnessHigh => 'Neigt naar zoet';

  @override
  String get tasteTraitOakLow => 'Ongehout, fris';

  @override
  String get tasteTraitOakMid => 'Vleugje hout';

  @override
  String get tasteTraitOakHigh => 'Houtgedreven';

  @override
  String get tasteTraitIntensityLow => 'Subtiele aroma\'s';

  @override
  String get tasteTraitIntensityMid => 'Expressief';

  @override
  String get tasteTraitIntensityHigh => 'Stevig, aromatisch';

  @override
  String tasteDnaBodyLowPct(int pct) {
    return 'Je neigt naar lichte body · $pct%';
  }

  @override
  String tasteDnaBodyMidPct(int pct) {
    return 'Body in balans · $pct%';
  }

  @override
  String tasteDnaBodyHighPct(int pct) {
    return 'Je neigt naar volle body · $pct%';
  }

  @override
  String tasteDnaTanninLowPct(int pct) {
    return 'Zachte tannines · $pct%';
  }

  @override
  String tasteDnaTanninMidPct(int pct) {
    return 'Gemiddelde tannine · $pct%';
  }

  @override
  String tasteDnaTanninHighPct(int pct) {
    return 'Stevige, grijpende tannines · $pct%';
  }

  @override
  String tasteDnaAcidityLowPct(int pct) {
    return 'Zachte zuren · $pct%';
  }

  @override
  String tasteDnaAcidityMidPct(int pct) {
    return 'Zuren in balans · $pct%';
  }

  @override
  String tasteDnaAcidityHighPct(int pct) {
    return 'Hoge-zuren-drinker · $pct%';
  }

  @override
  String tasteDnaSweetnessLowPct(int pct) {
    return 'Kurkdroog · $pct%';
  }

  @override
  String tasteDnaSweetnessMidPct(int pct) {
    return 'Neiging naar halfdroog · $pct%';
  }

  @override
  String tasteDnaSweetnessHighPct(int pct) {
    return 'Neigt naar zoet · $pct%';
  }

  @override
  String tasteDnaOakLowPct(int pct) {
    return 'Ongehout / fris · $pct%';
  }

  @override
  String tasteDnaOakMidPct(int pct) {
    return 'Wat hout · $pct%';
  }

  @override
  String tasteDnaOakHighPct(int pct) {
    return 'Houtliefhebber · $pct%';
  }

  @override
  String tasteDnaIntensityLowPct(int pct) {
    return 'Subtiele aroma\'s · $pct%';
  }

  @override
  String tasteDnaIntensityMidPct(int pct) {
    return 'Expressief · $pct%';
  }

  @override
  String tasteDnaIntensityHighPct(int pct) {
    return 'Stevige aroma\'s · $pct%';
  }

  @override
  String get tasteDnaNotEnoughYet =>
      'Nog niet genoeg beoordeelde wijnen — ga zo door';

  @override
  String get tasteArchetypeBoldRedHunter => 'Krachtige-Roodjager';

  @override
  String get tasteArchetypeBoldRedHunterTagline =>
      'Volle, tanninerijke rode wijnen zijn jouw thuisbasis.';

  @override
  String get tasteArchetypeElegantBurgundian => 'Elegante Bourgondiër';

  @override
  String get tasteArchetypeElegantBurgundianTagline =>
      'Lichtere rode wijnen met heldere zuren sturen je gehemelte.';

  @override
  String get tasteArchetypeAromaticWhiteLover => 'Aromatische-Witliefhebber';

  @override
  String get tasteArchetypeAromaticWhiteLoverTagline =>
      'Frisse, expressieve witte wijnen met doorsnijdende zuren.';

  @override
  String get tasteArchetypeSparklingSociable =>
      'Mousserende Gezelligheidszoeker';

  @override
  String get tasteArchetypeSparklingSociableTagline =>
      'Bubbels en bleke wijnen domineren je collectie.';

  @override
  String get tasteArchetypeClassicStructure => 'Klassieke Structuur';

  @override
  String get tasteArchetypeClassicStructureTagline =>
      'Ingetogen, eetgerichte wijnen met heldere zuren.';

  @override
  String get tasteArchetypeSunRipenedBold => 'Zonrijp & Krachtig';

  @override
  String get tasteArchetypeSunRipenedBoldTagline =>
      'Veel fruit en hout uit zonovergoten wijngaarden.';

  @override
  String get tasteArchetypeDessertOffDry => 'Dessert / Halfzoet';

  @override
  String get tasteArchetypeDessertOffDryTagline =>
      'Je neigt naar flessen met een vleugje zoet.';

  @override
  String get tasteArchetypeNaturalLowIntervention =>
      'Natuurlijk / Minimale Interventie';

  @override
  String get tasteArchetypeNaturalLowInterventionTagline =>
      'Ongehoute, lichtere wijnen — het frisheidskamp.';

  @override
  String get tasteArchetypeCrispMineralFan => 'Frisse-Mineraliteitsfan';

  @override
  String get tasteArchetypeCrispMineralFanTagline =>
      'Strakke, minerale, zuurrijke stijlen zijn jouw handtekening.';

  @override
  String get tasteArchetypeEclecticExplorer =>
      'Eclectische Ontdekkingsreiziger';

  @override
  String get tasteArchetypeEclecticExplorerTagline =>
      'Breed gehemelte — je proeft over de hele wijnkaart.';

  @override
  String get tasteArchetypeCuriousNewcomer => 'Nieuwsgierige Nieuwkomer';

  @override
  String get tasteArchetypeCuriousNewcomerTagline =>
      'Beoordeel nog wat wijnen en je persoonlijkheid komt tevoorschijn.';

  @override
  String get tasteCompassModeStyle => 'Stijl';

  @override
  String get tasteCompassModeWorld => 'Wereld';

  @override
  String get tasteCompassModeGrapes => 'Druiven';

  @override
  String get tasteCompassModeDna => 'DNA';

  @override
  String get tasteCompassMetricCount => 'aantal';

  @override
  String get tasteCompassMetricRating => 'cijfer';

  @override
  String get tasteCompassContinentEurope => 'Europa';

  @override
  String get tasteCompassContinentNorthAmerica => 'Noord-Amerika';

  @override
  String get tasteCompassContinentSouthAmerica => 'Zuid-Amerika';

  @override
  String get tasteCompassContinentAfrica => 'Afrika';

  @override
  String get tasteCompassContinentAsia => 'Azië';

  @override
  String get tasteCompassContinentOceania => 'Oceanië';

  @override
  String tasteCompassStyleNoneYet(String label) {
    return 'Nog geen $label wijnen';
  }

  @override
  String tasteCompassStyleSummaryOne(int count, String label, String avg) {
    return '$count $label wijn · $avg★ gem.';
  }

  @override
  String tasteCompassStyleSummaryMany(int count, String label, String avg) {
    return '$count $label wijnen · $avg★ gem.';
  }

  @override
  String tasteCompassWorldNoneYet(String label) {
    return 'Nog geen flessen uit $label';
  }

  @override
  String tasteCompassWorldSummaryOne(String label, String avg) {
    return '1 fles uit $label · $avg★ gem.';
  }

  @override
  String tasteCompassWorldSummaryMany(int count, String label, String avg) {
    return '$count flessen uit $label · $avg★ gem.';
  }

  @override
  String get tasteCompassGrapeEmptySlot =>
      'Lege plek — beoordeel meer druiven om te vullen';

  @override
  String tasteCompassGrapeSummaryOne(String name, String avg) {
    return '$name · 1 fles · $avg★ gem.';
  }

  @override
  String tasteCompassGrapeSummaryMany(String name, int count, String avg) {
    return '$name · $count flessen · $avg★ gem.';
  }

  @override
  String get tasteCompassTitleDefault => 'Smaakkompas';

  @override
  String get tasteCompassEmptyPromptOne =>
      'Beoordeel nog 1 wijn om het kompas te ontgrendelen.';

  @override
  String tasteCompassEmptyPromptMany(int count) {
    return 'Beoordeel nog $count wijnen om het kompas te ontgrendelen.';
  }

  @override
  String get tasteCompassNotEnoughData =>
      'Nog niet genoeg data voor deze modus.';

  @override
  String get tasteCompassDnaNeedsGrapes =>
      'DNA heeft een paar wijnen nodig waarvan we de druif herkennen. Kies een canonieke druif op je wijnen om deze weergave te ontgrendelen.';

  @override
  String get tasteCompassEyebrowPersonality => 'JOUW WIJNPERSOONLIJKHEID';

  @override
  String get tasteCompassTentativeHint =>
      'Voorlopig — beoordeel meer wijnen voor een scherper beeld';

  @override
  String get tasteCompassTopRegions => 'Topregio\'s';

  @override
  String get tasteCompassTopCountries => 'Toplanden';

  @override
  String get tasteCompassFooterWinesOne => '1 wijn';

  @override
  String tasteCompassFooterWinesMany(int count) {
    return '$count wijnen';
  }

  @override
  String tasteCompassFooterAvg(String avg) {
    return '$avg ★ gem.';
  }

  @override
  String get tasteHeroEyebrow => 'PERSOONLIJKHEID';

  @override
  String get tasteHeroPromptCuriousOne =>
      'Beoordeel nog 1 wijn om je persoonlijkheid te onthullen.';

  @override
  String tasteHeroPromptCuriousMany(int count) {
    return 'Beoordeel nog $count wijnen om je persoonlijkheid te onthullen.';
  }

  @override
  String get tasteHeroAlmostThere => 'Bijna klaar';

  @override
  String get tasteHeroPromptThinDnaOne =>
      'Tag een canonieke druif op nog 1 wijn om je archetype te ontgrendelen.';

  @override
  String tasteHeroPromptThinDnaMany(int count) {
    return 'Tag een canonieke druif op nog $count wijnen om je archetype te ontgrendelen.';
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
  String get tasteHeroWinesOne => '1 wijn';

  @override
  String tasteHeroWinesMany(int count) {
    return '$count wijnen';
  }

  @override
  String tasteHeroAvg(String avg) {
    return '$avg★ gem.';
  }

  @override
  String get tasteHeroShare => 'Delen';

  @override
  String get tasteTraitsHeading => 'EIGENSCHAPPEN';

  @override
  String get tasteTraitsProDivider => 'PRO';

  @override
  String get tasteTraitsUnlockAll => 'Ontgrendel alle eigenschappen met Pro';

  @override
  String get tasteMatchLabel => 'smaakmatch';

  @override
  String get tasteMatchConfidenceStrong => 'Sterk';

  @override
  String get tasteMatchConfidenceSolid => 'Solide';

  @override
  String get tasteMatchConfidenceEarly => 'Pril';

  @override
  String tasteMatchSupportingOne(String dnaPart) {
    return 'Gebaseerd op 1 gedeeld regio/type-segment$dnaPart.';
  }

  @override
  String tasteMatchSupportingMany(int overlap, String dnaPart) {
    return 'Gebaseerd op $overlap gedeelde regio/type-segmenten$dnaPart.';
  }

  @override
  String get tasteMatchSupportingDnaPart => ' + WSET-stijloverlap';

  @override
  String get tasteMatchSignalStrong => 'Sterk signaal.';

  @override
  String get tasteMatchSignalSolid => 'Solide signaal.';

  @override
  String get tasteMatchSignalEarly =>
      'Pril signaal — blijf beoordelen om dit aan te scherpen.';

  @override
  String get tasteMatchBreakdownBucket => 'Regio- & type-fit';

  @override
  String get tasteMatchBreakdownDna => 'Stijl-DNA-fit';

  @override
  String get tasteMatchEmptyNotEnough =>
      'Nog niet genoeg wijnen om te vergelijken — beoordeel nog wat flessen om de smaakmatch te ontgrendelen.';

  @override
  String get tasteMatchEmptyNoOverlap =>
      'Jullie hebben nog geen wijnen uit dezelfde regio\'s of types beoordeeld. De match komt op gang zodra jullie smaak overlapt.';

  @override
  String tasteFriendUpsellTitle(String name) {
    return 'Zie hoe $name proeft';
  }

  @override
  String get tasteFriendUpsellBody =>
      'Vergelijk jullie gehemeltes, vind wijnen die jullie allebei lekker vinden en ontdek waar jullie smaak uiteenloopt.';

  @override
  String get tasteFriendUpsellPillMatch => 'Smaakmatch';

  @override
  String get tasteFriendUpsellPillShared => 'Gedeelde flessen';

  @override
  String get tasteFriendUpsellCta => 'Ontgrendel Sippd Pro';

  @override
  String get tasteFriendSharedHeading =>
      'WIJNEN DIE JULLIE ALLEBEI BEOORDEELDEN';

  @override
  String tasteFriendSharedMore(int count) {
    return '+ $count meer';
  }

  @override
  String get tasteFriendRatingYou => 'jij';

  @override
  String get tasteFriendRatingThem => 'hen';

  @override
  String shareRatedOn(String date) {
    return 'BEOORDEELD · $date';
  }

  @override
  String get shareRatingDenominator => '/ 10';

  @override
  String shareFooterRateYours(String url) {
    return 'beoordeel die van jou op $url';
  }

  @override
  String shareFooterFindYours(String url) {
    return 'vind jouw smaak op $url';
  }

  @override
  String shareFooterHostYours(String url) {
    return 'host die van jou op $url';
  }

  @override
  String shareFooterJoinAt(String url) {
    return 'doe mee op $url';
  }

  @override
  String get shareCompassEyebrow => 'WIJNPERSOONLIJKHEID';

  @override
  String get shareCompassWhatDefinesMe => 'WAT MIJ DEFINIEERT';

  @override
  String get shareCompassSampleSizeOne => 'gebaseerd op 1 wijn';

  @override
  String shareCompassSampleSizeMany(int count) {
    return 'gebaseerd op $count wijnen';
  }

  @override
  String shareCompassPhrase(String descriptor, String trait) {
    return '$descriptor $trait';
  }

  @override
  String shareCompassShareText(String archetype, String url) {
    return 'Mijn wijnpersoonlijkheid: $archetype · vind die van jou op $url';
  }

  @override
  String get shareTastingEyebrow => 'GROEPSPROEVERIJ';

  @override
  String get shareTastingTopWine => 'TOPWIJN VAN DE AVOND';

  @override
  String get shareTastingLineup => 'LINE-UP';

  @override
  String shareTastingMore(int count) {
    return '+ $count meer';
  }

  @override
  String get shareTastingAttendeesOne => '1 proever';

  @override
  String shareTastingAttendeesMany(int count) {
    return '$count proevers';
  }

  @override
  String shareTastingShareTextTop(String wine, String avg, String url) {
    return '$wine won de avond met $avg/10 · gehost op Sippd · $url';
  }

  @override
  String shareTastingShareTextTitle(String title, String url) {
    return '$title · gehost op Sippd · $url';
  }

  @override
  String shareRatingShareText(String wine, String rating, String url) {
    return 'Net $wine $rating/10 beoordeeld op Sippd · $url';
  }

  @override
  String get shareInviteEyebrow => 'EEN UITNODIGING';

  @override
  String get shareInviteHero => 'Laten we samen\nproeven.';

  @override
  String get shareInviteSub => 'Beoordeel het. Onthoud het. Deel het.';

  @override
  String get shareInviteWantsToTaste => 'wil met je proeven';

  @override
  String shareInviteFallbackText(String name, String url) {
    return '$name wil met je proeven op Sippd · $url';
  }

  @override
  String shareInviteImageText(String url) {
    return 'Doe met me mee op Sippd 🍷  $url';
  }

  @override
  String get shareInviteSubject => 'Doe met me mee op Sippd';

  @override
  String get shareRatingPromptSavedBadge => 'WIJN OPGESLAGEN';

  @override
  String get shareRatingPromptTitle => 'Je kaart is klaar';

  @override
  String get shareRatingPromptBody =>
      'Stuur \'m naar vrienden of post \'m in je story.';

  @override
  String get shareRatingPromptCta => 'Kaart delen';

  @override
  String get shareRatingPromptPreparing => 'Voorbereiden…';

  @override
  String get shareRatingPromptDismiss => 'Niet nu';

  @override
  String get reviewPromptTitle => 'Geniet je van Sippd?';

  @override
  String get reviewPromptBody =>
      'Je hebt inmiddels een paar wijnen beoordeeld. Een snelle review helpt andere wijnliefhebbers Sippd te ontdekken.';

  @override
  String get reviewPromptCtaPositive => 'Geweldig';

  @override
  String get reviewPromptCtaNegative => 'Nog niet';

  @override
  String get commonRetry => 'Opnieuw';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonClear => 'Wissen';

  @override
  String get commonGotIt => 'Begrepen';

  @override
  String get commonOptional => '(optioneel)';

  @override
  String get commonOffline => 'Offline';

  @override
  String get commonOfflineMessage =>
      'Je bent offline. Verbind opnieuw en probeer het nog eens.';

  @override
  String get commonNetworkErrorMessage =>
      'Netwerkfout. Controleer je verbinding.';

  @override
  String get commonSomethingWentWrong => 'Er ging iets mis.';

  @override
  String get commonErrorViewOfflineTitle => 'Je bent offline';

  @override
  String get commonErrorViewOfflineSubtitle =>
      'Verbind opnieuw om dit te laden.';

  @override
  String get commonErrorViewGenericTitle => 'Kon niet laden';

  @override
  String get commonErrorViewGenericSubtitle =>
      'Trek omlaag om opnieuw te proberen of probeer het later.';

  @override
  String get commonInlineCouldntSaveRetry => 'Kon niet opslaan · Opnieuw';

  @override
  String get commonInlineOfflineRetry => 'Offline · Opnieuw';

  @override
  String get commonPhotoDialogCameraTitle => 'Cameratoegang uit';

  @override
  String get commonPhotoDialogCameraBody =>
      'Sippd heeft cameratoegang nodig om wijnfoto\'s te maken. Zet het aan in Instellingen om door te gaan.';

  @override
  String get commonPhotoDialogPhotosTitle => 'Fototoegang uit';

  @override
  String get commonPhotoDialogPhotosBody =>
      'Sippd heeft toegang tot je foto\'s nodig om afbeeldingen bij te voegen. Zet het aan in Instellingen om door te gaan.';

  @override
  String get commonPhotoErrorSnack =>
      'Kon foto niet laden. Probeer het opnieuw.';

  @override
  String get commonPriceSheetTitle => 'Flesprijs';

  @override
  String get commonYearPickerTitle => 'Jaar';

  @override
  String get locSheetTitle => 'Waar dronk je \'m?';

  @override
  String get locSearchHint => 'Zoek locatie...';

  @override
  String get locNoResults => 'Geen locaties gevonden';

  @override
  String get locSearchFailed => 'Zoeken mislukt';

  @override
  String get locUseMyLocation => 'Gebruik mijn huidige locatie';

  @override
  String get locFindingLocation => 'Je locatie zoeken…';

  @override
  String get locReadCurrentFailed => 'Kon huidige locatie niet ophalen';

  @override
  String get locServicesDisabled => 'Locatieservices zijn uitgeschakeld';

  @override
  String get locPermissionDenied => 'Locatietoestemming geweigerd';

  @override
  String get profileEditTitle => 'Profiel bewerken';

  @override
  String get profileEditSectionProfile => 'Profiel';

  @override
  String get profileEditFieldUsername => 'Gebruikersnaam';

  @override
  String get profileEditFieldDisplayName => 'Weergavenaam';

  @override
  String profileEditDisplayNameHintWithUsername(String username) {
    return 'bv. $username';
  }

  @override
  String get profileEditDisplayNameHintGeneric => 'Hoe noemen we jou?';

  @override
  String get profileEditDisplayNameHelper =>
      'Te zien in groepen en proeverijen. Laat leeg om je gebruikersnaam te gebruiken.';

  @override
  String get profileEditSectionTaste => 'Jouw smaak';

  @override
  String get profileEditSectionTasteSubtitle =>
      'Stem af wat Sippd over jou leert. Altijd aanpasbaar.';

  @override
  String get profileEditAvatarUpdateFailed =>
      'Kon foto niet bijwerken. Probeer het opnieuw.';

  @override
  String get profileEditUploadFailed => 'Uploaden mislukt.';

  @override
  String get profileEditSaveChangesFailed =>
      'Kon wijzigingen niet opslaan. Probeer het opnieuw.';

  @override
  String get profileAvatarTakePhoto => 'Foto maken';

  @override
  String get profileAvatarChooseGallery => 'Kies uit galerij';

  @override
  String get profileAvatarRemove => 'Foto verwijderen';

  @override
  String get profileUsernameTooShort => 'Minimaal 3 tekens';

  @override
  String get profileUsernameInvalid => 'Alleen letters, cijfers, . en _';

  @override
  String get profileUsernameTaken => 'Al bezet';

  @override
  String get profileUsernameAvailable => 'Beschikbaar';

  @override
  String get profileUsernameChecking => 'Controleren…';

  @override
  String get profileUsernameHelperIdle =>
      '3–20 tekens · letters, cijfers, . en _';

  @override
  String get profileChooseUsernameTitle => 'Kies een gebruikersnaam';

  @override
  String get profileChooseUsernameSubtitle => 'Zo vinden vrienden je op Sippd.';

  @override
  String get profileChooseUsernameHint => 'gebruikersnaam';

  @override
  String get profileChooseUsernameContinue => 'Doorgaan';

  @override
  String get profileChooseUsernameSaveFailed =>
      'Kon gebruikersnaam niet opslaan. Probeer het opnieuw.';

  @override
  String get errNetworkDefault =>
      'Geen internetverbinding. Gecachte data wordt gebruikt.';

  @override
  String get errOffline =>
      'Je bent offline. Verbind opnieuw om het nog eens te proberen.';

  @override
  String errDatabase(String msg) {
    return 'Fout in lokale data: $msg';
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
    return '$resource niet gevonden.';
  }

  @override
  String get errNotFoundDefault => 'Niet gevonden.';

  @override
  String get errUnauthorized => 'Log in om door te gaan.';

  @override
  String errServer(int code) {
    return 'Serverfout ($code). Probeer het opnieuw.';
  }

  @override
  String get errServerNoCode => 'Serverfout. Probeer het opnieuw.';

  @override
  String get errUnknown => 'Er ging iets mis. Probeer het opnieuw.';

  @override
  String routeNotFound(String uri) {
    return 'Pagina niet gevonden: $uri';
  }
}

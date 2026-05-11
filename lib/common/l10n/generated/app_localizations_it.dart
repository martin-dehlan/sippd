// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get notificationsTitle => 'Notifiche';

  @override
  String get notificationsLoadError =>
      'Impossibile caricare le impostazioni delle notifiche';

  @override
  String get sectionTastings => 'Degustazioni';

  @override
  String get sectionFriends => 'Amici';

  @override
  String get sectionGroups => 'Gruppi';

  @override
  String get tileTastingRemindersLabel => 'Promemoria degustazione';

  @override
  String get tileTastingRemindersSubtitle =>
      'Notifica prima dell\'inizio di una degustazione';

  @override
  String get tileFriendActivityLabel => 'Attività degli amici';

  @override
  String get tileFriendActivitySubtitle => 'Richieste e conferme';

  @override
  String get tileGroupActivityLabel => 'Attività del gruppo';

  @override
  String get tileGroupActivitySubtitle =>
      'Inviti, iscrizioni e nuove degustazioni';

  @override
  String get tileGroupWineSharedLabel => 'Nuovo vino condiviso';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Quando un amico aggiunge un vino al tuo gruppo';

  @override
  String get hoursPickerLabel => 'Avvisami';

  @override
  String get hoursPickerHint =>
      'Vale per tutte le degustazioni in arrivo — modificabile in ogni momento.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Lingua';

  @override
  String get languageSheetTitle => 'Scegli la lingua';

  @override
  String get languageOptionSystem => 'Lingua del sistema';

  @override
  String get onbWelcomeTitle => 'La tua memoria\ndel vino.';

  @override
  String get onbWelcomeBody =>
      'Valuta i vini che ami. Ricordali per sempre. Degustali con gli amici.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Hai già un account? ';

  @override
  String get onbWelcomeSignIn => 'Accedi';

  @override
  String get onbWhyEyebrow => 'Perché Sippd';

  @override
  String get onbWhyTitle => 'Pensato per chi\nbeve davvero vino.';

  @override
  String get onbWhyPrinciple1Headline => 'Scatta. Valuta. Ricorda.';

  @override
  String get onbWhyPrinciple1Line => 'Tre tap e lo ritrovi l\'anno prossimo.';

  @override
  String get onbWhyPrinciple2Headline => 'Degustazioni con gli amici.';

  @override
  String get onbWhyPrinciple2Line =>
      'Assaggi alla cieca, punteggi condivisi. Niente fogli di calcolo.';

  @override
  String get onbWhyPrinciple3Headline => 'Funziona offline.';

  @override
  String get onbWhyPrinciple3Line => 'Annota ovunque. Si sincronizza a casa.';

  @override
  String get onbLevelEyebrow => 'Su di te';

  @override
  String get onbLevelTitle => 'Quanto sei dentro\nal mondo del vino?';

  @override
  String get onbLevelSubtitle =>
      'Nessuna risposta sbagliata. Tariamo i suggerimenti sul tuo passo.';

  @override
  String get onbLevelBeginnerLabel => 'Principiante';

  @override
  String get onbLevelBeginnerSubtitle => 'Sto iniziando';

  @override
  String get onbLevelCuriousLabel => 'Curioso';

  @override
  String get onbLevelCuriousSubtitle => 'Qualche preferito';

  @override
  String get onbLevelEnthusiastLabel => 'Appassionato';

  @override
  String get onbLevelEnthusiastSubtitle => 'So cosa mi piace';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Livello sommelier';

  @override
  String get onbFreqEyebrow => 'Il tuo ritmo';

  @override
  String get onbFreqTitle => 'Quanto spesso apri\nuna bottiglia?';

  @override
  String get onbFreqWeekly => 'Ogni settimana';

  @override
  String get onbFreqMonthly => 'Un paio di volte al mese';

  @override
  String get onbFreqRare => 'Ogni tanto';

  @override
  String get onbGoalsEyebrow => 'I tuoi obiettivi';

  @override
  String get onbGoalsTitle => 'Cosa vuoi\nda Sippd?';

  @override
  String get onbGoalsSubtitle => 'Scegli uno o più. Puoi cambiare dopo.';

  @override
  String get onbGoalRemember => 'Ricordare le bottiglie che amo';

  @override
  String get onbGoalDiscover => 'Scoprire nuovi stili';

  @override
  String get onbGoalSocial => 'Degustare con gli amici';

  @override
  String get onbGoalValue => 'Tenere conto di quanto spendo';

  @override
  String get onbStylesEyebrow => 'I tuoi stili';

  @override
  String get onbStylesTitle => 'Cosa\nscegli?';

  @override
  String get onbStylesSubtitle =>
      'Indica quelli che ti rispecchiano. Terremo d\'occhio le tue scelte.';

  @override
  String get wineTypeRed => 'Rosso';

  @override
  String get wineTypeWhite => 'Bianco';

  @override
  String get wineTypeRose => 'Rosato';

  @override
  String get wineTypeSparkling => 'Spumante';

  @override
  String get onbRespEyebrow => 'Una nota da noi';

  @override
  String get onbRespTitle => 'Bevi meno,\nassapora di più.';

  @override
  String get onbRespSubtitle =>
      'Sippd serve a ricordare e valutare vini che hai apprezzato — non a spingerti a bere di più. Niente streak né quote giornaliere. Di proposito.';

  @override
  String get onbRespHelpBody =>
      'Se l\'alcol fa male a te o a chi ti sta vicino,\nesiste un aiuto gratuito e riservato.';

  @override
  String get onbRespHelpCta => 'Trova aiuto';

  @override
  String get onbNameEyebrow => 'Quasi fatta';

  @override
  String get onbNameTitle => 'Come dobbiamo\nchiamarti?';

  @override
  String get onbNameSubtitle =>
      'Nome, soprannome — come ti senti. Scegli anche un\'icona.';

  @override
  String get onbNameHint => 'Il tuo nome';

  @override
  String get onbNameIconLabel => 'Scegli la tua icona';

  @override
  String get onbNameIconSubtitle => 'Appare come il tuo avatar.';

  @override
  String get onbNotifEyebrow => 'Resta sul pezzo';

  @override
  String get onbNotifTitle => 'Non perdere mai più\nuna grande bottiglia.';

  @override
  String get onbNotifSubtitle =>
      'Ti avvisiamo quando gli amici avviano una degustazione o ti invitano in un gruppo. Disattivabile in ogni momento.';

  @override
  String get onbNotifPreview =>
      'Inviti a degustazioni\nVoti di gruppo\nAttività degli amici';

  @override
  String get onbNotifTurnOn => 'Attiva le notifiche';

  @override
  String get onbNotifNotNow => 'Non ora';

  @override
  String get onbLoaderAlmostThere => 'QUASI FATTA';

  @override
  String get onbLoaderCrafting => 'Stiamo creando il tuo profilo.';

  @override
  String get onbLoaderAllSet => 'Tutto pronto.';

  @override
  String get onbLoaderStepMatching => 'Stiamo abbinando il tuo gusto';

  @override
  String get onbLoaderStepCurating => 'Stiamo curando i tuoi stili';

  @override
  String get onbLoaderStepSetting => 'Stiamo preparando il tuo diario';

  @override
  String get onbLoaderSeeProfile => 'Vedi il tuo profilo';

  @override
  String get onbLoaderContinue => 'Continua';

  @override
  String get onbResultsEyebrow => 'IL TUO PROFILO DI GUSTO';

  @override
  String get onbResultsLevelCard => 'Livello';

  @override
  String get onbResultsFreqCard => 'Frequenza';

  @override
  String get onbResultsStylesCard => 'Stili';

  @override
  String get onbResultsGoalsCard => 'Obiettivi';

  @override
  String get onbArchSommTitle => 'Sommelier consumato';

  @override
  String get onbArchSommSubtitle =>
      'Conosci il tuo terroir. Sippd tiene le ricevute.';

  @override
  String get onbArchPalateTitle => 'Palato fine';

  @override
  String get onbArchPalateSubtitle =>
      'Cacciatore di sfumature. Sippd cattura i dettagli.';

  @override
  String get onbArchRegularTitle => 'Habitué di cantina';

  @override
  String get onbArchRegularSubtitle =>
      'Una bottiglia a settimana, opinioni più nitide ogni mese.';

  @override
  String get onbArchDevotedTitle => 'Degustatore devoto';

  @override
  String get onbArchDevotedSubtitle =>
      'Serio a ogni calice. Sippd tiene le tue note.';

  @override
  String get onbArchRedTitle => 'Fedele al rosso';

  @override
  String get onbArchRedSubtitle =>
      'Un\'uva per calice. Ti aiutiamo ad ampliare.';

  @override
  String get onbArchBubbleTitle => 'Cacciatore di bollicine';

  @override
  String get onbArchBubbleSubtitle =>
      'Bollicine prima di tutto. Sippd segna le migliori.';

  @override
  String get onbArchOpenTitle => 'Palato aperto';

  @override
  String get onbArchOpenSubtitle =>
      'Rosso, bianco, rosato, spumante — tutto vale. Annotali tutti.';

  @override
  String get onbArchSteadyTitle => 'Degustatore costante';

  @override
  String get onbArchSteadySubtitle =>
      'Il vino resta nella rotazione. Sippd tiene il filo.';

  @override
  String get onbArchNowAndThenTitle => 'Degustatore occasionale';

  @override
  String get onbArchNowAndThenSubtitle => 'Vino per i momenti che contano.';

  @override
  String get onbArchOccasionalTitle => 'Calice raro';

  @override
  String get onbArchOccasionalSubtitle => 'Sorso raro, da ricordare.';

  @override
  String get onbArchFreshTitle => 'Palato fresco';

  @override
  String get onbArchFreshSubtitle =>
      'Strada nuova. Ogni bottiglia conta da qui.';

  @override
  String get onbArchCuriousTitle => 'Curioso di vino';

  @override
  String get onbArchCuriousSubtitle =>
      'Dicci di più e il tuo profilo si affina.';

  @override
  String get onbCtaGetStarted => 'Inizia';

  @override
  String get onbCtaIUnderstand => 'Ho capito';

  @override
  String get onbCtaContinue => 'Continua';

  @override
  String get onbCtaSignInToSave => 'Accedi per salvare';

  @override
  String get onbCtaSaveAndContinue => 'Salva e continua';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Livello';

  @override
  String get tasteEditorFreq => 'Quanto spesso';

  @override
  String get tasteEditorStyles => 'Stili preferiti';

  @override
  String get tasteEditorGoals => 'Cosa cerchi';

  @override
  String get tasteEditorFreqWeekly => 'Settimanale';

  @override
  String get tasteEditorFreqMonthly => 'Mensile';

  @override
  String get tasteEditorFreqRare => 'Raro';

  @override
  String get tasteEditorGoalRemember => 'Ricordare';

  @override
  String get tasteEditorGoalDiscover => 'Scoprire';

  @override
  String get tasteEditorGoalSocial => 'Sociale';

  @override
  String get tasteEditorGoalValue => 'Valore';

  @override
  String get authLoginWelcomeBack => 'Bentornato';

  @override
  String get authLoginCreateAccount => 'Crea il tuo account';

  @override
  String get authLoginDisplayNameLabel => 'Nome visualizzato';

  @override
  String get authLoginEmailLabel => 'E-mail';

  @override
  String get authLoginPasswordLabel => 'Password';

  @override
  String get authLoginConfirmPasswordLabel => 'Conferma password';

  @override
  String get authLoginDisplayNameMin => 'Min 2 caratteri';

  @override
  String get authLoginDisplayNameMax => 'Max 30 caratteri';

  @override
  String get authLoginEmailInvalid => 'E-mail valida richiesta';

  @override
  String get authLoginPasswordMin => 'Min 8 caratteri';

  @override
  String get authLoginPasswordRequired => 'Inserisci la password';

  @override
  String get authLoginPasswordsDontMatch => 'Le password non coincidono';

  @override
  String get authLoginForgotPassword => 'Password dimenticata?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Inserisci prima un\'e-mail valida sopra.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Impossibile creare l\'account. Riprova.';

  @override
  String get authLoginSignInFailedFallback =>
      'Accesso fallito. Controlla i dati.';

  @override
  String get authLoginCreateAccountButton => 'Crea account';

  @override
  String get authLoginSignInButton => 'Accedi';

  @override
  String get authLoginToggleHaveAccount => 'Hai già un account? Accedi';

  @override
  String get authLoginToggleNoAccount => 'Non hai un account? Registrati';

  @override
  String get authOrDivider => 'oppure';

  @override
  String get authGoogleContinue => 'Continua con Google';

  @override
  String get authGoogleFailed => 'Accesso con Google fallito. Riprova.';

  @override
  String get authConfTitleReset => 'Link di reset inviato';

  @override
  String get authConfTitleSignup => 'Controlla la tua casella';

  @override
  String get authConfIntroReset => 'Abbiamo inviato un link di reset a';

  @override
  String get authConfIntroSignup => 'Abbiamo inviato un link di conferma a';

  @override
  String get authConfOutroReset => '.\nTocca per impostare una nuova password.';

  @override
  String get authConfOutroSignup => '.\nTocca per attivare il tuo account.';

  @override
  String get authConfOpenMailApp => 'Apri app mail';

  @override
  String get authConfResendEmail => 'Rinvia e-mail';

  @override
  String get authConfResendSending => 'Invio…';

  @override
  String authConfResendIn(int seconds) {
    return 'Rinvia tra ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'E-mail inviata.';

  @override
  String get authConfResendFailedFallback => 'Invio fallito. Riprova tra poco.';

  @override
  String get authConfBackToSignIn => 'Torna all\'accesso';

  @override
  String get authResetTitle => 'Imposta una nuova password';

  @override
  String get authResetSubtitle => 'Scegli una password che non hai mai usato.';

  @override
  String get authResetNewPasswordLabel => 'Nuova password';

  @override
  String get authResetConfirmPasswordLabel => 'Conferma password';

  @override
  String get authResetPasswordMin => 'Min 6 caratteri';

  @override
  String get authResetPasswordsDontMatch => 'Le password non coincidono';

  @override
  String get authResetFailedFallback =>
      'Impossibile aggiornare la password. Riprova.';

  @override
  String get authResetUpdateButton => 'Aggiorna password';

  @override
  String get authResetUpdatedSnack => 'Password aggiornata.';

  @override
  String get authProfileGuest => 'Ospite';

  @override
  String get authProfileSectionAccount => 'Account';

  @override
  String get authProfileSectionSupport => 'Supporto';

  @override
  String get authProfileSectionLegal => 'Note legali';

  @override
  String get authProfileEditProfile => 'Modifica profilo';

  @override
  String get authProfileFriends => 'Amici';

  @override
  String get authProfileNotifications => 'Notifiche';

  @override
  String get authProfileCleanupDuplicates => 'Pulisci duplicati';

  @override
  String get authProfileSubscription => 'Abbonamento';

  @override
  String get authProfileChangePassword => 'Cambia password';

  @override
  String get authProfileContactUs => 'Contattaci';

  @override
  String get authProfileRateSippd => 'Valuta Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Informativa privacy';

  @override
  String get authProfileTermsOfService => 'Termini di servizio';

  @override
  String get authProfileSignOut => 'Esci';

  @override
  String get authProfileSignIn => 'Accedi';

  @override
  String get authProfileDeleteAccount => 'Elimina account';

  @override
  String get authProfileViewFullStats => 'Vedi tutte le stats';

  @override
  String get authProfileChangePasswordDialogTitle => 'Cambiare password?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'Invieremo un link di reset a $email. Toccalo dalla casella per impostare una nuova password.';
  }

  @override
  String get authProfileCancel => 'Annulla';

  @override
  String get authProfileSendLink => 'Invia link';

  @override
  String get authProfileSendLinkFailedTitle => 'Impossibile inviare il link';

  @override
  String get authProfileSendLinkFailedFallback => 'Riprova tra poco.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'Impossibile aprire $url';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Eliminare l\'account?';

  @override
  String get authProfileDeleteDialogBody =>
      'Questo elimina in modo permanente profilo, vini, valutazioni, degustazioni, gruppi e amici. Non può essere annullato.';

  @override
  String get authProfileDeleteTypeConfirm => 'Scrivi DELETE per confermare:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Elimina';

  @override
  String get authProfileDeleteFailedFallback => 'Eliminazione fallita.';

  @override
  String get winesListSubtitle => 'La tua classifica vini';

  @override
  String get winesListSortRating => 'Ordina: voto';

  @override
  String get winesListSortRecent => 'Ordina: recenti';

  @override
  String get winesListSortName => 'Ordina: nome';

  @override
  String get winesListTooltipStats => 'Le tue stats';

  @override
  String get winesListTooltipAddWine => 'Aggiungi vino';

  @override
  String get winesListErrorLoad => 'Non sono riuscito a caricare i vini';

  @override
  String get winesEmptyTitle => 'Ancora nessun vino';

  @override
  String get winesEmptyFilteredTitle => 'Nessun vino corrisponde al filtro';

  @override
  String get winesEmptyFilteredBody => 'Prova un altro filtro';

  @override
  String get winesEmptyAddWineCta => 'Aggiungi vino';

  @override
  String get winesAddSaveLabel => 'Salva vino';

  @override
  String get winesAddDiscardTitle => 'Scartare il vino?';

  @override
  String get winesAddDiscardBody =>
      'Non hai ancora salvato questo vino. Uscendo ora perderai le modifiche.';

  @override
  String get winesAddDiscardKeepEditing => 'Continua a modificare';

  @override
  String get winesAddDiscardConfirm => 'Scarta';

  @override
  String get winesAddDuplicateTitle => 'Sembra un duplicato';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Hai già registrato «$name» con la stessa annata, cantina e uva. Apri la voce esistente o aggiungine comunque una nuova?';
  }

  @override
  String get winesAddDuplicateCancel => 'Annulla';

  @override
  String get winesAddDuplicateAddAnyway => 'Aggiungi comunque';

  @override
  String get winesAddDuplicateOpenExisting => 'Apri esistente';

  @override
  String get winesDetailNotFound => 'Vino non trovato';

  @override
  String get winesDetailErrorLoad => 'Non sono riuscito a caricare il vino';

  @override
  String get winesDetailMenuCompare => 'Confronta con…';

  @override
  String get winesDetailMenuShareRating => 'Condividi voto';

  @override
  String get winesDetailMenuShareToGroup => 'Condividi nel gruppo';

  @override
  String get winesDetailMenuEdit => 'Modifica vino';

  @override
  String get winesDetailMenuTastingNotesPro => 'Note di degustazione (Pro)';

  @override
  String get winesDetailMenuDelete => 'Elimina vino';

  @override
  String get winesDetailStatRating => 'Voto';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Prezzo';

  @override
  String get winesDetailStatRegion => 'Regione';

  @override
  String get winesDetailStatCountry => 'Paese';

  @override
  String get winesDetailSectionNotes => 'NOTE';

  @override
  String get winesDetailSectionPlace => 'LUOGO';

  @override
  String get winesDetailPlaceEmpty => 'Nessun luogo';

  @override
  String get winesDetailDeleteTitle => 'Eliminare il vino?';

  @override
  String get winesDetailDeleteBody => 'Non si può annullare.';

  @override
  String get winesDetailDeleteCancel => 'Annulla';

  @override
  String get winesDetailDeleteConfirm => 'Elimina';

  @override
  String get winesEditErrorLoad => 'Non sono riuscito a caricare il vino';

  @override
  String get winesEditErrorMemories => 'Non sono riuscito a caricare i ricordi';

  @override
  String get winesEditNotFound => 'Vino non trovato';

  @override
  String get winesCleanupTitle => 'Pulisci duplicati';

  @override
  String get winesCleanupErrorLoad =>
      'Non sono riuscito a caricare i duplicati';

  @override
  String get winesCleanupEmptyTitle => 'Nessun duplicato da pulire';

  @override
  String get winesCleanupEmptyBody =>
      'I tuoi vini sono in ordine. Controlliamo automaticamente nomi e cantine quasi identici.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% match';
  }

  @override
  String get winesCleanupKeepA => 'Tieni A';

  @override
  String get winesCleanupKeepB => 'Tieni B';

  @override
  String get winesCleanupSkippedSnack =>
      'Saltato per ora — riapparirà al prossimo accesso.';

  @override
  String get winesCleanupDifferentWines => 'Sono vini diversi';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'Unire in «$name»?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Ogni voto, condivisione di gruppo e statistica che puntava a «$loser» passerà a «$keeper». Non si può annullare.';
  }

  @override
  String get winesCleanupMergeCancel => 'Annulla';

  @override
  String get winesCleanupMergeConfirm => 'Unisci';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Unito in «$name».';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Unione fallita.';

  @override
  String get winesCompareHeader => 'CONFRONTA';

  @override
  String get winesComparePickerSubtitle => 'Scegli il secondo vino.';

  @override
  String get winesComparePickerEmptyTitle => 'Ancora nessun altro vino';

  @override
  String get winesComparePickerEmptyBody =>
      'Aggiungi almeno un altro vino per confrontare.';

  @override
  String get winesComparePickerErrorFallback =>
      'Non sono riuscito a caricare i vini.';

  @override
  String get winesCompareMissingSameWine =>
      'Scegli un vino diverso da confrontare.';

  @override
  String get winesCompareMissingDefault =>
      'Non sono riuscito a caricare entrambi i vini.';

  @override
  String get winesCompareErrorFallback =>
      'Non sono riuscito a caricare i vini.';

  @override
  String get winesCompareSectionAtAGlance => 'A colpo d’occhio';

  @override
  String get winesCompareSectionTasting => 'Profilo di degustazione';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Corpo, tannino, acidità, dolcezza, legno, finale.';

  @override
  String get winesCompareSectionNotes => 'Note';

  @override
  String get winesCompareAttrType => 'TIPO';

  @override
  String get winesCompareAttrVintage => 'ANNATA';

  @override
  String get winesCompareAttrGrape => 'UVA';

  @override
  String get winesCompareAttrOrigin => 'ORIGINE';

  @override
  String get winesCompareAttrPrice => 'PREZZO';

  @override
  String get winesCompareNotesEyebrow => 'NOTE';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'VINO $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Vedi corpo, tannino, acidità e altro a confronto.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Sblocca con Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Aggiungi note di degustazione a uno dei due vini per vederle confrontate qui.';

  @override
  String get winesFormHintName => 'Nome del vino';

  @override
  String get winesFormSubmitDefault => 'Salva vino';

  @override
  String get winesFormPhotoLabel => 'Foto';

  @override
  String get winesFormStatRating => 'Voto';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Prezzo';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Regione';

  @override
  String get winesFormStatCountry => 'Paese';

  @override
  String get winesFormChipWinery => 'Cantina';

  @override
  String get winesFormChipGrape => 'Uva';

  @override
  String get winesFormChipYear => 'Anno';

  @override
  String get winesFormChipNotes => 'Note';

  @override
  String get winesFormChipNotesFilled => 'Note ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Tocca per aggiungere il luogo';

  @override
  String get winesFormWineryTitle => 'Cantina';

  @override
  String get winesFormWineryHint => 'es. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Note di degustazione';

  @override
  String get winesFormNotesHint => 'Aromi, corpo, finale…';

  @override
  String get winesFormTypeRed => 'Rosso';

  @override
  String get winesFormTypeWhite => 'Bianco';

  @override
  String get winesFormTypeRose => 'Rosato';

  @override
  String get winesFormTypeSparkling => 'Spumante';

  @override
  String get winesMemoriesHeader => 'Ricordi';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Ricordi ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Aggiungi';

  @override
  String get winesMemoriesRemoveTitle => 'Rimuovere il ricordo?';

  @override
  String get winesMemoriesRemoveBody => 'Verrà tolta questa foto dal vino.';

  @override
  String get winesMemoriesRemoveCancel => 'Annulla';

  @override
  String get winesMemoriesRemoveConfirm => 'Rimuovi';

  @override
  String get winesPhotoSourceTake => 'Scatta foto';

  @override
  String get winesPhotoSourceGallery => 'Scegli dalla galleria';

  @override
  String get winesGrapeSheetTitle => 'Vitigno';

  @override
  String get winesGrapeSheetHint => 'es. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Usa «';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '» come personalizzato';

  @override
  String get winesGrapeSheetEmpty => 'Ancora nessuna uva disponibile.';

  @override
  String get winesGrapeSheetErrorLoad =>
      'Non sono riuscito a caricare il catalogo uve.';

  @override
  String get winesGrapeSheetUseTyped => 'Usa quello che ho scritto';

  @override
  String get winesRegionSheetTitle => 'Regione vinicola';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Scegli da quale parte di $country viene il vino — o salta se non sei sicuro.';
  }

  @override
  String get winesRegionSheetSkip => 'Salta';

  @override
  String get winesRegionSheetSearchHint => 'Cerca regione…';

  @override
  String get winesRegionSheetClear => 'Rimuovi regione';

  @override
  String get winesRegionSheetOther => 'Altra regione…';

  @override
  String get winesRegionSheetOtherTitle => 'Regione';

  @override
  String get winesRegionSheetOtherHint => 'es. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Cerca paese…';

  @override
  String get winesCountrySheetTopHeader => 'Top paesi vinicoli';

  @override
  String get winesCountrySheetOtherHeader => 'Altri paesi';

  @override
  String get winesRatingSheetSaveCta => 'Salva voto';

  @override
  String get winesRatingSheetCancel => 'Annulla';

  @override
  String get winesRatingSheetSaveError => 'Non riesco a salvare.';

  @override
  String get winesRatingHeaderLabel => 'IL TUO VOTO';

  @override
  String get winesRatingChipTasting => 'Note di degustazione';

  @override
  String get winesRatingInputLabel => 'Voto';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Salva prima il vino — le note di degustazione si collegano all’ID canonico.';

  @override
  String get winesExpertSheetTitle => 'Note di degustazione';

  @override
  String get winesExpertSheetSubtitle => 'Percezioni stile WSET';

  @override
  String get winesExpertSheetSave => 'Salva';

  @override
  String get winesExpertAxisBody => 'Corpo';

  @override
  String get winesExpertAxisTannin => 'Tannino';

  @override
  String get winesExpertAxisAcidity => 'Acidità';

  @override
  String get winesExpertAxisSweetness => 'Dolcezza';

  @override
  String get winesExpertAxisOak => 'Legno';

  @override
  String get winesExpertAxisFinish => 'Finale';

  @override
  String get winesExpertAxisAromas => 'Aromi';

  @override
  String get winesExpertBodyLow => 'leggero';

  @override
  String get winesExpertBodyHigh => 'pieno';

  @override
  String get winesExpertTanninLow => 'morbido';

  @override
  String get winesExpertTanninHigh => 'deciso';

  @override
  String get winesExpertAcidityLow => 'morbida';

  @override
  String get winesExpertAcidityHigh => 'fresca';

  @override
  String get winesExpertSweetnessLow => 'secco';

  @override
  String get winesExpertSweetnessHigh => 'dolce';

  @override
  String get winesExpertOakLow => 'senza legno';

  @override
  String get winesExpertOakHigh => 'intenso';

  @override
  String get winesExpertFinishShort => 'Corto';

  @override
  String get winesExpertFinishMedium => 'Medio';

  @override
  String get winesExpertFinishLong => 'Lungo';

  @override
  String get winesExpertSummaryHeader => 'NOTE DI DEGUSTAZIONE';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMI';

  @override
  String get winesExpertSummaryAxisBody => 'CORPO';

  @override
  String get winesExpertSummaryAxisTannin => 'TANNINO';

  @override
  String get winesExpertSummaryAxisAcidity => 'ACIDITÀ';

  @override
  String get winesExpertSummaryAxisSweetness => 'DOLCEZZA';

  @override
  String get winesExpertSummaryAxisOak => 'LEGNO';

  @override
  String get winesExpertSummaryAxisFinish => 'FINALE';

  @override
  String get winesExpertDescriptorBody1 => 'molto leggero';

  @override
  String get winesExpertDescriptorBody2 => 'leggero';

  @override
  String get winesExpertDescriptorBody3 => 'medio';

  @override
  String get winesExpertDescriptorBody4 => 'pieno';

  @override
  String get winesExpertDescriptorBody5 => 'pesante';

  @override
  String get winesExpertDescriptorTannin1 => 'setoso';

  @override
  String get winesExpertDescriptorTannin2 => 'morbido';

  @override
  String get winesExpertDescriptorTannin3 => 'medio';

  @override
  String get winesExpertDescriptorTannin4 => 'deciso';

  @override
  String get winesExpertDescriptorTannin5 => 'stringente';

  @override
  String get winesExpertDescriptorAcidity1 => 'piatta';

  @override
  String get winesExpertDescriptorAcidity2 => 'morbida';

  @override
  String get winesExpertDescriptorAcidity3 => 'equilibrata';

  @override
  String get winesExpertDescriptorAcidity4 => 'fresca';

  @override
  String get winesExpertDescriptorAcidity5 => 'tagliente';

  @override
  String get winesExpertDescriptorSweetness1 => 'molto secco';

  @override
  String get winesExpertDescriptorSweetness2 => 'secco';

  @override
  String get winesExpertDescriptorSweetness3 => 'abboccato';

  @override
  String get winesExpertDescriptorSweetness4 => 'dolce';

  @override
  String get winesExpertDescriptorSweetness5 => 'molto dolce';

  @override
  String get winesExpertDescriptorOak1 => 'senza legno';

  @override
  String get winesExpertDescriptorOak2 => 'sottile';

  @override
  String get winesExpertDescriptorOak3 => 'presente';

  @override
  String get winesExpertDescriptorOak4 => 'marcato';

  @override
  String get winesExpertDescriptorOak5 => 'intenso';

  @override
  String get winesExpertDescriptorFinish1 => 'corto';

  @override
  String get winesExpertDescriptorFinish2 => 'medio';

  @override
  String get winesExpertDescriptorFinish3 => 'lungo';

  @override
  String get winesCanonicalPromptTitle => 'Stesso vino?';

  @override
  String get winesCanonicalPromptBody =>
      'Assomiglia a un vino già nel catalogo. Collegarli mantiene stats e match precisi.';

  @override
  String get winesCanonicalPromptInputLabel => 'Quello che stai aggiungendo';

  @override
  String get winesCanonicalPromptExistingLabel => 'GIÀ IN CATALOGO';

  @override
  String get winesCanonicalPromptDifferent => 'No, è un vino diverso';

  @override
  String get winesFriendRatingsHeader => 'AMICI CHE L’HANNO VOTATO';

  @override
  String get winesFriendRatingsFallback => 'Amico';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count altri';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Tutti';

  @override
  String get winesTypeFilterRed => 'Rosso';

  @override
  String get winesTypeFilterWhite => 'Bianco';

  @override
  String get winesTypeFilterRose => 'Rosato';

  @override
  String get winesTypeFilterSparkling => 'Spumante';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Il tuo viaggio nel vino, visualizzato';

  @override
  String get winesStatsPreviewBadge => 'ANTEPRIMA';

  @override
  String get winesStatsPreviewHint => 'Quello che vedrai dopo qualche voto.';

  @override
  String get winesStatsEmptyEyebrow => 'INIZIA';

  @override
  String get winesStatsEmptyTitle => 'Le tue stats partono da un voto';

  @override
  String get winesStatsEmptyBody =>
      'Vota il tuo primo vino per dare vita a gusto, regioni e valore qui.';

  @override
  String get winesStatsEmptyCta => 'Vota un vino';

  @override
  String get winesStatsHeroLabel => 'LA TUA MEDIA';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'personale';

  @override
  String get winesStatsHeroChipGroup => 'gruppo';

  @override
  String get winesStatsHeroChipTasting => 'degustazione';

  @override
  String get winesStatsSectionTypeBreakdown => 'Ripartizione per tipo';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Come si distribuisce il tuo gusto sui quattro stili.';

  @override
  String get winesStatsSectionTopRated => 'Più votati';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Il tuo podio personale.';

  @override
  String get winesStatsSectionTimeline => 'Timeline';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Mese per mese, i vini che hanno scritto il tuo anno.';

  @override
  String get winesStatsSectionPartners => 'Compagni di degustazione';

  @override
  String get winesStatsSectionPartnersSubtitle => 'Con chi degusti di più.';

  @override
  String get winesStatsSectionPrices => 'Prezzi e valore';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Somma dei prezzi bottiglia registrati sui vini votati — non spesa reale di consumo.';

  @override
  String get winesStatsSectionPlaces => 'Dove hai bevuto vino';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Ogni vino che hai registrato con un luogo.';

  @override
  String get winesStatsSectionRegions => 'Top regioni';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'Da dove vengono la maggior parte delle tue bottiglie.';

  @override
  String get winesStatsPartnersErrorTitle =>
      'Non sono riuscito a caricare i compagni';

  @override
  String get winesStatsPartnersErrorBody => 'Tira giù o riprova fra poco.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Degustate insieme';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Quando tu e un amico votate lo stesso vino in un gruppo, comparirà qui.';

  @override
  String get winesStatsPartnersCta => 'Apri gruppi';

  @override
  String get winesStatsPriceEmptyTitle => 'Aggiungi un prezzo';

  @override
  String get winesStatsPriceEmptyBody =>
      'Registra quanto hai pagato per sbloccare spesa, costo medio e best value.';

  @override
  String get winesStatsPriceEmptyCta => 'Modifica un vino';

  @override
  String get winesStatsPlacesEmptyTitle => 'Aggiungi un luogo';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Metti un pin su un vino per mappare dove bevi — bar, cene, viaggi.';

  @override
  String get winesStatsPlacesEmptyCta => 'Modifica un vino';

  @override
  String get winesStatsRegionsEmptyTitle => 'Aggiungi una regione';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Tagga i vini con regione o paese per vedere dove pende il tuo gusto.';

  @override
  String get winesStatsRegionsEmptyCta => 'Modifica un vino';

  @override
  String get winesStatsPartnersHint =>
      'Conta vini votati insieme nei gruppi condivisi.';

  @override
  String get winesStatsPartnersFallback => 'Amico di vino';

  @override
  String get winesStatsSpendingLabel => 'PORTAFOGLIO VOTATO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vini con prezzo',
      one: '1 vino con prezzo',
    );
    return 'su $_temp0 · media $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Più caro';

  @override
  String get winesStatsSpendingBestValue => 'Miglior rapporto';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count altre';
  }

  @override
  String get winesStatsProLockTitle => 'Sblocca 3 insight in più';

  @override
  String get winesStatsProLockBody =>
      'Vedi da dove arrivano le tue bottiglie, quanto spendi e su quali regioni punti di più.';

  @override
  String get winesStatsProLockPillPrices => 'Prezzi';

  @override
  String get winesStatsProLockPillWhere => 'Dove';

  @override
  String get winesStatsProLockPillRegions => 'Top regioni';

  @override
  String get winesStatsProLockCta => 'Sblocca con Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 mese precedente';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count mesi precedenti';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vini',
      one: '1 vino',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count luoghi',
      one: '1 luogo',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Chiudi';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'vino';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'vini';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Più bevuto';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Più votato';
}

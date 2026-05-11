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
}

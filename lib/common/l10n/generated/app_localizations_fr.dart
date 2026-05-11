// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsLoadError =>
      'Impossible de charger les paramètres de notifications';

  @override
  String get sectionTastings => 'Dégustations';

  @override
  String get sectionFriends => 'Amis';

  @override
  String get sectionGroups => 'Groupes';

  @override
  String get tileTastingRemindersLabel => 'Rappels de dégustation';

  @override
  String get tileTastingRemindersSubtitle =>
      'Notification avant le début d\'une dégustation';

  @override
  String get tileFriendActivityLabel => 'Activité des amis';

  @override
  String get tileFriendActivitySubtitle => 'Demandes et acceptations';

  @override
  String get tileGroupActivityLabel => 'Activité du groupe';

  @override
  String get tileGroupActivitySubtitle =>
      'Invitations, adhésions et nouvelles dégustations';

  @override
  String get tileGroupWineSharedLabel => 'Nouveau vin partagé';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Quand un ami ajoute un vin à ton groupe';

  @override
  String get hoursPickerLabel => 'Me notifier';

  @override
  String get hoursPickerHint =>
      'S\'applique à toutes les dégustations à venir — modifiable à tout moment.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Langue';

  @override
  String get languageSheetTitle => 'Choisir la langue';

  @override
  String get languageOptionSystem => 'Langue du système';

  @override
  String get onbWelcomeTitle => 'Ta mémoire\ndu vin.';

  @override
  String get onbWelcomeBody =>
      'Note les vins que tu aimes. Souviens-toi pour toujours. Déguste avec tes amis.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Déjà un compte ? ';

  @override
  String get onbWelcomeSignIn => 'Se connecter';

  @override
  String get onbWhyEyebrow => 'Pourquoi Sippd';

  @override
  String get onbWhyTitle => 'Pensé pour ceux\nqui boivent vraiment du vin.';

  @override
  String get onbWhyPrinciple1Headline => 'Photo. Note. Souviens-toi.';

  @override
  String get onbWhyPrinciple1Line =>
      'Trois tapotements, tu le retrouves l\'an prochain.';

  @override
  String get onbWhyPrinciple2Headline => 'Dégustations entre amis.';

  @override
  String get onbWhyPrinciple2Line =>
      'Verres à l\'aveugle, notes partagées. Pas de tableurs.';

  @override
  String get onbWhyPrinciple3Headline => 'Fonctionne hors ligne.';

  @override
  String get onbWhyPrinciple3Line =>
      'Note partout. Se synchronise à la maison.';

  @override
  String get onbLevelEyebrow => 'À propos de toi';

  @override
  String get onbLevelTitle => 'Tu en es où\nau niveau du vin ?';

  @override
  String get onbLevelSubtitle =>
      'Pas de mauvaise réponse. On adapte les suggestions à ton rythme.';

  @override
  String get onbLevelBeginnerLabel => 'Débutant';

  @override
  String get onbLevelBeginnerSubtitle => 'Je commence';

  @override
  String get onbLevelCuriousLabel => 'Curieux';

  @override
  String get onbLevelCuriousSubtitle => 'Quelques préférés';

  @override
  String get onbLevelEnthusiastLabel => 'Passionné';

  @override
  String get onbLevelEnthusiastSubtitle => 'Je sais ce que j\'aime';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Niveau sommelier';

  @override
  String get onbFreqEyebrow => 'Ton rythme';

  @override
  String get onbFreqTitle => 'À quelle fréquence\nouvres-tu une bouteille ?';

  @override
  String get onbFreqWeekly => 'Chaque semaine';

  @override
  String get onbFreqMonthly => 'Quelques fois par mois';

  @override
  String get onbFreqRare => 'De temps en temps';

  @override
  String get onbGoalsEyebrow => 'Tes objectifs';

  @override
  String get onbGoalsTitle => 'Que cherches-tu\nchez Sippd ?';

  @override
  String get onbGoalsSubtitle =>
      'Choisis un ou plusieurs. Modifiable plus tard.';

  @override
  String get onbGoalRemember => 'Me souvenir des bouteilles que j\'aime';

  @override
  String get onbGoalDiscover => 'Découvrir de nouveaux styles';

  @override
  String get onbGoalSocial => 'Déguster entre amis';

  @override
  String get onbGoalValue => 'Garder un œil sur ce que je paie';

  @override
  String get onbStylesEyebrow => 'Tes styles';

  @override
  String get onbStylesTitle => 'Vers quoi\nte tournes-tu ?';

  @override
  String get onbStylesSubtitle =>
      'Coche ceux qui te ressemblent. On garde un œil sur tes choix.';

  @override
  String get wineTypeRed => 'Rouge';

  @override
  String get wineTypeWhite => 'Blanc';

  @override
  String get wineTypeRose => 'Rosé';

  @override
  String get wineTypeSparkling => 'Effervescent';

  @override
  String get onbRespEyebrow => 'Un mot de notre part';

  @override
  String get onbRespTitle => 'Bois moins,\ngoûte plus.';

  @override
  String get onbRespSubtitle =>
      'Sippd sert à se souvenir et noter les vins appréciés — pas à pousser à boire plus. Pas de streaks ni de quotas quotidiens. Volontairement.';

  @override
  String get onbRespHelpBody =>
      'Si l\'alcool te fait du mal à toi ou à un proche,\nde l\'aide gratuite et confidentielle existe.';

  @override
  String get onbRespHelpCta => 'Trouver de l\'aide';

  @override
  String get onbNameEyebrow => 'Presque fini';

  @override
  String get onbNameTitle => 'Comment doit-on\nt\'appeler ?';

  @override
  String get onbNameSubtitle =>
      'Prénom, surnom — comme tu veux. Choisis aussi une icône.';

  @override
  String get onbNameHint => 'Ton prénom';

  @override
  String get onbNameIconLabel => 'Choisis ton icône';

  @override
  String get onbNameIconSubtitle => 'Elle sert d\'avatar.';

  @override
  String get onbNotifEyebrow => 'Reste dans le coup';

  @override
  String get onbNotifTitle => 'Ne rate plus jamais\nune grande bouteille.';

  @override
  String get onbNotifSubtitle =>
      'On te prévient quand des amis lancent une dégustation ou t\'invitent dans un groupe. Désactivable à tout moment.';

  @override
  String get onbNotifPreview =>
      'Invitations dégustation\nNotes de groupe\nActivité des amis';

  @override
  String get onbNotifTurnOn => 'Activer les notifications';

  @override
  String get onbNotifNotNow => 'Plus tard';

  @override
  String get onbLoaderAlmostThere => 'PRESQUE FINI';

  @override
  String get onbLoaderCrafting => 'On crée ton profil.';

  @override
  String get onbLoaderAllSet => 'C\'est prêt.';

  @override
  String get onbLoaderStepMatching => 'On accorde ton goût';

  @override
  String get onbLoaderStepCurating => 'On affine tes styles';

  @override
  String get onbLoaderStepSetting => 'On prépare ton carnet';

  @override
  String get onbLoaderSeeProfile => 'Voir ton profil';

  @override
  String get onbLoaderContinue => 'Continuer';

  @override
  String get onbResultsEyebrow => 'TON PROFIL DE GOÛT';

  @override
  String get onbResultsLevelCard => 'Niveau';

  @override
  String get onbResultsFreqCard => 'Fréquence';

  @override
  String get onbResultsStylesCard => 'Styles';

  @override
  String get onbResultsGoalsCard => 'Objectifs';

  @override
  String get onbArchSommTitle => 'Sommelier aguerri';

  @override
  String get onbArchSommSubtitle =>
      'Tu connais ton terroir. Sippd garde les preuves.';

  @override
  String get onbArchPalateTitle => 'Palais affûté';

  @override
  String get onbArchPalateSubtitle =>
      'Chasseur de nuances. Sippd capture le détail.';

  @override
  String get onbArchRegularTitle => 'Habitué de cave';

  @override
  String get onbArchRegularSubtitle =>
      'Une bouteille par semaine, des avis plus tranchés chaque mois.';

  @override
  String get onbArchDevotedTitle => 'Dégustateur dévoué';

  @override
  String get onbArchDevotedSubtitle =>
      'Sérieux à chaque verre. Sippd garde tes notes.';

  @override
  String get onbArchRedTitle => 'Fidèle au rouge';

  @override
  String get onbArchRedSubtitle =>
      'Un cépage par verre. On t\'aide à ouvrir le champ.';

  @override
  String get onbArchBubbleTitle => 'Chasseur de bulles';

  @override
  String get onbArchBubbleSubtitle =>
      'Bulles avant tout. Sippd repère les bonnes.';

  @override
  String get onbArchOpenTitle => 'Palais ouvert';

  @override
  String get onbArchOpenSubtitle =>
      'Rouge, blanc, rosé, effervescent — tout est bienvenu. Note-les tous.';

  @override
  String get onbArchSteadyTitle => 'Dégustateur régulier';

  @override
  String get onbArchSteadySubtitle =>
      'Le vin reste dans la rotation. Sippd garde le fil.';

  @override
  String get onbArchNowAndThenTitle => 'Dégustateur occasionnel';

  @override
  String get onbArchNowAndThenSubtitle =>
      'Du vin pour les moments qui comptent.';

  @override
  String get onbArchOccasionalTitle => 'Verre occasionnel';

  @override
  String get onbArchOccasionalSubtitle => 'Gorgée rare, à retenir.';

  @override
  String get onbArchFreshTitle => 'Palais neuf';

  @override
  String get onbArchFreshSubtitle =>
      'Nouvelle route. Chaque bouteille compte à partir d\'ici.';

  @override
  String get onbArchCuriousTitle => 'Curieux de vin';

  @override
  String get onbArchCuriousSubtitle =>
      'Dis-nous-en plus, ton profil se précise.';

  @override
  String get onbCtaGetStarted => 'Commencer';

  @override
  String get onbCtaIUnderstand => 'Compris';

  @override
  String get onbCtaContinue => 'Continuer';

  @override
  String get onbCtaSignInToSave => 'Connecte-toi pour enregistrer';

  @override
  String get onbCtaSaveAndContinue => 'Enregistrer et continuer';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Niveau';

  @override
  String get tasteEditorFreq => 'À quelle fréquence';

  @override
  String get tasteEditorStyles => 'Styles préférés';

  @override
  String get tasteEditorGoals => 'Ce que tu cherches';

  @override
  String get tasteEditorFreqWeekly => 'Hebdomadaire';

  @override
  String get tasteEditorFreqMonthly => 'Mensuel';

  @override
  String get tasteEditorFreqRare => 'Rare';

  @override
  String get tasteEditorGoalRemember => 'Mémoriser';

  @override
  String get tasteEditorGoalDiscover => 'Découvrir';

  @override
  String get tasteEditorGoalSocial => 'Social';

  @override
  String get tasteEditorGoalValue => 'Valeur';
}

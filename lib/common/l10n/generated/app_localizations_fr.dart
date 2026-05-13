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

  @override
  String get authLoginWelcomeBack => 'Bon retour';

  @override
  String get authLoginCreateAccount => 'Crée ton compte';

  @override
  String get authLoginDisplayNameLabel => 'Nom affiché';

  @override
  String get authLoginEmailLabel => 'E-mail';

  @override
  String get authLoginPasswordLabel => 'Mot de passe';

  @override
  String get authLoginConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get authLoginDisplayNameMin => 'Min 2 caractères';

  @override
  String get authLoginDisplayNameMax => 'Max 30 caractères';

  @override
  String get authLoginEmailInvalid => 'E-mail valide requis';

  @override
  String get authLoginPasswordMin => 'Min 8 caractères';

  @override
  String get authLoginPasswordRequired => 'Saisis le mot de passe';

  @override
  String get authLoginPasswordsDontMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get authLoginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Mets d\'abord une e-mail valide au-dessus.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Impossible de créer le compte. Réessaie.';

  @override
  String get authLoginSignInFailedFallback =>
      'Connexion échouée. Vérifie tes infos.';

  @override
  String get authLoginCreateAccountButton => 'Créer le compte';

  @override
  String get authLoginSignInButton => 'Se connecter';

  @override
  String get authLoginToggleHaveAccount => 'Déjà un compte ? Se connecter';

  @override
  String get authLoginToggleNoAccount => 'Pas de compte ? S\'inscrire';

  @override
  String get authOrDivider => 'ou';

  @override
  String get authGoogleContinue => 'Continuer avec Google';

  @override
  String get authGoogleFailed => 'Connexion Google échouée. Réessaie.';

  @override
  String get authConfTitleReset => 'Lien de réinitialisation envoyé';

  @override
  String get authConfTitleSignup => 'Regarde ta boîte mail';

  @override
  String get authConfIntroReset =>
      'Nous avons envoyé un lien de réinitialisation à';

  @override
  String get authConfIntroSignup =>
      'Nous avons envoyé un lien de confirmation à';

  @override
  String get authConfOutroReset =>
      '.\nTouche-le pour définir un nouveau mot de passe.';

  @override
  String get authConfOutroSignup => '.\nTouche-le pour activer ton compte.';

  @override
  String get authConfOpenMailApp => 'Ouvrir la messagerie';

  @override
  String get authConfResendEmail => 'Renvoyer l\'e-mail';

  @override
  String get authConfResendSending => 'Envoi…';

  @override
  String authConfResendIn(int seconds) {
    return 'Renvoyer dans ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'E-mail envoyée.';

  @override
  String get authConfResendFailedFallback =>
      'Envoi impossible. Réessaie dans un instant.';

  @override
  String get authConfBackToSignIn => 'Retour à la connexion';

  @override
  String get authResetTitle => 'Définis un nouveau mot de passe';

  @override
  String get authResetSubtitle =>
      'Choisis un mot de passe que tu n\'as jamais utilisé.';

  @override
  String get authResetNewPasswordLabel => 'Nouveau mot de passe';

  @override
  String get authResetConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get authResetPasswordMin => 'Min 6 caractères';

  @override
  String get authResetPasswordsDontMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get authResetFailedFallback =>
      'Impossible de mettre à jour le mot de passe. Réessaie.';

  @override
  String get authResetUpdateButton => 'Mettre à jour le mot de passe';

  @override
  String get authResetUpdatedSnack => 'Mot de passe mis à jour.';

  @override
  String get authProfileGuest => 'Invité';

  @override
  String get authProfileSectionAccount => 'Compte';

  @override
  String get authProfileSectionSupport => 'Support';

  @override
  String get authProfileSectionLegal => 'Légal';

  @override
  String get authProfileEditProfile => 'Modifier le profil';

  @override
  String get authProfileFriends => 'Amis';

  @override
  String get authProfileNotifications => 'Notifications';

  @override
  String get authProfileCleanupDuplicates => 'Nettoyer les doublons';

  @override
  String get authProfileSubscription => 'Abonnement';

  @override
  String get authProfileChangePassword => 'Changer le mot de passe';

  @override
  String get authProfileContactUs => 'Nous contacter';

  @override
  String get authProfileRateSippd => 'Noter Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Politique de confidentialité';

  @override
  String get authProfileTermsOfService => 'Conditions d\'utilisation';

  @override
  String get authProfileSignOut => 'Se déconnecter';

  @override
  String get authProfileSignIn => 'Se connecter';

  @override
  String get authProfileDeleteAccount => 'Supprimer le compte';

  @override
  String get authProfileViewFullStats => 'Voir toutes les stats';

  @override
  String get authProfileChangePasswordDialogTitle =>
      'Changer le mot de passe ?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'Nous enverrons un lien de réinitialisation à $email. Touche-le depuis ta boîte mail pour définir un nouveau mot de passe.';
  }

  @override
  String get authProfileCancel => 'Annuler';

  @override
  String get authProfileSendLink => 'Envoyer le lien';

  @override
  String get authProfileSendLinkFailedTitle => 'Impossible d\'envoyer le lien';

  @override
  String get authProfileSendLinkFailedFallback => 'Réessaie dans un instant.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'Impossible d\'ouvrir $url';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Supprimer le compte ?';

  @override
  String get authProfileDeleteDialogBody =>
      'Cela supprime définitivement ton profil, vins, notes, dégustations, groupes et amis. Irréversible.';

  @override
  String get authProfileDeleteTypeConfirm => 'Tape DELETE pour confirmer :';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Supprimer';

  @override
  String get authProfileDeleteFailedFallback => 'Suppression échouée.';

  @override
  String get winesListSubtitle => 'Ton classement de vins';

  @override
  String get winesListSortRating => 'Tri : note';

  @override
  String get winesListSortRecent => 'Tri : récents';

  @override
  String get winesListSortName => 'Tri : nom';

  @override
  String get winesListTooltipStats => 'Tes stats';

  @override
  String get winesListTooltipAddWine => 'Ajouter un vin';

  @override
  String get winesListErrorLoad => 'Impossible de charger les vins';

  @override
  String get winesEmptyTitle => 'Pas encore de vin';

  @override
  String get winesEmptyFilteredTitle => 'Aucun vin ne correspond au filtre';

  @override
  String get winesEmptyFilteredBody => 'Essaie un autre filtre';

  @override
  String get winesEmptyAddWineCta => 'Ajouter un vin';

  @override
  String get winesAddSaveLabel => 'Enregistrer le vin';

  @override
  String get winesAddDiscardTitle => 'Abandonner le vin ?';

  @override
  String get winesAddDiscardBody =>
      'Tu n’as pas encore enregistré ce vin. Si tu quittes maintenant, tes changements seront perdus.';

  @override
  String get winesAddDiscardKeepEditing => 'Continuer à modifier';

  @override
  String get winesAddDiscardConfirm => 'Abandonner';

  @override
  String get winesAddDuplicateTitle => 'On dirait un doublon';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Tu as déjà enregistré « $name » avec le même millésime, domaine et cépage. Tu ouvres l’existant ou tu ajoutes quand même ?';
  }

  @override
  String get winesAddDuplicateCancel => 'Annuler';

  @override
  String get winesAddDuplicateAddAnyway => 'Ajouter quand même';

  @override
  String get winesAddDuplicateOpenExisting => 'Ouvrir l’existant';

  @override
  String get winesDetailNotFound => 'Vin introuvable';

  @override
  String get winesDetailErrorLoad => 'Impossible de charger le vin';

  @override
  String get winesDetailMenuCompare => 'Comparer avec…';

  @override
  String get winesDetailMenuShareRating => 'Partager la note';

  @override
  String get winesDetailMenuShareToGroup => 'Partager au groupe';

  @override
  String get winesDetailMenuEdit => 'Modifier le vin';

  @override
  String get winesDetailMenuTastingNotesPro => 'Notes de dégustation (Pro)';

  @override
  String get winesDetailMenuDelete => 'Supprimer le vin';

  @override
  String get winesDetailStatRating => 'Note';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Prix';

  @override
  String get winesDetailStatRegion => 'Région';

  @override
  String get winesDetailStatCountry => 'Pays';

  @override
  String get winesDetailSectionNotes => 'NOTES';

  @override
  String get winesDetailSectionPlace => 'LIEU';

  @override
  String get winesDetailPlaceEmpty => 'Aucun lieu';

  @override
  String get winesDetailDeleteTitle => 'Supprimer le vin ?';

  @override
  String get winesDetailDeleteBody => 'Ça ne peut pas être annulé.';

  @override
  String get winesDetailDeleteCancel => 'Annuler';

  @override
  String get winesDetailDeleteConfirm => 'Supprimer';

  @override
  String get winesEditErrorLoad => 'Impossible de charger le vin';

  @override
  String get winesEditErrorMemories => 'Impossible de charger les souvenirs';

  @override
  String get winesEditNotFound => 'Vin introuvable';

  @override
  String get winesCleanupTitle => 'Nettoyer les doublons';

  @override
  String get winesCleanupErrorLoad => 'Impossible de charger les doublons';

  @override
  String get winesCleanupEmptyTitle => 'Aucun doublon à nettoyer';

  @override
  String get winesCleanupEmptyBody =>
      'Tes vins sont propres. On repère automatiquement les noms et domaines presque identiques.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% correspondance';
  }

  @override
  String get winesCleanupKeepA => 'Garder A';

  @override
  String get winesCleanupKeepB => 'Garder B';

  @override
  String get winesCleanupSkippedSnack =>
      'Ignoré pour l’instant — réapparaîtra la prochaine fois.';

  @override
  String get winesCleanupDifferentWines => 'Ce sont des vins différents';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'Fusionner dans « $name » ?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Chaque note, partage de groupe et statistique qui pointait sur « $loser » passera à « $keeper ». Action irréversible.';
  }

  @override
  String get winesCleanupMergeCancel => 'Annuler';

  @override
  String get winesCleanupMergeConfirm => 'Fusionner';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Fusionné dans « $name ».';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Échec de la fusion.';

  @override
  String get winesCompareHeader => 'COMPARER';

  @override
  String get winesComparePickerSubtitle => 'Choisis le deuxième vin.';

  @override
  String get winesComparePickerEmptyTitle => 'Pas encore d’autre vin';

  @override
  String get winesComparePickerEmptyBody =>
      'Ajoute au moins un autre vin pour comparer.';

  @override
  String get winesComparePickerErrorFallback =>
      'Impossible de charger les vins.';

  @override
  String get winesCompareMissingSameWine =>
      'Choisis un vin différent à comparer.';

  @override
  String get winesCompareMissingDefault =>
      'Impossible de charger les deux vins.';

  @override
  String get winesCompareErrorFallback => 'Impossible de charger les vins.';

  @override
  String get winesCompareSectionAtAGlance => 'En un coup d’œil';

  @override
  String get winesCompareSectionTasting => 'Profil de dégustation';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Corps, tanin, acidité, sucrosité, bois, finale.';

  @override
  String get winesCompareSectionNotes => 'Notes';

  @override
  String get winesCompareAttrType => 'TYPE';

  @override
  String get winesCompareAttrVintage => 'MILLÉSIME';

  @override
  String get winesCompareAttrGrape => 'CÉPAGE';

  @override
  String get winesCompareAttrOrigin => 'ORIGINE';

  @override
  String get winesCompareAttrPrice => 'PRIX';

  @override
  String get winesCompareNotesEyebrow => 'NOTES';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'VIN $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Vois corps, tanin, acidité et plus côte à côte.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Débloquer avec Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Ajoute des notes de dégustation à l’un des vins pour les voir comparées ici.';

  @override
  String get winesFormHintName => 'Nom du vin';

  @override
  String get winesFormSubmitDefault => 'Enregistrer le vin';

  @override
  String get winesFormPhotoLabel => 'Photo';

  @override
  String get winesFormStatRating => 'Note';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Prix';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Région';

  @override
  String get winesFormStatCountry => 'Pays';

  @override
  String get winesFormChipWinery => 'Domaine';

  @override
  String get winesFormChipGrape => 'Cépage';

  @override
  String get winesFormChipYear => 'Année';

  @override
  String get winesFormChipNotes => 'Notes';

  @override
  String get winesFormChipNotesFilled => 'Notes ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Touche pour ajouter un lieu';

  @override
  String get winesFormWineryTitle => 'Domaine';

  @override
  String get winesFormWineryHint => 'p. ex. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Notes de dégustation';

  @override
  String get winesFormNotesHint => 'Arômes, corps, finale…';

  @override
  String get winesFormTypeRed => 'Rouge';

  @override
  String get winesFormTypeWhite => 'Blanc';

  @override
  String get winesFormTypeRose => 'Rosé';

  @override
  String get winesFormTypeSparkling => 'Effervescent';

  @override
  String get winesMemoriesHeader => 'Souvenirs';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Souvenirs ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Ajouter';

  @override
  String get winesMemoriesRemoveTitle => 'Supprimer le souvenir ?';

  @override
  String get winesMemoriesRemoveBody => 'Cette photo sera retirée du vin.';

  @override
  String get winesMemoriesRemoveCancel => 'Annuler';

  @override
  String get winesMemoriesRemoveConfirm => 'Supprimer';

  @override
  String get winesPhotoSourceTake => 'Prendre une photo';

  @override
  String get winesPhotoSourceGallery => 'Choisir dans la galerie';

  @override
  String get winesGrapeSheetTitle => 'Cépage';

  @override
  String get winesGrapeSheetHint => 'p. ex. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Utiliser «';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '» comme perso';

  @override
  String get winesGrapeSheetEmpty => 'Pas encore de cépages disponibles.';

  @override
  String get winesGrapeSheetErrorLoad =>
      'Impossible de charger le catalogue de cépages.';

  @override
  String get winesGrapeSheetUseTyped => 'Utiliser ce que j’ai tapé';

  @override
  String get winesRegionSheetTitle => 'Région viticole';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Choisis dans quelle partie de $country le vin a été produit — ou passe si tu n’es pas sûr.';
  }

  @override
  String get winesRegionSheetSkip => 'Passer';

  @override
  String get winesRegionSheetSearchHint => 'Chercher une région…';

  @override
  String get winesRegionSheetClear => 'Effacer la région';

  @override
  String get winesRegionSheetOther => 'Autre région…';

  @override
  String get winesRegionSheetOtherTitle => 'Région';

  @override
  String get winesRegionSheetOtherHint => 'p. ex. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Chercher un pays…';

  @override
  String get winesCountrySheetTopHeader => 'Pays viticoles phares';

  @override
  String get winesCountrySheetOtherHeader => 'Autres pays';

  @override
  String get winesRatingSheetSaveCta => 'Enregistrer la note';

  @override
  String get winesRatingSheetCancel => 'Annuler';

  @override
  String get winesRatingSheetSaveError => 'Enregistrement impossible.';

  @override
  String get winesRatingHeaderLabel => 'TA NOTE';

  @override
  String get winesRatingChipTasting => 'Notes de dégustation';

  @override
  String get winesRatingInputLabel => 'Note';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Enregistre d’abord le vin — les notes de dégustation se rattachent à l’ID canonique.';

  @override
  String get winesExpertSheetTitle => 'Notes de dégustation';

  @override
  String get winesExpertSheetSubtitle => 'Perceptions style WSET';

  @override
  String get winesExpertSheetSave => 'Enregistrer';

  @override
  String get winesExpertAxisBody => 'Corps';

  @override
  String get winesExpertAxisTannin => 'Tanin';

  @override
  String get winesExpertAxisAcidity => 'Acidité';

  @override
  String get winesExpertAxisSweetness => 'Sucrosité';

  @override
  String get winesExpertAxisOak => 'Bois';

  @override
  String get winesExpertAxisFinish => 'Finale';

  @override
  String get winesExpertAxisAromas => 'Arômes';

  @override
  String get winesExpertBodyLow => 'léger';

  @override
  String get winesExpertBodyHigh => 'puissant';

  @override
  String get winesExpertTanninLow => 'souple';

  @override
  String get winesExpertTanninHigh => 'ferme';

  @override
  String get winesExpertAcidityLow => 'souple';

  @override
  String get winesExpertAcidityHigh => 'vive';

  @override
  String get winesExpertSweetnessLow => 'sec';

  @override
  String get winesExpertSweetnessHigh => 'doux';

  @override
  String get winesExpertOakLow => 'sans bois';

  @override
  String get winesExpertOakHigh => 'intense';

  @override
  String get winesExpertFinishShort => 'Courte';

  @override
  String get winesExpertFinishMedium => 'Moyenne';

  @override
  String get winesExpertFinishLong => 'Longue';

  @override
  String get winesExpertSummaryHeader => 'NOTES DE DÉGUSTATION';

  @override
  String get winesExpertSummaryAromasHeader => 'ARÔMES';

  @override
  String get winesExpertSummaryAxisBody => 'CORPS';

  @override
  String get winesExpertSummaryAxisTannin => 'TANIN';

  @override
  String get winesExpertSummaryAxisAcidity => 'ACIDITÉ';

  @override
  String get winesExpertSummaryAxisSweetness => 'SUCROSITÉ';

  @override
  String get winesExpertSummaryAxisOak => 'BOIS';

  @override
  String get winesExpertSummaryAxisFinish => 'FINALE';

  @override
  String get winesExpertDescriptorBody1 => 'très léger';

  @override
  String get winesExpertDescriptorBody2 => 'léger';

  @override
  String get winesExpertDescriptorBody3 => 'moyen';

  @override
  String get winesExpertDescriptorBody4 => 'puissant';

  @override
  String get winesExpertDescriptorBody5 => 'lourd';

  @override
  String get winesExpertDescriptorTannin1 => 'soyeux';

  @override
  String get winesExpertDescriptorTannin2 => 'souple';

  @override
  String get winesExpertDescriptorTannin3 => 'moyen';

  @override
  String get winesExpertDescriptorTannin4 => 'ferme';

  @override
  String get winesExpertDescriptorTannin5 => 'serré';

  @override
  String get winesExpertDescriptorAcidity1 => 'plate';

  @override
  String get winesExpertDescriptorAcidity2 => 'souple';

  @override
  String get winesExpertDescriptorAcidity3 => 'équilibrée';

  @override
  String get winesExpertDescriptorAcidity4 => 'vive';

  @override
  String get winesExpertDescriptorAcidity5 => 'tranchante';

  @override
  String get winesExpertDescriptorSweetness1 => 'très sec';

  @override
  String get winesExpertDescriptorSweetness2 => 'sec';

  @override
  String get winesExpertDescriptorSweetness3 => 'demi-sec';

  @override
  String get winesExpertDescriptorSweetness4 => 'doux';

  @override
  String get winesExpertDescriptorSweetness5 => 'liquoreux';

  @override
  String get winesExpertDescriptorOak1 => 'sans bois';

  @override
  String get winesExpertDescriptorOak2 => 'subtil';

  @override
  String get winesExpertDescriptorOak3 => 'présent';

  @override
  String get winesExpertDescriptorOak4 => 'marqué';

  @override
  String get winesExpertDescriptorOak5 => 'intense';

  @override
  String get winesExpertDescriptorFinish1 => 'courte';

  @override
  String get winesExpertDescriptorFinish2 => 'moyenne';

  @override
  String get winesExpertDescriptorFinish3 => 'longue';

  @override
  String get winesCanonicalPromptTitle => 'Même vin ?';

  @override
  String get winesCanonicalPromptBody =>
      'Ça ressemble à un vin déjà dans le catalogue. Les lier garde tes stats et tes matchs précis.';

  @override
  String get winesCanonicalPromptInputLabel => 'Ce que tu ajoutes';

  @override
  String get winesCanonicalPromptExistingLabel => 'DÉJÀ AU CATALOGUE';

  @override
  String get winesCanonicalPromptDifferent => 'Non, c’est un vin différent';

  @override
  String get winesFriendRatingsHeader => 'AMIS QUI L’ONT NOTÉ';

  @override
  String get winesFriendRatingsFallback => 'Ami';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count de plus';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Tous';

  @override
  String get winesTypeFilterRed => 'Rouge';

  @override
  String get winesTypeFilterWhite => 'Blanc';

  @override
  String get winesTypeFilterRose => 'Rosé';

  @override
  String get winesTypeFilterSparkling => 'Effervescent';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Ton voyage dans le vin, visualisé';

  @override
  String get winesStatsPreviewBadge => 'APERÇU';

  @override
  String get winesStatsPreviewHint => 'Ce que tu verras après quelques notes.';

  @override
  String get winesStatsEmptyEyebrow => 'C’EST PARTI';

  @override
  String get winesStatsEmptyTitle => 'Tes stats commencent par une note';

  @override
  String get winesStatsEmptyBody =>
      'Note ton premier vin pour faire vivre ici ton goût, tes régions et ta valeur.';

  @override
  String get winesStatsEmptyCta => 'Noter un vin';

  @override
  String get winesStatsHeroLabel => 'TA MOYENNE';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'perso';

  @override
  String get winesStatsHeroChipGroup => 'groupe';

  @override
  String get winesStatsHeroChipTasting => 'dégustation';

  @override
  String get winesStatsSectionTypeBreakdown => 'Répartition par type';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Comment ton goût se répartit entre les quatre styles.';

  @override
  String get winesStatsSectionTopRated => 'Mieux notés';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Ton podium personnel.';

  @override
  String get winesStatsSectionTimeline => 'Frise';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Mois après mois, les vins qui ont écrit ton année.';

  @override
  String get winesStatsSectionPartners => 'Partenaires de dégustation';

  @override
  String get winesStatsSectionPartnersSubtitle =>
      'Avec qui tu déguste le plus.';

  @override
  String get winesStatsSectionPrices => 'Prix & valeur';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Somme des prix de bouteille notés sur tes vins — pas la conso réelle.';

  @override
  String get winesStatsSectionPlaces => 'Où tu as bu du vin';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Chaque vin enregistré avec un lieu.';

  @override
  String get winesStatsSectionRegions => 'Top régions';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'D’où viennent la plupart de tes bouteilles.';

  @override
  String get winesStatsPartnersErrorTitle =>
      'Impossible de charger les partenaires';

  @override
  String get winesStatsPartnersErrorBody =>
      'Tire vers le bas ou reviens dans un instant.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Goûter ensemble';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Quand toi et un ami notez le même vin dans un groupe, il apparaîtra ici.';

  @override
  String get winesStatsPartnersCta => 'Ouvrir les groupes';

  @override
  String get winesStatsPriceEmptyTitle => 'Ajoute un prix';

  @override
  String get winesStatsPriceEmptyBody =>
      'Note ce que tu as payé pour débloquer dépense, prix moyen et meilleurs rapports qualité-prix.';

  @override
  String get winesStatsPriceEmptyCta => 'Modifier un vin';

  @override
  String get winesStatsPlacesEmptyTitle => 'Ajoute un lieu';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Pose un pin sur un vin pour cartographier où tu bois — bars, dîners, voyages.';

  @override
  String get winesStatsPlacesEmptyCta => 'Modifier un vin';

  @override
  String get winesStatsRegionsEmptyTitle => 'Ajoute une région';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Tague des vins avec une région ou un pays pour voir où ton goût penche.';

  @override
  String get winesStatsRegionsEmptyCta => 'Modifier un vin';

  @override
  String get winesStatsPartnersHint =>
      'Compte les vins notés ensemble dans les groupes partagés.';

  @override
  String get winesStatsPartnersFallback => 'Pote de vin';

  @override
  String get winesStatsSpendingLabel => 'PORTEFEUILLE NOTÉ';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vins avec prix',
      one: '1 vin avec prix',
    );
    return 'sur $_temp0 · moy. $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Le plus cher';

  @override
  String get winesStatsSpendingBestValue => 'Meilleur rapport';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count de plus';
  }

  @override
  String get winesStatsProLockTitle => 'Débloque 3 insights de plus';

  @override
  String get winesStatsProLockBody =>
      'Vois d’où viennent tes bouteilles, ce que tu dépenses et les régions que tu soutiens le plus.';

  @override
  String get winesStatsProLockPillPrices => 'Prix';

  @override
  String get winesStatsProLockPillWhere => 'Où';

  @override
  String get winesStatsProLockPillRegions => 'Top régions';

  @override
  String get winesStatsProLockCta => 'Débloquer avec Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 mois antérieur';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count mois antérieurs';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vins',
      one: '1 vin',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lieux',
      one: '1 lieu',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Fermer';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'vin';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'vins';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Le plus bu';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Mieux noté';

  @override
  String get tastingCreateHeader => 'NOUVELLE DÉGUSTATION';

  @override
  String get tastingEditHeader => 'MODIFIER LA DÉGUSTATION';

  @override
  String get tastingFieldTitleLabel => 'Titre';

  @override
  String get tastingFieldDateLabel => 'Date';

  @override
  String get tastingFieldTimeLabel => 'Heure';

  @override
  String get tastingFieldPlaceLabel => 'Lieu';

  @override
  String get tastingFieldDescriptionLabel => 'Description';

  @override
  String get tastingFieldTapToAdd => 'Touche pour ajouter';

  @override
  String get tastingFieldOpenLineupLabel => 'Line-up ouvert';

  @override
  String get tastingFieldOpenLineupHint => 'Ajoute les vins au fur et à mesure';

  @override
  String get tastingTitleSheetTitle => 'Titre de la dégustation';

  @override
  String get tastingTitleSheetHint => 'ex. Soirée Barolo';

  @override
  String get tastingDescriptionSheetTitle => 'Description';

  @override
  String get tastingDescriptionSheetHint => 'De quoi s’agit-il ?';

  @override
  String get tastingCreateSubmitCta => 'Créer la dégustation';

  @override
  String get tastingEditSubmitCta => 'Enregistrer';

  @override
  String get tastingCreateFailedSnack => 'Impossible de créer la dégustation';

  @override
  String get tastingUpdateFailedSnack =>
      'Impossible de mettre à jour la dégustation';

  @override
  String get tastingDetailNotFound => 'Dégustation introuvable';

  @override
  String get tastingDetailErrorLoad => 'Impossible de charger la dégustation';

  @override
  String get tastingDetailMenuAddToCalendar => 'Ajouter au calendrier';

  @override
  String get tastingDetailMenuShare => 'Partager';

  @override
  String get tastingDetailMenuEdit => 'Modifier la dégustation';

  @override
  String get tastingDetailMenuCancel => 'Annuler la dégustation';

  @override
  String get tastingDetailCancelDialogTitle => 'Annuler la dégustation ?';

  @override
  String get tastingDetailCancelDialogBody =>
      'Elle sera supprimée pour tout le monde.';

  @override
  String get tastingDetailCancelDialogKeep => 'Garder';

  @override
  String get tastingDetailCancelDialogConfirm => 'Annuler';

  @override
  String get tastingDetailEndDialogTitle => 'Terminer la dégustation ?';

  @override
  String get tastingDetailEndDialogBody =>
      'Cela verrouille le récap. Les participants peuvent encore noter pendant un court instant.';

  @override
  String get tastingDetailEndDialogKeep => 'Continuer';

  @override
  String get tastingDetailEndDialogConfirm => 'Terminer';

  @override
  String get tastingCalendarFailedSnack => 'Impossible d’ouvrir le calendrier';

  @override
  String get tastingLifecycleUpcoming => 'À VENIR';

  @override
  String get tastingLifecycleLive => 'EN DIRECT';

  @override
  String get tastingLifecycleConcluded => 'TERMINÉE';

  @override
  String get tastingLifecycleStartCta => 'Démarrer la dégustation';

  @override
  String get tastingLifecycleEndCta => 'Terminer la dégustation';

  @override
  String get tastingDetailSectionPeople => 'Personnes';

  @override
  String get tastingDetailSectionPlace => 'Lieu';

  @override
  String get tastingDetailSectionWines => 'VINS';

  @override
  String get tastingDetailAddWines => 'Ajouter des vins';

  @override
  String get tastingDetailNoAttendees => 'Personne d’invité pour l’instant.';

  @override
  String get tastingDetailUnknownAttendee => 'Inconnu';

  @override
  String get tastingDetailRsvpYour => 'Ta réponse';

  @override
  String get tastingDetailRsvpGoing => 'Présent';

  @override
  String get tastingDetailRsvpMaybe => 'Peut-être';

  @override
  String get tastingDetailRsvpDeclined => 'Non';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count présents';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count peut-être';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count déclinés';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count en attente';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Présents';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Peut-être';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'Déclinés';

  @override
  String get tastingDetailAttendeesSheetPending => 'En attente';

  @override
  String get tastingEmptyOpenActiveTitle =>
      'Le line-up se remplit au fil de la soirée';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Toutes les personnes présentes peuvent ajouter des bouteilles';

  @override
  String get tastingEmptyDefaultTitle => 'Aucun vin dans le line-up';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Les vins pourront être ajoutés une fois la dégustation lancée';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Les vins seront ajoutés le soir même';

  @override
  String get tastingEmptyPlannedHost =>
      'Touche « Ajouter des vins » pour construire le line-up';

  @override
  String get tastingEmptyPlannedGuest => 'L’hôte n’a pas encore ajouté de vins';

  @override
  String get tastingRecapResultsHeader => 'RÉSULTATS';

  @override
  String get tastingRecapShareCta => 'Partager le récap';

  @override
  String get tastingRecapTopWineEyebrow => 'VIN DE LA SOIRÉE';

  @override
  String get tastingRecapEmpty =>
      'Aucune note n’a encore été envoyée pour cette dégustation.';

  @override
  String get tastingRecapRowNoRatings => 'aucune note';

  @override
  String get tastingRecapGroupFallback => 'Dégustation de groupe';

  @override
  String get tastingPickerSheetTitle => 'Ajouter des vins au line-up';

  @override
  String get tastingPickerEmpty => 'Tu n’as pas encore de vins.';

  @override
  String get tastingPickerErrorFallback => 'Impossible de charger les vins.';

  @override
  String get tastingPickerSubmitDefault => 'Ajouter des vins';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ajouter $count vins',
      one: 'Ajouter 1 vin',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Ajouté';

  @override
  String get groupListHeader => 'GROUPES';

  @override
  String get groupListSubtitle => 'Dégustez ensemble';

  @override
  String get groupListSortRecent => 'Tri : récents';

  @override
  String get groupListSortName => 'Tri : nom';

  @override
  String get groupListCreateTooltip => 'Créer un groupe';

  @override
  String get groupListJoinTitle => 'Rejoindre un groupe';

  @override
  String get groupListJoinSubtitle => 'Saisis un code d\'invitation';

  @override
  String get groupListJoinNotFound => 'Groupe introuvable';

  @override
  String get groupListErrorLoad => 'Impossible de charger les groupes';

  @override
  String get groupListEmptyTitle => 'Aucun groupe';

  @override
  String get groupListEmptyBody =>
      'Crées-en un ou rejoins-en un pour partager des vins';

  @override
  String get groupListEmptyCta => 'Créer un groupe';

  @override
  String get groupCreateSourceCamera => 'Caméra';

  @override
  String get groupCreateSourceGallery => 'Galerie';

  @override
  String get groupCreateSourceRemovePhoto => 'Retirer la photo';

  @override
  String get groupCreatePickFailedFallback => 'Sélection échouée.';

  @override
  String get groupCreateUploadFailedFallback =>
      'Échec de l\'envoi de la photo.';

  @override
  String get groupCreateFailedFallback =>
      'Impossible de créer le groupe. Réessaye.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get groupCreateTitle => 'Nouveau groupe';

  @override
  String get groupCreateNameHint => 'Nom du groupe';

  @override
  String get groupCreateSubmit => 'Créer';

  @override
  String get groupJoinTitle => 'Code d\'invitation';

  @override
  String get groupJoinHint => 'ex. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Rejoindre';

  @override
  String get groupDetailNotFound => 'Groupe introuvable';

  @override
  String get groupDetailErrorLoad => 'Impossible de charger le groupe';

  @override
  String get groupDetailSectionSharedWines => 'Vins partagés';

  @override
  String get groupDetailSectionTastings => 'Dégustations';

  @override
  String get groupDetailActionShare => 'Partager';

  @override
  String get groupDetailActionPlan => 'Planifier';

  @override
  String get groupDetailMenuEdit => 'Modifier le groupe';

  @override
  String get groupDetailMenuDelete => 'Supprimer le groupe';

  @override
  String get groupDetailMenuLeave => 'Quitter le groupe';

  @override
  String get groupDetailLeaveDialogTitle => 'Quitter le groupe ?';

  @override
  String get groupDetailLeaveDialogBody =>
      'Tu peux le rejoindre plus tard avec le code d\'invitation.';

  @override
  String get groupDetailLeaveDialogCancel => 'Annuler';

  @override
  String get groupDetailLeaveDialogConfirm => 'Quitter';

  @override
  String get groupDetailDeleteDialogTitle => 'Supprimer le groupe ?';

  @override
  String get groupDetailDeleteDialogBody =>
      'Le groupe et ses vins partagés seront supprimés pour tout le monde.';

  @override
  String get groupDetailDeleteDialogCancel => 'Annuler';

  @override
  String get groupDetailDeleteDialogConfirm => 'Supprimer';

  @override
  String get groupSettingsEditTitle => 'Modifier le groupe';

  @override
  String get groupSettingsNameLabel => 'Nom';

  @override
  String get groupSettingsSourceCamera => 'Caméra';

  @override
  String get groupSettingsSourceGallery => 'Galerie';

  @override
  String get groupSettingsRemovePhoto => 'Retirer la photo';

  @override
  String get groupSettingsUploadFailedFallback => 'Échec de l\'envoi.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Échec de la suppression.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get groupSettingsSave => 'Enregistrer';

  @override
  String get groupInviteEyebrow => 'INVITATION';

  @override
  String get groupInviteFriendsEyebrow => 'INVITER DES AMIS';

  @override
  String get groupInviteCodeCopied => 'Code d\'invitation copié';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Rejoins « $groupName » sur Sippd 🍷\n\n$url\n\nOu saisis le code : $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Rejoins $groupName sur Sippd';
  }

  @override
  String get groupInviteActionCopy => 'Copier le code';

  @override
  String get groupInviteActionShare => 'Partager le lien';

  @override
  String get groupInviteFriendsEmpty => 'Aucun ami à inviter.';

  @override
  String get groupInviteFriendsErrorLoad => 'Impossible de charger les amis';

  @override
  String get groupInviteFriendFallback => 'ami·e';

  @override
  String get groupInviteUnknownName => 'Inconnu';

  @override
  String groupInviteSentSnack(String name) {
    return 'Invitation envoyée à $name';
  }

  @override
  String get groupInviteSendFailedFallback =>
      'Impossible d\'envoyer l\'invitation.';

  @override
  String get groupInvitationsHeader => 'INVITATIONS';

  @override
  String get groupInvitationsInviterFallback => 'Quelqu\'un';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Invité par $name';
  }

  @override
  String get groupInvitationsDecline => 'Refuser';

  @override
  String get groupInvitationsAccept => 'Accepter';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return 'Tu as rejoint $name';
  }

  @override
  String get groupInvitationsAcceptFailed =>
      'Impossible d\'accepter l\'invitation';

  @override
  String get groupMembersCountOne => '1 membre';

  @override
  String groupMembersCountMany(int count) {
    return '$count membres';
  }

  @override
  String get groupMembersUnknown => 'Inconnu';

  @override
  String get groupMembersOwnerBadge => 'PROPRIÉTAIRE';

  @override
  String get groupWineCarouselDetails => 'Détails';

  @override
  String get groupWineCarouselEmptyTitle => 'Aucun vin partagé';

  @override
  String get groupWineCarouselEmptyBody =>
      'Choisis-en un dans ta cave pour démarrer la liste.';

  @override
  String get groupWineCarouselEmptyCta => 'Partager un vin';

  @override
  String get groupWineTypeRed => 'ROUGE';

  @override
  String get groupWineTypeWhite => 'BLANC';

  @override
  String get groupWineTypeRose => 'ROSÉ';

  @override
  String get groupWineTypeSparkling => 'EFFERVESCENT';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Enregistre le vin d\'abord — les notes s\'y rattachent.';

  @override
  String get groupWineRatingNoCanonical =>
      'Le vin n\'a pas encore d\'identité canonique. Réessaye.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'Le vin n\'a pas encore d\'identité canonique.';

  @override
  String get groupWineRatingNotesHint => 'Ajouter une note';

  @override
  String get groupWineRatingOfflineRetry => 'Hors ligne · Réessayer';

  @override
  String get groupWineRatingSaveFailedRetry => 'Échec · Réessayer';

  @override
  String get groupWineRatingSaved => 'Enregistré ✓';

  @override
  String get groupWineRatingSaveCta => 'Enregistrer la note';

  @override
  String get groupWineRatingRemoveMine => 'Retirer ma note';

  @override
  String get groupWineRatingUnshareDialogTitle => 'Retirer du groupe ?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '« $name » sera retiré de ce groupe. Les notes des membres seront aussi supprimées.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Annuler';

  @override
  String get groupWineRatingUnshareConfirm => 'Retirer';

  @override
  String get groupWineRatingMoreTooltip => 'Plus';

  @override
  String get groupWineRatingUnshareMenu => 'Retirer du groupe';

  @override
  String get groupWineRatingsTitle => 'Notes';

  @override
  String get groupWineRatingsCountOne => '1 note';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count notes';
  }

  @override
  String get groupWineRatingsAvgLabel => 'moy';

  @override
  String get groupWineRatingsBeFirst => 'Sois le premier à noter';

  @override
  String get groupWineRatingsSoloMe =>
      'Tu es le premier · invite les autres à noter';

  @override
  String get groupShareWineTitle => 'Partager un vin';

  @override
  String get groupShareWineErrorLoad => 'Impossible de charger les vins.';

  @override
  String get groupShareWineEmpty => 'Tu n\'as pas encore de vin.';

  @override
  String get groupShareWineSharedChip => 'Partagé';

  @override
  String get groupShareWineSheetTitle => 'Partager avec un groupe';

  @override
  String get groupShareWineSheetEmpty => 'Tu n\'es dans aucun groupe.';

  @override
  String get groupShareWineSheetErrorLoad =>
      'Impossible de charger les groupes.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Déjà partagé';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Partagé avec $name';
  }

  @override
  String get groupShareWineRowMemberOne => '1 membre';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count membres';
  }

  @override
  String get groupShareWineRowWineOne => '1 vin';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count vins';
  }

  @override
  String get groupShareMatchTitle => 'Déjà dans ce groupe';

  @override
  String groupShareMatchBody(String name) {
    return '« $name » ressemble à un vin qu\'un membre a déjà partagé. Est-ce le même vin ?';
  }

  @override
  String get groupShareMatchNone => 'Aucun · partager séparément';

  @override
  String get groupShareMatchCancel => 'Annuler';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Partagé par @$username';
  }

  @override
  String get groupFriendActionsInvite => 'Inviter dans un groupe';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return 'Inviter $name à…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'Aucun groupe pour inviter. Crées-en un ou rejoins-en un d\'abord.';

  @override
  String get groupFriendActionsPickerErrorLoad =>
      'Impossible de charger les groupes';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Dégustations passées ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'Aucune dégustation';

  @override
  String get groupCalendarEmptyBody =>
      'Planifies-en une pour réunir le groupe autour d\'une bouteille.';

  @override
  String get groupCalendarEmptyCta => 'Planifier une dégustation';

  @override
  String get groupWineDetailSectionRatings => 'NOTES DU GROUPE';

  @override
  String get groupWineDetailEmptyRatings => 'Aucune note du groupe.';

  @override
  String get groupWineDetailStatGroupAvg => 'Moy groupe';

  @override
  String get groupWineDetailStatRatings => 'Notes';

  @override
  String get groupWineDetailStatNoRatings => 'Aucune note';

  @override
  String get groupWineDetailStatRegion => 'Région';

  @override
  String get groupWineDetailStatCountry => 'Pays';

  @override
  String get groupWineDetailStatOrigin => 'Origine';

  @override
  String get groupWineDetailSharedByEyebrow => 'PARTAGÉ PAR';

  @override
  String get groupWineDetailSharerFallback => 'quelqu\'un';

  @override
  String get groupWineDetailMemberFallback => 'Membre';

  @override
  String get groupWineDetailRelJustNow => 'à l\'instant';

  @override
  String groupWineDetailRelMinutes(int count) {
    return 'il y a ${count}m';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return 'il y a ${count}h';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return 'il y a ${count}j';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return 'il y a ${count}sem';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return 'il y a ${count}mois';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return 'il y a ${count}a';
  }

  @override
  String get friendsHeader => 'AMIS';

  @override
  String get friendsSubtitle => 'Déguste avec des gens que tu connais';

  @override
  String get friendsSearchHint => 'Recherche par pseudo ou nom';

  @override
  String get friendsSearchEmpty => 'Aucun utilisateur trouvé';

  @override
  String get friendsSearchErrorFallback =>
      'Impossible de charger la recherche.';

  @override
  String get friendsUnknownUser => 'Inconnu';

  @override
  String friendsRequestsHeader(int count) {
    return 'Demandes ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'En attente de réponse ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Demande envoyée';

  @override
  String get friendsRequestSubtitle => 'souhaite devenir ton ami';

  @override
  String get friendsActionCancel => 'Annuler';

  @override
  String get friendsActionAdd => 'Ajouter';

  @override
  String get friendsCancelDialogFallbackUser => 'cet utilisateur';

  @override
  String get friendsCancelDialogTitle => 'Annuler la demande ?';

  @override
  String friendsCancelDialogBody(String name) {
    return 'Annuler ta demande d\'ami à $name ?';
  }

  @override
  String get friendsCancelDialogKeep => 'Garder';

  @override
  String get friendsCancelDialogConfirm => 'Annuler la demande';

  @override
  String get friendsListHeader => 'Tes amis';

  @override
  String get friendsListErrorFallback => 'Impossible de charger les amis.';

  @override
  String get friendsRemoveDialogTitle => 'Retirer un ami ?';

  @override
  String friendsRemoveDialogBody(String name) {
    return 'Retirer $name de tes amis ?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Retirer';

  @override
  String get friendsSendRequestErrorFallback =>
      'Impossible d\'envoyer la demande.';

  @override
  String get friendsStatusChipFriend => 'Ami';

  @override
  String get friendsStatusChipPending => 'En attente';

  @override
  String get friendsEmptyDefaultName => 'Un ami';

  @override
  String get friendsEmptyTitle => 'Réunis ton cercle de dégustation';

  @override
  String get friendsEmptyBody =>
      'Sippd est meilleur avec des amis. Envoie une invitation — ils atterrissent direct sur ton profil.';

  @override
  String get friendsEmptyInviteCta => 'Inviter des amis';

  @override
  String get friendsEmptyFindCta => 'Trouver par pseudo';

  @override
  String get friendsProfileNotFound => 'Profil introuvable';

  @override
  String get friendsProfileErrorLoad => 'Impossible de charger le profil';

  @override
  String get friendsProfileNameFallback => 'Ami';

  @override
  String get friendsProfileRecentWinesHeader => 'VINS RÉCENTS';

  @override
  String get friendsProfileWinesErrorLoad => 'Impossible de charger les vins';

  @override
  String get friendsProfileStatWines => 'Vins';

  @override
  String get friendsProfileStatAvg => 'Moy.';

  @override
  String get friendsProfileStatCountry => 'Pays';

  @override
  String get friendsProfileStatCountries => 'Pays';

  @override
  String get paywallPitchEyebrow => 'Sippd Pro';

  @override
  String get paywallPitchHeadline => 'Découvre comment\ntu déguste vraiment.';

  @override
  String get paywallPitchSubhead =>
      'Cartographie chaque bouteille, retrouve les amis qui boivent comme toi et plonge plus loin dans chaque dégustation.';

  @override
  String get paywallBenefitFriendsTitle =>
      'Groupes illimités et match entre amis';

  @override
  String get paywallBenefitFriendsSubtitle =>
      'Amène ta bande. Vois qui boit comme toi.';

  @override
  String get paywallBenefitCompassTitle =>
      'Boussole du goût et stats détaillées';

  @override
  String get paywallBenefitCompassSubtitle =>
      'Ta personnalité vinicole, cartographiée.';

  @override
  String get paywallBenefitNotesTitle => 'Notes de dégustation d\'expert';

  @override
  String get paywallBenefitNotesSubtitle => 'Nez · corps · tanins · finale.';

  @override
  String get paywallPlanMonthly => 'Mensuel';

  @override
  String get paywallPlanAnnual => 'Annuel';

  @override
  String get paywallPlanLifetime => 'À vie';

  @override
  String get paywallPlanSubtitleMonthly => 'Annule quand tu veux';

  @override
  String get paywallPlanSubtitleAnnual => 'Le plus populaire';

  @override
  String get paywallPlanSubtitleLifetime =>
      'Offre de lancement limitée · paiement unique';

  @override
  String get paywallPlanBadgeAnnual => 'LE PLUS POPULAIRE';

  @override
  String get paywallPlanBadgeLifetime => 'ÉDITION FONDATEURS';

  @override
  String paywallPlanSavingsVsMonthly(int pct) {
    return 'Économise $pct% vs mensuel';
  }

  @override
  String get paywallTrialTodayTitle => 'Aujourd\'hui';

  @override
  String get paywallTrialTodaySubtitle => 'Accès Pro complet débloqué.';

  @override
  String get paywallTrialDay5Title => 'Jour 5';

  @override
  String get paywallTrialDay5Subtitle => 'On te prévient avant le prélèvement.';

  @override
  String get paywallTrialDay7Title => 'Jour 7';

  @override
  String get paywallTrialDay7Subtitle =>
      'L\'essai se termine. Annule quand tu veux.';

  @override
  String get paywallCtaContinue => 'Continuer';

  @override
  String get paywallCtaSelectPlan => 'Choisis un plan';

  @override
  String get paywallCtaStartTrial => 'Démarrer l\'essai gratuit de 7 jours';

  @override
  String get paywallCtaMaybeLater => 'Plus tard';

  @override
  String get paywallCtaRestore => 'Restaurer les achats';

  @override
  String get paywallFooterDisclosure =>
      'Annule quand tu veux · facturé par Apple ou Google';

  @override
  String get paywallPlansLoadError => 'Impossible de charger les plans';

  @override
  String get paywallPlansEmpty => 'Aucun plan disponible pour l\'instant.';

  @override
  String get paywallErrorPurchaseFailed => 'Achat échoué. Réessaie.';

  @override
  String get paywallErrorRestoreFailed => 'Impossible de restaurer les achats.';

  @override
  String get paywallRestoreWelcomeBack => 'Bon retour sur Sippd Pro !';

  @override
  String get paywallRestoreNoneFound => 'Aucun abonnement actif trouvé.';

  @override
  String get paywallSubscriptionTitle => 'Abonnement';

  @override
  String get paywallSubscriptionBrand => 'Sippd Pro';

  @override
  String get paywallSubscriptionChipActive => 'ACTIF';

  @override
  String get paywallSubscriptionChipTrial => 'ESSAI';

  @override
  String get paywallSubscriptionChipEnding => 'SE TERMINE';

  @override
  String get paywallSubscriptionChipLifetime => 'À VIE';

  @override
  String get paywallSubscriptionChipTest => 'MODE TEST';

  @override
  String get paywallSubscriptionPlanTest => 'Mode test';

  @override
  String get paywallSubscriptionPlanLifetime => 'À vie';

  @override
  String get paywallSubscriptionPlanAnnual => 'Annuel';

  @override
  String get paywallSubscriptionPlanMonthly => 'Mensuel';

  @override
  String get paywallSubscriptionPlanWeekly => 'Hebdomadaire';

  @override
  String get paywallSubscriptionPlanGeneric => 'Plan Pro';

  @override
  String get paywallSubscriptionPeriodYear => '/ an';

  @override
  String get paywallSubscriptionPeriodMonth => '/ mois';

  @override
  String get paywallSubscriptionPeriodWeek => '/ semaine';

  @override
  String get paywallSubscriptionPeriodLifetime => 'paiement unique';

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
  String get paywallSubscriptionStorePromo => 'Accès promo';

  @override
  String paywallSubscriptionBilledVia(String store) {
    return 'Facturé via $store';
  }

  @override
  String get paywallSubscriptionStatusTestNoSub =>
      'Fonctionnalités Pro débloquées en local · pas de vrai abonnement';

  @override
  String get paywallSubscriptionStatusTestLocal =>
      'Fonctionnalités Pro débloquées en local';

  @override
  String get paywallSubscriptionStatusLifetime =>
      'Accès à vie — à toi pour toujours';

  @override
  String get paywallSubscriptionStatusEndingNoDate => 'Ne se renouvellera pas';

  @override
  String paywallSubscriptionStatusEndingWithDate(String date) {
    return 'Accès jusqu\'au $date · ne se renouvellera pas';
  }

  @override
  String get paywallSubscriptionStatusTrialActive => 'Essai actif';

  @override
  String get paywallSubscriptionStatusTrialEndsToday =>
      'L\'essai se termine aujourd\'hui';

  @override
  String get paywallSubscriptionStatusTrialEndsTomorrow =>
      'L\'essai se termine demain';

  @override
  String paywallSubscriptionStatusTrialEndsInDays(int days) {
    return 'L\'essai se termine dans $days jours';
  }

  @override
  String get paywallSubscriptionStatusActive => 'Actif';

  @override
  String paywallSubscriptionStatusRenewsOn(String date) {
    return 'Se renouvelle le $date';
  }

  @override
  String get paywallSubscriptionSectionIncluded => 'Inclus dans Pro';

  @override
  String get paywallSubscriptionSectionManage => 'Gérer';

  @override
  String get paywallSubscriptionRowChangePlan => 'Changer de plan';

  @override
  String get paywallSubscriptionRowRestore => 'Restaurer les achats';

  @override
  String get paywallSubscriptionRowCancel => 'Annuler l\'abonnement';

  @override
  String get paywallSubscriptionDisclosure =>
      'Les abonnements sont facturés par Apple ou Google. Gère-les dans les réglages du store.';

  @override
  String get paywallSubscriptionOpenError =>
      'Impossible d\'ouvrir les réglages d\'abonnement.';

  @override
  String get paywallMonthShortJan => 'janv.';

  @override
  String get paywallMonthShortFeb => 'févr.';

  @override
  String get paywallMonthShortMar => 'mars';

  @override
  String get paywallMonthShortApr => 'avr.';

  @override
  String get paywallMonthShortMay => 'mai';

  @override
  String get paywallMonthShortJun => 'juin';

  @override
  String get paywallMonthShortJul => 'juil.';

  @override
  String get paywallMonthShortAug => 'août';

  @override
  String get paywallMonthShortSep => 'sept.';

  @override
  String get paywallMonthShortOct => 'oct.';

  @override
  String get paywallMonthShortNov => 'nov.';

  @override
  String get paywallMonthShortDec => 'déc.';

  @override
  String get tasteTraitBody => 'Corps';

  @override
  String get tasteTraitTannin => 'Tanin';

  @override
  String get tasteTraitAcidity => 'Acidité';

  @override
  String get tasteTraitSweetness => 'Sucrosité';

  @override
  String get tasteTraitOak => 'Boisé';

  @override
  String get tasteTraitIntensity => 'Intensité';

  @override
  String get tasteTraitSweetShort => 'Sucré';

  @override
  String get tasteTraitBodyLow => 'Léger, facile à boire';

  @override
  String get tasteTraitBodyMid => 'Équilibré';

  @override
  String get tasteTraitBodyHigh => 'Puissant, charpenté';

  @override
  String get tasteTraitTanninLow => 'Souple, peu d\'accroche';

  @override
  String get tasteTraitTanninMid => 'Accroche moyenne';

  @override
  String get tasteTraitTanninHigh => 'Tannique, structuré';

  @override
  String get tasteTraitAcidityLow => 'Souple, rond';

  @override
  String get tasteTraitAcidityMid => 'Équilibré';

  @override
  String get tasteTraitAcidityHigh => 'Vif, éclatant';

  @override
  String get tasteTraitSweetnessLow => 'Très sec';

  @override
  String get tasteTraitSweetnessMid => 'Demi-sec';

  @override
  String get tasteTraitSweetnessHigh => 'Tendance sucré';

  @override
  String get tasteTraitOakLow => 'Sans bois, frais';

  @override
  String get tasteTraitOakMid => 'Touche de bois';

  @override
  String get tasteTraitOakHigh => 'Très boisé';

  @override
  String get tasteTraitIntensityLow => 'Aromatique discrète';

  @override
  String get tasteTraitIntensityMid => 'Expressif';

  @override
  String get tasteTraitIntensityHigh => 'Intense, aromatique';

  @override
  String tasteDnaBodyLowPct(int pct) {
    return 'Tu préfères les vins légers · $pct%';
  }

  @override
  String tasteDnaBodyMidPct(int pct) {
    return 'Corps équilibré · $pct%';
  }

  @override
  String tasteDnaBodyHighPct(int pct) {
    return 'Tu préfères les vins charpentés · $pct%';
  }

  @override
  String tasteDnaTanninLowPct(int pct) {
    return 'Tanins souples · $pct%';
  }

  @override
  String tasteDnaTanninMidPct(int pct) {
    return 'Tanin moyen · $pct%';
  }

  @override
  String tasteDnaTanninHighPct(int pct) {
    return 'Tanins puissants et accrocheurs · $pct%';
  }

  @override
  String tasteDnaAcidityLowPct(int pct) {
    return 'Acidité souple · $pct%';
  }

  @override
  String tasteDnaAcidityMidPct(int pct) {
    return 'Acidité équilibrée · $pct%';
  }

  @override
  String tasteDnaAcidityHighPct(int pct) {
    return 'Amateur d\'acidité · $pct%';
  }

  @override
  String tasteDnaSweetnessLowPct(int pct) {
    return 'Très sec · $pct%';
  }

  @override
  String tasteDnaSweetnessMidPct(int pct) {
    return 'Tendance demi-sec · $pct%';
  }

  @override
  String tasteDnaSweetnessHighPct(int pct) {
    return 'Tendance sucré · $pct%';
  }

  @override
  String tasteDnaOakLowPct(int pct) {
    return 'Sans bois / frais · $pct%';
  }

  @override
  String tasteDnaOakMidPct(int pct) {
    return 'Un peu de bois · $pct%';
  }

  @override
  String tasteDnaOakHighPct(int pct) {
    return 'Amateur de boisé · $pct%';
  }

  @override
  String tasteDnaIntensityLowPct(int pct) {
    return 'Aromatique discrète · $pct%';
  }

  @override
  String tasteDnaIntensityMidPct(int pct) {
    return 'Expressif · $pct%';
  }

  @override
  String tasteDnaIntensityHighPct(int pct) {
    return 'Aromatique intense · $pct%';
  }

  @override
  String get tasteDnaNotEnoughYet =>
      'Pas encore assez de vins notés — continue';

  @override
  String get tasteArchetypeBoldRedHunter => 'Chasseur de Rouges Puissants';

  @override
  String get tasteArchetypeBoldRedHunterTagline =>
      'Les rouges charpentés et tanniques sont ton terrain.';

  @override
  String get tasteArchetypeElegantBurgundian => 'Bourguignon Élégant';

  @override
  String get tasteArchetypeElegantBurgundianTagline =>
      'Des rouges plus légers à l\'acidité vive guident ton palais.';

  @override
  String get tasteArchetypeAromaticWhiteLover =>
      'Amateur de Blancs Aromatiques';

  @override
  String get tasteArchetypeAromaticWhiteLoverTagline =>
      'Des blancs frais et expressifs à l\'acidité tranchante.';

  @override
  String get tasteArchetypeSparklingSociable => 'Bulles en Bonne Compagnie';

  @override
  String get tasteArchetypeSparklingSociableTagline =>
      'Bulles et vins pâles dominent ta collection.';

  @override
  String get tasteArchetypeClassicStructure => 'Structure Classique';

  @override
  String get tasteArchetypeClassicStructureTagline =>
      'Des vins mesurés, faits pour la table, à l\'acidité vive.';

  @override
  String get tasteArchetypeSunRipenedBold => 'Mûri au Soleil';

  @override
  String get tasteArchetypeSunRipenedBoldTagline =>
      'Fruit généreux et boisé de vignobles ensoleillés.';

  @override
  String get tasteArchetypeDessertOffDry => 'Dessert / Demi-Sec';

  @override
  String get tasteArchetypeDessertOffDryTagline =>
      'Tu aimes les bouteilles avec une pointe de sucre.';

  @override
  String get tasteArchetypeNaturalLowIntervention =>
      'Nature / Faible Intervention';

  @override
  String get tasteArchetypeNaturalLowInterventionTagline =>
      'Sans bois, plus légers — le camp de la fraîcheur.';

  @override
  String get tasteArchetypeCrispMineralFan => 'Fan du Minéral';

  @override
  String get tasteArchetypeCrispMineralFanTagline =>
      'Styles tendus, minéraux et à forte acidité — ta signature.';

  @override
  String get tasteArchetypeEclecticExplorer => 'Explorateur Éclectique';

  @override
  String get tasteArchetypeEclecticExplorerTagline =>
      'Palais large — tu goûtes à travers toute la carte du vin.';

  @override
  String get tasteArchetypeCuriousNewcomer => 'Nouveau Venu Curieux';

  @override
  String get tasteArchetypeCuriousNewcomerTagline =>
      'Note quelques vins de plus et ta personnalité se révélera.';

  @override
  String get tasteCompassModeStyle => 'Style';

  @override
  String get tasteCompassModeWorld => 'Monde';

  @override
  String get tasteCompassModeGrapes => 'Cépages';

  @override
  String get tasteCompassModeDna => 'ADN';

  @override
  String get tasteCompassMetricCount => 'nombre';

  @override
  String get tasteCompassMetricRating => 'note';

  @override
  String get tasteCompassContinentEurope => 'Europe';

  @override
  String get tasteCompassContinentNorthAmerica => 'Amérique du Nord';

  @override
  String get tasteCompassContinentSouthAmerica => 'Amérique du Sud';

  @override
  String get tasteCompassContinentAfrica => 'Afrique';

  @override
  String get tasteCompassContinentAsia => 'Asie';

  @override
  String get tasteCompassContinentOceania => 'Océanie';

  @override
  String tasteCompassStyleNoneYet(String label) {
    return 'Pas encore de vins $label';
  }

  @override
  String tasteCompassStyleSummaryOne(int count, String label, String avg) {
    return '$count vin $label · $avg★ moy.';
  }

  @override
  String tasteCompassStyleSummaryMany(int count, String label, String avg) {
    return '$count vins $label · $avg★ moy.';
  }

  @override
  String tasteCompassWorldNoneYet(String label) {
    return 'Pas encore de bouteilles de $label';
  }

  @override
  String tasteCompassWorldSummaryOne(String label, String avg) {
    return '1 bouteille de $label · $avg★ moy.';
  }

  @override
  String tasteCompassWorldSummaryMany(int count, String label, String avg) {
    return '$count bouteilles de $label · $avg★ moy.';
  }

  @override
  String get tasteCompassGrapeEmptySlot =>
      'Emplacement libre — note plus de cépages';

  @override
  String tasteCompassGrapeSummaryOne(String name, String avg) {
    return '$name · 1 bouteille · $avg★ moy.';
  }

  @override
  String tasteCompassGrapeSummaryMany(String name, int count, String avg) {
    return '$name · $count bouteilles · $avg★ moy.';
  }

  @override
  String get tasteCompassTitleDefault => 'Boussole du goût';

  @override
  String get tasteCompassEmptyPromptOne =>
      'Note 1 vin de plus pour débloquer la boussole.';

  @override
  String tasteCompassEmptyPromptMany(int count) {
    return 'Note $count vins de plus pour débloquer la boussole.';
  }

  @override
  String get tasteCompassNotEnoughData =>
      'Pas encore assez de données pour ce mode.';

  @override
  String get tasteCompassDnaNeedsGrapes =>
      'L\'ADN a besoin de quelques vins dont on reconnaît le cépage. Choisis un cépage canonique sur tes vins pour débloquer cette vue.';

  @override
  String get tasteCompassEyebrowPersonality => 'TA PERSONNALITÉ VIN';

  @override
  String get tasteCompassTentativeHint =>
      'Provisoire — note plus de vins pour affiner';

  @override
  String get tasteCompassTopRegions => 'Régions top';

  @override
  String get tasteCompassTopCountries => 'Pays top';

  @override
  String get tasteCompassFooterWinesOne => '1 vin';

  @override
  String tasteCompassFooterWinesMany(int count) {
    return '$count vins';
  }

  @override
  String tasteCompassFooterAvg(String avg) {
    return '$avg ★ moy.';
  }

  @override
  String get tasteHeroEyebrow => 'PERSONNALITÉ';

  @override
  String get tasteHeroPromptCuriousOne =>
      'Note 1 vin de plus pour révéler ta personnalité.';

  @override
  String tasteHeroPromptCuriousMany(int count) {
    return 'Note $count vins de plus pour révéler ta personnalité.';
  }

  @override
  String get tasteHeroAlmostThere => 'Presque';

  @override
  String get tasteHeroPromptThinDnaOne =>
      'Tague un cépage canonique sur 1 vin de plus pour débloquer ton archétype.';

  @override
  String tasteHeroPromptThinDnaMany(int count) {
    return 'Tague un cépage canonique sur $count vins de plus pour débloquer ton archétype.';
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
  String get tasteHeroWinesOne => '1 vin';

  @override
  String tasteHeroWinesMany(int count) {
    return '$count vins';
  }

  @override
  String tasteHeroAvg(String avg) {
    return '$avg★ moy.';
  }

  @override
  String get tasteHeroShare => 'Partager';

  @override
  String get tasteTraitsHeading => 'TRAITS';

  @override
  String get tasteTraitsProDivider => 'PRO';

  @override
  String get tasteTraitsUnlockAll => 'Débloque tous les traits avec Pro';

  @override
  String get tasteMatchLabel => 'match de goût';

  @override
  String get tasteMatchConfidenceStrong => 'Fort';

  @override
  String get tasteMatchConfidenceSolid => 'Solide';

  @override
  String get tasteMatchConfidenceEarly => 'Début';

  @override
  String tasteMatchSupportingOne(String dnaPart) {
    return 'Basé sur 1 zone partagée région/type$dnaPart.';
  }

  @override
  String tasteMatchSupportingMany(int overlap, String dnaPart) {
    return 'Basé sur $overlap zones partagées région/type$dnaPart.';
  }

  @override
  String get tasteMatchSupportingDnaPart => ' + recouvrement de style WSET';

  @override
  String get tasteMatchSignalStrong => 'Signal fort.';

  @override
  String get tasteMatchSignalSolid => 'Signal solide.';

  @override
  String get tasteMatchSignalEarly =>
      'Signal naissant — continue à noter pour l\'affiner.';

  @override
  String get tasteMatchBreakdownBucket => 'Affinité région et type';

  @override
  String get tasteMatchBreakdownDna => 'Affinité ADN de style';

  @override
  String get tasteMatchEmptyNotEnough =>
      'Pas encore assez de vins à comparer — note quelques bouteilles de plus pour débloquer le match.';

  @override
  String get tasteMatchEmptyNoOverlap =>
      'Vous n\'avez pas encore noté de vins des mêmes régions ou types. Le match grandit dès que vos goûts se rejoignent.';

  @override
  String tasteFriendUpsellTitle(String name) {
    return 'Découvre comment $name goûte';
  }

  @override
  String get tasteFriendUpsellBody =>
      'Compare vos palais, trouve les vins que vous aimez tous les deux et repère où vos goûts divergent.';

  @override
  String get tasteFriendUpsellPillMatch => 'Match de goût';

  @override
  String get tasteFriendUpsellPillShared => 'Bouteilles partagées';

  @override
  String get tasteFriendUpsellCta => 'Débloquer Sippd Pro';

  @override
  String get tasteFriendSharedHeading =>
      'VINS QUE VOUS AVEZ TOUS LES DEUX NOTÉS';

  @override
  String tasteFriendSharedMore(int count) {
    return '+ $count autres';
  }

  @override
  String get tasteFriendRatingYou => 'toi';

  @override
  String get tasteFriendRatingThem => 'lui/elle';

  @override
  String shareRatedOn(String date) {
    return 'NOTÉ · $date';
  }

  @override
  String get shareRatingDenominator => '/ 10';

  @override
  String shareFooterRateYours(String url) {
    return 'note les tiens sur $url';
  }

  @override
  String shareFooterFindYours(String url) {
    return 'trouve ton goût sur $url';
  }

  @override
  String shareFooterHostYours(String url) {
    return 'organise la tienne sur $url';
  }

  @override
  String shareFooterJoinAt(String url) {
    return 'rejoins sur $url';
  }

  @override
  String get shareCompassEyebrow => 'PERSONNALITÉ VIN';

  @override
  String get shareCompassWhatDefinesMe => 'CE QUI ME DÉFINIT';

  @override
  String get shareCompassSampleSizeOne => 'basé sur 1 vin';

  @override
  String shareCompassSampleSizeMany(int count) {
    return 'basé sur $count vins';
  }

  @override
  String shareCompassPhrase(String descriptor, String trait) {
    return '$trait $descriptor';
  }

  @override
  String shareCompassShareText(String archetype, String url) {
    return 'Ma personnalité vin : $archetype · trouve la tienne sur $url';
  }

  @override
  String get shareTastingEyebrow => 'DÉGUSTATION DE GROUPE';

  @override
  String get shareTastingTopWine => 'VIN TOP DE LA SOIRÉE';

  @override
  String get shareTastingLineup => 'PROGRAMME';

  @override
  String shareTastingMore(int count) {
    return '+ $count autres';
  }

  @override
  String get shareTastingAttendeesOne => '1 dégustateur';

  @override
  String shareTastingAttendeesMany(int count) {
    return '$count dégustateurs';
  }

  @override
  String shareTastingShareTextTop(String wine, String avg, String url) {
    return '$wine a remporté la soirée à $avg/10 · organisée sur Sippd · $url';
  }

  @override
  String shareTastingShareTextTitle(String title, String url) {
    return '$title · organisée sur Sippd · $url';
  }

  @override
  String shareRatingShareText(String wine, String rating, String url) {
    return 'Je viens de noter $wine $rating/10 sur Sippd · $url';
  }

  @override
  String get shareInviteEyebrow => 'UNE INVITATION';

  @override
  String get shareInviteHero => 'Dégustons\nensemble.';

  @override
  String get shareInviteSub => 'Note-le. Souviens-toi. Partage-le.';

  @override
  String get shareInviteWantsToTaste => 'veut déguster avec toi';

  @override
  String shareInviteFallbackText(String name, String url) {
    return '$name veut déguster avec toi sur Sippd · $url';
  }

  @override
  String shareInviteImageText(String url) {
    return 'Rejoins-moi sur Sippd 🍷  $url';
  }

  @override
  String get shareInviteSubject => 'Rejoins-moi sur Sippd';

  @override
  String get shareRatingPromptSavedBadge => 'VIN ENREGISTRÉ';

  @override
  String get shareRatingPromptTitle => 'Ta carte est prête';

  @override
  String get shareRatingPromptBody =>
      'Envoie-la à des amis ou poste-la dans ta story.';

  @override
  String get shareRatingPromptCta => 'Partager la carte';

  @override
  String get shareRatingPromptPreparing => 'Préparation…';

  @override
  String get shareRatingPromptDismiss => 'Pas maintenant';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonGotIt => 'Compris';

  @override
  String get commonOptional => '(facultatif)';

  @override
  String get commonOffline => 'Hors ligne';

  @override
  String get commonOfflineMessage =>
      'Tu es hors ligne. Reconnecte-toi et réessaie.';

  @override
  String get commonNetworkErrorMessage =>
      'Erreur réseau. Vérifie ta connexion.';

  @override
  String get commonSomethingWentWrong => 'Quelque chose a cloché.';

  @override
  String get commonErrorViewOfflineTitle => 'Tu es hors ligne';

  @override
  String get commonErrorViewOfflineSubtitle =>
      'Reconnecte-toi pour charger ça.';

  @override
  String get commonErrorViewGenericTitle => 'Chargement impossible';

  @override
  String get commonErrorViewGenericSubtitle =>
      'Tire pour réessayer ou retente plus tard.';

  @override
  String get commonInlineCouldntSaveRetry =>
      'Échec d\'enregistrement · Réessayer';

  @override
  String get commonInlineOfflineRetry => 'Hors ligne · Réessayer';

  @override
  String get commonPhotoDialogCameraTitle => 'Accès caméra désactivé';

  @override
  String get commonPhotoDialogCameraBody =>
      'Sippd a besoin de l\'accès caméra pour prendre des photos de vins. Active-le dans Réglages pour continuer.';

  @override
  String get commonPhotoDialogPhotosTitle => 'Accès photos désactivé';

  @override
  String get commonPhotoDialogPhotosBody =>
      'Sippd a besoin de l\'accès à tes photos pour joindre des images. Active-le dans Réglages pour continuer.';

  @override
  String get commonPhotoErrorSnack =>
      'Impossible de charger la photo. Réessaie.';

  @override
  String get commonPriceSheetTitle => 'Prix de la bouteille';

  @override
  String get commonYearPickerTitle => 'Millésime';

  @override
  String get locSheetTitle => 'Où l\'as-tu bu ?';

  @override
  String get locSearchHint => 'Rechercher un lieu...';

  @override
  String get locNoResults => 'Aucun lieu trouvé';

  @override
  String get locSearchFailed => 'Échec de la recherche';

  @override
  String get locUseMyLocation => 'Utiliser ma position actuelle';

  @override
  String get locFindingLocation => 'Recherche de ta position…';

  @override
  String get locReadCurrentFailed => 'Impossible de lire la position actuelle';

  @override
  String get locServicesDisabled =>
      'Les services de localisation sont désactivés';

  @override
  String get locPermissionDenied => 'Autorisation de localisation refusée';

  @override
  String get profileEditTitle => 'Modifier le profil';

  @override
  String get profileEditSectionProfile => 'Profil';

  @override
  String get profileEditFieldUsername => 'Nom d\'utilisateur';

  @override
  String get profileEditFieldDisplayName => 'Nom affiché';

  @override
  String profileEditDisplayNameHintWithUsername(String username) {
    return 'p. ex. $username';
  }

  @override
  String get profileEditDisplayNameHintGeneric => 'Comment t\'appelle-t-on ?';

  @override
  String get profileEditDisplayNameHelper =>
      'Visible dans les groupes et dégustations. Laisse vide pour utiliser ton nom d\'utilisateur.';

  @override
  String get profileEditSectionTaste => 'Ton goût';

  @override
  String get profileEditSectionTasteSubtitle =>
      'Affine ce que Sippd apprend de toi. Modifiable à tout moment.';

  @override
  String get profileEditAvatarUpdateFailed =>
      'Impossible de mettre à jour la photo. Réessaie.';

  @override
  String get profileEditUploadFailed => 'Échec du téléversement.';

  @override
  String get profileEditSaveChangesFailed =>
      'Impossible d\'enregistrer les modifications. Réessaie.';

  @override
  String get profileAvatarTakePhoto => 'Prendre une photo';

  @override
  String get profileAvatarChooseGallery => 'Choisir dans la galerie';

  @override
  String get profileAvatarRemove => 'Supprimer la photo';

  @override
  String get profileUsernameTooShort => '3 caractères minimum';

  @override
  String get profileUsernameInvalid => 'Lettres, chiffres, . et _ uniquement';

  @override
  String get profileUsernameTaken => 'Déjà pris';

  @override
  String get profileUsernameAvailable => 'Disponible';

  @override
  String get profileUsernameChecking => 'Vérification…';

  @override
  String get profileUsernameHelperIdle =>
      '3–20 caractères · lettres, chiffres, . et _';

  @override
  String get profileChooseUsernameTitle => 'Choisis un nom d\'utilisateur';

  @override
  String get profileChooseUsernameSubtitle =>
      'C\'est comme ça que tes amis te trouvent sur Sippd.';

  @override
  String get profileChooseUsernameHint => 'utilisateur';

  @override
  String get profileChooseUsernameContinue => 'Continuer';

  @override
  String get profileChooseUsernameSaveFailed =>
      'Impossible d\'enregistrer le nom d\'utilisateur. Réessaie.';

  @override
  String get errNetworkDefault =>
      'Pas de connexion internet. Utilisation des données en cache.';

  @override
  String get errOffline => 'Tu es hors ligne. Reconnecte-toi pour réessayer.';

  @override
  String errDatabase(String msg) {
    return 'Erreur sur les données locales : $msg';
  }

  @override
  String errValidation(String field, String msg) {
    return '$field : $msg';
  }

  @override
  String errValidationNoField(String msg) {
    return '$msg';
  }

  @override
  String errNotFound(String resource) {
    return '$resource introuvable.';
  }

  @override
  String get errNotFoundDefault => 'Introuvable.';

  @override
  String get errUnauthorized => 'Connecte-toi pour continuer.';

  @override
  String errServer(int code) {
    return 'Erreur serveur ($code). Réessaie.';
  }

  @override
  String get errServerNoCode => 'Erreur serveur. Réessaie.';

  @override
  String get errUnknown => 'Quelque chose s\'est mal passé. Réessaie.';

  @override
  String routeNotFound(String uri) {
    return 'Page introuvable : $uri';
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get notificationsLoadError =>
      'Não foi possível carregar as definições de notificações';

  @override
  String get sectionTastings => 'Provas';

  @override
  String get sectionFriends => 'Amigos';

  @override
  String get sectionGroups => 'Grupos';

  @override
  String get tileTastingRemindersLabel => 'Lembretes de prova';

  @override
  String get tileTastingRemindersSubtitle => 'Aviso antes de começar uma prova';

  @override
  String get tileFriendActivityLabel => 'Atividade dos amigos';

  @override
  String get tileFriendActivitySubtitle => 'Pedidos e aceitações';

  @override
  String get tileGroupActivityLabel => 'Atividade do grupo';

  @override
  String get tileGroupActivitySubtitle => 'Convites, entradas e novas provas';

  @override
  String get tileGroupWineSharedLabel => 'Novo vinho partilhado';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Quando um amigo adiciona um vinho ao teu grupo';

  @override
  String get hoursPickerLabel => 'Avisar-me antes';

  @override
  String get hoursPickerHint =>
      'Aplica-se a todas as próximas provas — muda quando quiseres.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Idioma';

  @override
  String get languageSheetTitle => 'Escolher idioma';

  @override
  String get languageOptionSystem => 'Idioma do sistema';

  @override
  String get onbWelcomeTitle => 'Os teus momentos\nde vinho.';

  @override
  String get onbWelcomeBody =>
      'Avalia os vinhos que adoras. Lembra-te deles para sempre. Prova com os amigos.';

  @override
  String get onbWelcomeAlreadyHaveAccount => 'Já tens conta? ';

  @override
  String get onbWelcomeSignIn => 'Inicia sessão';

  @override
  String get onbWhyEyebrow => 'Porquê o Sippd';

  @override
  String get onbWhyTitle => 'Feito para quem\nbebe vinho a sério.';

  @override
  String get onbWhyPrinciple1Headline => 'Fotografa. Avalia. Lembra.';

  @override
  String get onbWhyPrinciple1Line => 'Três toques e encontras-lo para o ano.';

  @override
  String get onbWhyPrinciple2Headline => 'Provas com amigos.';

  @override
  String get onbWhyPrinciple2Line =>
      'Provas às cegas, notas em conjunto. Sem folhas de cálculo.';

  @override
  String get onbWhyPrinciple3Headline => 'Funciona offline.';

  @override
  String get onbWhyPrinciple3Line =>
      'Regista em qualquer lado. Sincroniza ao chegar a casa.';

  @override
  String get onbLevelEyebrow => 'Sobre ti';

  @override
  String get onbLevelTitle => 'Quão a fundo\nestás no vinho?';

  @override
  String get onbLevelSubtitle =>
      'Não há resposta errada. Ajustamos as sugestões ao teu ritmo.';

  @override
  String get onbLevelBeginnerLabel => 'Principiante';

  @override
  String get onbLevelBeginnerSubtitle => 'Mesmo a começar';

  @override
  String get onbLevelCuriousLabel => 'Curioso';

  @override
  String get onbLevelCuriousSubtitle => 'Uns quantos favoritos';

  @override
  String get onbLevelEnthusiastLabel => 'Entusiasta';

  @override
  String get onbLevelEnthusiastSubtitle => 'Sei o que gosto';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Nível sommelier';

  @override
  String get onbFreqEyebrow => 'O teu ritmo';

  @override
  String get onbFreqTitle => 'Com que frequência\nabres uma garrafa?';

  @override
  String get onbFreqWeekly => 'Toda a semana';

  @override
  String get onbFreqMonthly => 'Umas vezes por mês';

  @override
  String get onbFreqRare => 'De vez em quando';

  @override
  String get onbGoalsEyebrow => 'Os teus objetivos';

  @override
  String get onbGoalsTitle => 'O que procuras\nno Sippd?';

  @override
  String get onbGoalsSubtitle => 'Escolhe um ou mais. Podes mudar depois.';

  @override
  String get onbGoalRemember => 'Lembrar garrafas que adoro';

  @override
  String get onbGoalDiscover => 'Descobrir novos estilos';

  @override
  String get onbGoalSocial => 'Provar com amigos';

  @override
  String get onbGoalValue => 'Acompanhar o que pago';

  @override
  String get onbStylesEyebrow => 'Os teus estilos';

  @override
  String get onbStylesTitle => 'Para que costumas\npuxar?';

  @override
  String get onbStylesSubtitle =>
      'Escolhe os que te encaixam. Vamos ter as tuas escolhas em conta.';

  @override
  String get wineTypeRed => 'Tinto';

  @override
  String get wineTypeWhite => 'Branco';

  @override
  String get wineTypeRose => 'Rosé';

  @override
  String get wineTypeSparkling => 'Espumante';

  @override
  String get onbRespEyebrow => 'Uma nota nossa';

  @override
  String get onbRespTitle => 'Bebe menos,\nprova mais.';

  @override
  String get onbRespSubtitle =>
      'O Sippd serve para recordar e avaliar vinhos que apreciaste — não para te pressionar a beber mais. Não há sequências nem metas diárias. De propósito.';

  @override
  String get onbRespHelpBody =>
      'Se o álcool te está a prejudicar a ti ou a alguém próximo,\nhá ajuda gratuita e confidencial.';

  @override
  String get onbRespHelpCta => 'Procurar ajuda';

  @override
  String get onbNameEyebrow => 'Quase lá';

  @override
  String get onbNameTitle => 'Como\nte chamamos?';

  @override
  String get onbNameSubtitle =>
      'Nome, alcunha — o que preferires. Escolhe também um ícone.';

  @override
  String get onbNameHint => 'O teu nome';

  @override
  String get onbNameIconLabel => 'Escolhe o teu ícone';

  @override
  String get onbNameIconSubtitle => 'Aparece como o teu avatar.';

  @override
  String get onbNotifEyebrow => 'Fica a par';

  @override
  String get onbNotifTitle => 'Nunca mais percas\numa grande garrafa.';

  @override
  String get onbNotifSubtitle =>
      'Avisamos-te quando os amigos começarem provas ou te convidarem para grupos. Podes desligar quando quiseres.';

  @override
  String get onbNotifPreview =>
      'Convites para provas\nNotas de grupo\nAtividade dos amigos';

  @override
  String get onbNotifTurnOn => 'Ativar notificações';

  @override
  String get onbNotifNotNow => 'Agora não';

  @override
  String get onbLoaderAlmostThere => 'QUASE LÁ';

  @override
  String get onbLoaderCrafting => 'A criar o teu perfil.';

  @override
  String get onbLoaderAllSet => 'Tudo pronto.';

  @override
  String get onbLoaderStepMatching => 'A ajustar o teu gosto';

  @override
  String get onbLoaderStepCurating => 'A selecionar os teus estilos';

  @override
  String get onbLoaderStepSetting => 'A preparar o teu diário';

  @override
  String get onbLoaderSeeProfile => 'Ver o teu perfil';

  @override
  String get onbLoaderContinue => 'Continuar';

  @override
  String get onbResultsEyebrow => 'O TEU PERFIL DE GOSTO';

  @override
  String get onbResultsLevelCard => 'Nível';

  @override
  String get onbResultsFreqCard => 'Frequência';

  @override
  String get onbResultsStylesCard => 'Estilos';

  @override
  String get onbResultsGoalsCard => 'Objetivos';

  @override
  String get onbArchSommTitle => 'Sommelier experiente';

  @override
  String get onbArchSommSubtitle =>
      'Conheces o teu terroir. O Sippd guarda as provas.';

  @override
  String get onbArchPalateTitle => 'Palato apurado';

  @override
  String get onbArchPalateSubtitle =>
      'Caçador de nuances. O Sippd capta o detalhe.';

  @override
  String get onbArchRegularTitle => 'Habitué da adega';

  @override
  String get onbArchRegularSubtitle =>
      'Uma garrafa por semana, opiniões mais afiadas a cada mês.';

  @override
  String get onbArchDevotedTitle => 'Provador dedicado';

  @override
  String get onbArchDevotedSubtitle =>
      'A sério em cada copo. O Sippd guarda as tuas notas.';

  @override
  String get onbArchRedTitle => 'Fiel ao tinto';

  @override
  String get onbArchRedSubtitle =>
      'Uma casta por copo. Ajudamos-te a explorar.';

  @override
  String get onbArchBubbleTitle => 'Caçador de bolhas';

  @override
  String get onbArchBubbleSubtitle =>
      'Bolhas acima de tudo. O Sippd marca as boas.';

  @override
  String get onbArchOpenTitle => 'Palato aberto';

  @override
  String get onbArchOpenSubtitle =>
      'Tinto, branco, rosé, espumante — todos servem. Regista-os todos.';

  @override
  String get onbArchSteadyTitle => 'Provador constante';

  @override
  String get onbArchSteadySubtitle =>
      'O vinho continua na rotação. O Sippd segue o fio.';

  @override
  String get onbArchNowAndThenTitle => 'Provador ocasional';

  @override
  String get onbArchNowAndThenSubtitle =>
      'Vinho para os momentos que importam.';

  @override
  String get onbArchOccasionalTitle => 'Copo esporádico';

  @override
  String get onbArchOccasionalSubtitle => 'Copo raro, vale a pena recordar.';

  @override
  String get onbArchFreshTitle => 'Palato fresco';

  @override
  String get onbArchFreshSubtitle =>
      'Novo percurso. Cada garrafa conta a partir de agora.';

  @override
  String get onbArchCuriousTitle => 'Curioso do vinho';

  @override
  String get onbArchCuriousSubtitle =>
      'Conta-nos mais e o teu perfil afina-se.';

  @override
  String get onbCtaGetStarted => 'Começar';

  @override
  String get onbCtaIUnderstand => 'Compreendo';

  @override
  String get onbCtaContinue => 'Continuar';

  @override
  String get onbCtaSignInToSave => 'Inicia sessão para guardar';

  @override
  String get onbCtaSaveAndContinue => 'Guardar e continuar';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Nível';

  @override
  String get tasteEditorFreq => 'Com que frequência';

  @override
  String get tasteEditorStyles => 'Estilos favoritos';

  @override
  String get tasteEditorGoals => 'O que procuras';

  @override
  String get tasteEditorFreqWeekly => 'Semanal';

  @override
  String get tasteEditorFreqMonthly => 'Mensal';

  @override
  String get tasteEditorFreqRare => 'Raramente';

  @override
  String get tasteEditorGoalRemember => 'Recordar';

  @override
  String get tasteEditorGoalDiscover => 'Descobrir';

  @override
  String get tasteEditorGoalSocial => 'Social';

  @override
  String get tasteEditorGoalValue => 'Valor';

  @override
  String get authLoginWelcomeBack => 'Bem-vindo de volta';

  @override
  String get authLoginCreateAccount => 'Cria a tua conta';

  @override
  String get authLoginDisplayNameLabel => 'Nome a apresentar';

  @override
  String get authLoginEmailLabel => 'E-mail';

  @override
  String get authLoginPasswordLabel => 'Palavra-passe';

  @override
  String get authLoginConfirmPasswordLabel => 'Confirmar palavra-passe';

  @override
  String get authLoginDisplayNameMin => 'Mín. 2 caracteres';

  @override
  String get authLoginDisplayNameMax => 'Máx. 30 caracteres';

  @override
  String get authLoginEmailInvalid => 'É preciso um e-mail válido';

  @override
  String get authLoginPasswordMin => 'Mín. 8 caracteres';

  @override
  String get authLoginPasswordRequired => 'Introduz a palavra-passe';

  @override
  String get authLoginPasswordsDontMatch => 'As palavras-passe não coincidem';

  @override
  String get authLoginForgotPassword => 'Esqueceste-te da palavra-passe?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Introduz primeiro um e-mail válido acima.';

  @override
  String get authLoginSignUpFailedFallback =>
      'Não foi possível criar a conta. Tenta novamente.';

  @override
  String get authLoginSignInFailedFallback =>
      'Falha ao iniciar sessão. Verifica os teus dados.';

  @override
  String get authLoginEmailAlreadyRegistered =>
      'Este e-mail já está registado. Inicia sessão.';

  @override
  String get authLoginCreateAccountButton => 'Criar conta';

  @override
  String get authLoginSignInButton => 'Iniciar sessão';

  @override
  String get authLoginToggleHaveAccount => 'Já tens conta? Inicia sessão';

  @override
  String get authLoginToggleNoAccount => 'Não tens conta? Regista-te';

  @override
  String get authOrDivider => 'ou';

  @override
  String get authGoogleContinue => 'Continuar com Google';

  @override
  String get authGoogleFailed =>
      'Falha ao iniciar sessão com o Google. Tenta novamente.';

  @override
  String get authAppleContinue => 'Continuar com a Apple';

  @override
  String get authAppleFailed =>
      'Falha ao iniciar sessão com a Apple. Tenta novamente.';

  @override
  String get authConfTitleReset => 'Link enviado';

  @override
  String get authConfTitleSignup => 'Vê a tua caixa de entrada';

  @override
  String get authConfIntroReset =>
      'Enviámos um link de redefinição de palavra-passe para';

  @override
  String get authConfIntroSignup => 'Enviámos um link de confirmação para';

  @override
  String get authConfOutroReset =>
      '.\nToca-lhe para definir uma nova palavra-passe.';

  @override
  String get authConfOutroSignup => '.\nToca-lhe para ativar a tua conta.';

  @override
  String get authConfOpenMailApp => 'Abrir app de e-mail';

  @override
  String get authConfNoMailApps => 'No mail app found on this device';

  @override
  String get authConfResendEmail => 'Reenviar e-mail';

  @override
  String get authConfResendSending => 'A enviar…';

  @override
  String authConfResendIn(int seconds) {
    return 'Reenviar em ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'E-mail enviado.';

  @override
  String get authConfResendFailedFallback =>
      'Não foi possível enviar. Tenta daqui a um momento.';

  @override
  String get authConfBackToSignIn => 'Voltar ao início de sessão';

  @override
  String get authResetTitle => 'Define uma nova palavra-passe';

  @override
  String get authResetSubtitle =>
      'Escolhe uma palavra-passe que ainda não tenhas usado.';

  @override
  String get authResetNewPasswordLabel => 'Nova palavra-passe';

  @override
  String get authResetConfirmPasswordLabel => 'Confirmar palavra-passe';

  @override
  String get authResetPasswordMin => 'Mín. 6 caracteres';

  @override
  String get authResetPasswordsDontMatch => 'As palavras-passe não coincidem';

  @override
  String get authResetFailedFallback =>
      'Não foi possível atualizar a palavra-passe. Tenta novamente.';

  @override
  String get authResetUpdateButton => 'Atualizar palavra-passe';

  @override
  String get authResetUpdatedSnack => 'Palavra-passe atualizada.';

  @override
  String get authProfileGuest => 'Convidado';

  @override
  String get authProfileSectionAccount => 'Conta';

  @override
  String get authProfileSectionSupport => 'Apoio';

  @override
  String get authProfileSectionLegal => 'Legal';

  @override
  String get authProfileEditProfile => 'Editar perfil';

  @override
  String get authProfileFriends => 'Amigos';

  @override
  String get authProfileNotifications => 'Notificações';

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
  String get authProfileCleanupDuplicates => 'Limpar duplicados';

  @override
  String get authProfileSubscription => 'Subscrição';

  @override
  String get authProfileChangePassword => 'Mudar palavra-passe';

  @override
  String get authProfileContactUs => 'Contacta-nos';

  @override
  String get authProfileRateSippd => 'Avaliar o Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Política de privacidade';

  @override
  String get authProfileTermsOfService => 'Termos de serviço';

  @override
  String get authProfileSignOut => 'Terminar sessão';

  @override
  String get authProfileSignIn => 'Iniciar sessão';

  @override
  String get authProfileDeleteAccount => 'Eliminar conta';

  @override
  String get authProfileViewFullStats => 'Ver todas as estatísticas';

  @override
  String get authProfileChangePasswordDialogTitle => 'Mudar palavra-passe?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'Vamos enviar um link de redefinição de palavra-passe para $email. Toca-lhe na tua caixa de entrada para definir uma nova palavra-passe.';
  }

  @override
  String get authProfileCancel => 'Cancelar';

  @override
  String get authProfileSendLink => 'Enviar link';

  @override
  String get authProfileSendLinkFailedTitle => 'Não foi possível enviar o link';

  @override
  String get authProfileSendLinkFailedFallback => 'Tenta daqui a um momento.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'Não foi possível abrir $url';
  }

  @override
  String get authProfileDeleteDialogTitle => 'Eliminar conta?';

  @override
  String get authProfileDeleteDialogBody =>
      'Isto elimina permanentemente o teu perfil, vinhos, avaliações, provas, grupos e amigos. Não pode ser anulado.';

  @override
  String get authProfileDeleteTypeConfirm => 'Escreve DELETE para confirmar:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Eliminar';

  @override
  String get authProfileDeleteFailedFallback => 'Falha ao eliminar.';

  @override
  String get winesListSubtitle => 'O teu ranking de vinhos';

  @override
  String get winesListSortRating => 'Ordenar: nota';

  @override
  String get winesListSortRecent => 'Ordenar: recente';

  @override
  String get winesListSortName => 'Ordenar: nome';

  @override
  String get winesListTooltipStats => 'As tuas estatísticas';

  @override
  String get winesListTooltipAddWine => 'Adicionar vinho';

  @override
  String get winesListTooltipCompare => 'Comparar vinhos';

  @override
  String get winesListDeleteDone => 'Concluído';

  @override
  String get winesListErrorLoad => 'Não foi possível carregar os vinhos';

  @override
  String get winesEmptyTitle => 'Ainda não há vinhos';

  @override
  String get winesEmptyFilteredTitle => 'Nenhum vinho corresponde ao filtro';

  @override
  String get winesEmptyFilteredBody => 'Experimenta outro filtro';

  @override
  String get winesEmptyAddWineCta => 'Adicionar vinho';

  @override
  String get winesAddSaveLabel => 'Guardar vinho';

  @override
  String get winesAddDiscardTitle => 'Descartar o novo vinho?';

  @override
  String get winesAddDiscardBody =>
      'Ainda não guardaste este vinho. Se saíres agora, vais perder as alterações.';

  @override
  String get winesAddDiscardKeepEditing => 'Continuar a editar';

  @override
  String get winesAddDiscardConfirm => 'Descartar';

  @override
  String get winesAddDuplicateTitle => 'Parece um duplicado';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Já registaste «$name» com a mesma colheita, produtor e casta. Queres abrir o registo existente ou adicionar um novo na mesma?';
  }

  @override
  String get winesAddDuplicateCancel => 'Cancelar';

  @override
  String get winesAddDuplicateAddAnyway => 'Adicionar na mesma';

  @override
  String get winesAddDuplicateOpenExisting => 'Abrir existente';

  @override
  String get winesDetailNotFound => 'Vinho não encontrado';

  @override
  String get winesDetailErrorLoad => 'Não foi possível carregar o vinho';

  @override
  String get winesDetailMenuCompare => 'Comparar com…';

  @override
  String get winesDetailMenuShareRating => 'Partilhar nota';

  @override
  String get winesDetailMenuShareToGroup => 'Partilhar com o grupo';

  @override
  String get winesDetailMenuEdit => 'Editar vinho';

  @override
  String get winesDetailMenuTastingNotesPro => 'Notas de prova (Pro)';

  @override
  String get winesDetailMenuDelete => 'Eliminar vinho';

  @override
  String get winesDetailStatRating => 'Nota';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Preço';

  @override
  String get winesDetailStatRegion => 'Região';

  @override
  String get winesDetailStatCountry => 'País';

  @override
  String get winesDetailSectionNotes => 'NOTAS';

  @override
  String get winesDetailSectionPlace => 'LOCAIS';

  @override
  String get winesDetailPlaceEmpty => 'Sem local definido';

  @override
  String get winesDetailDeleteTitle => 'Eliminar vinho?';

  @override
  String get winesDetailDeleteBody => 'Isto não pode ser anulado.';

  @override
  String get winesDetailDeleteCancel => 'Cancelar';

  @override
  String get winesDetailDeleteConfirm => 'Eliminar';

  @override
  String get winesEditErrorLoad => 'Não foi possível carregar o vinho';

  @override
  String get winesEditErrorMemories => 'Não foi possível carregar os momentos';

  @override
  String get winesEditNotFound => 'Vinho não encontrado';

  @override
  String get winesCleanupTitle => 'Limpar duplicados';

  @override
  String get winesCleanupErrorLoad => 'Não foi possível carregar os duplicados';

  @override
  String get winesCleanupEmptyTitle => 'Não há duplicados para limpar';

  @override
  String get winesCleanupEmptyBody =>
      'Os teus vinhos estão arrumados. Detetamos nomes e produtores quase iguais automaticamente.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% de correspondência';
  }

  @override
  String get winesCleanupKeepA => 'Ficar com A';

  @override
  String get winesCleanupKeepB => 'Ficar com B';

  @override
  String get winesCleanupSkippedSnack =>
      'Ignorado por agora — volta a aparecer na próxima visita.';

  @override
  String get winesCleanupDifferentWines => 'São vinhos diferentes';

  @override
  String winesCleanupMergeTitle(String name) {
    return 'Juntar em «$name»?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Todas as notas, partilhas em grupo e estatísticas que apontavam para «$loser» passam para «$keeper». Não pode ser anulado.';
  }

  @override
  String get winesCleanupMergeCancel => 'Cancelar';

  @override
  String get winesCleanupMergeConfirm => 'Juntar';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Juntado em «$name».';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Falha ao juntar.';

  @override
  String get winesCompareHeader => 'COMPARAR';

  @override
  String get winesComparePickerSubtitle => 'Escolhe o segundo vinho.';

  @override
  String get winesComparePickerFirstSubtitle => 'Escolhe o primeiro vinho.';

  @override
  String get winesComparePickerEmptyTitle => 'Ainda não há outros vinhos';

  @override
  String get winesComparePickerEmptyBody =>
      'Adiciona pelo menos mais um vinho para comparar.';

  @override
  String get winesComparePickerErrorFallback =>
      'Não foi possível carregar os vinhos.';

  @override
  String get winesCompareMissingSameWine =>
      'Escolhe um vinho diferente para comparar.';

  @override
  String get winesCompareMissingDefault =>
      'Não foi possível carregar ambos os vinhos.';

  @override
  String get winesCompareErrorFallback =>
      'Não foi possível carregar os vinhos.';

  @override
  String get winesCompareSectionAtAGlance => 'Num relance';

  @override
  String get winesCompareSectionTasting => 'Perfil de prova';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Corpo, tanino, acidez, doçura, madeira, final.';

  @override
  String get winesCompareSectionNotes => 'Notas';

  @override
  String get winesCompareAttrType => 'TIPO';

  @override
  String get winesCompareAttrVintage => 'COLHEITA';

  @override
  String get winesCompareAttrGrape => 'CASTA';

  @override
  String get winesCompareAttrOrigin => 'ORIGEM';

  @override
  String get winesCompareAttrPrice => 'PREÇO';

  @override
  String get winesCompareNotesEyebrow => 'NOTAS';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'VINHO $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Vê corpo, tanino, acidez e mais, lado a lado.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Desbloquear com Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Adiciona notas de prova a um dos vinhos para as veres comparadas aqui.';

  @override
  String get winesFormHintName => 'Nome do vinho';

  @override
  String get winesFormSubmitDefault => 'Guardar vinho';

  @override
  String get winesFormPhotoLabel => 'Foto';

  @override
  String get winesFormPlaceSectionHeader => 'Primeiro Sipp';

  @override
  String get winesFormStatRating => 'Nota';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Preço';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Região';

  @override
  String get winesFormStatCountry => 'País';

  @override
  String get winesFormChipWinery => 'Produtor';

  @override
  String get winesFormChipGrape => 'Casta';

  @override
  String get winesFormChipYear => 'Ano';

  @override
  String get winesFormChipNotes => 'Notas';

  @override
  String get winesFormChipNotesFilled => 'Notas ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Onde o bebeste?';

  @override
  String get winesFormWineryTitle => 'Produtor';

  @override
  String get winesFormWineryHint => 'p. ex. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Notas de prova';

  @override
  String get winesFormNotesHint => 'Aromas, corpo, final…';

  @override
  String get winesFormTypeRed => 'Tinto';

  @override
  String get winesFormTypeWhite => 'Branco';

  @override
  String get winesFormTypeRose => 'Rosé';

  @override
  String get winesFormTypeSparkling => 'Espumante';

  @override
  String get winesMemoriesHeader => 'Momentos';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Momentos ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Adicionar';

  @override
  String get winesMemoriesRemoveTitle => 'Remover momento?';

  @override
  String get winesMemoriesRemoveBody =>
      'Isto vai remover este momento do vinho.';

  @override
  String get winesMemoriesRemoveCancel => 'Cancelar';

  @override
  String get winesMemoriesRemoveConfirm => 'Remover';

  @override
  String get momentSheetNewTitle => 'Novo momento';

  @override
  String get momentSheetEditTitle => 'Editar momento';

  @override
  String get momentFieldPhotos => 'Fotos';

  @override
  String get momentFieldWhen => 'Quando';

  @override
  String get momentFieldOccasion => 'Ocasião';

  @override
  String get momentFieldCompanions => 'Com';

  @override
  String get momentFieldPlace => 'Onde';

  @override
  String get momentFieldFood => 'Harmonizado com';

  @override
  String get momentFieldNote => 'Nota';

  @override
  String get momentFieldVisibility => 'Visibilidade';

  @override
  String get momentAddPhoto => 'Adicionar foto';

  @override
  String get momentPhotoCap => 'Até 10 fotos';

  @override
  String get momentOccasionDinner => 'Jantar';

  @override
  String get momentOccasionDate => 'Encontro';

  @override
  String get momentOccasionCelebration => 'Celebração';

  @override
  String get momentOccasionTasting => 'Prova';

  @override
  String get momentOccasionCasual => 'Casual';

  @override
  String get momentOccasionBirthday => 'Aniversário';

  @override
  String get momentCompanionsAddFriend => 'Adicionar amigo';

  @override
  String get momentCompanionsEmpty => 'Ainda não há amigos para etiquetar.';

  @override
  String get friendsProfileSharedMoments => 'Momentos partilhados';

  @override
  String get winesShareToFriend => 'Partilhar com amigo';

  @override
  String winesShareSuccess(String name) {
    return 'Vinho partilhado com $name';
  }

  @override
  String get winesShareError => 'Não foi possível partilhar — tenta novamente';

  @override
  String get winesSharePickFriendsTitle => 'Partilhar com';

  @override
  String get winesExpertProUnlock => 'Desbloquear com Pro';

  @override
  String get momentShowcaseApplied => 'Definida como foto principal do vinho.';

  @override
  String get momentShowcaseError =>
      'Não foi possível definir como foto principal. Tenta novamente.';

  @override
  String get momentPlaceHint => 'Restaurante ou local';

  @override
  String get momentFoodHint => 'Com que o harmonizaste?';

  @override
  String get momentNoteHint => 'Algo para recordar?';

  @override
  String get momentVisibilityFriends => 'Amigos';

  @override
  String get momentVisibilityPrivate => 'Privado';

  @override
  String get momentSave => 'Guardar momento';

  @override
  String get momentSaveError => 'Não foi possível guardar o momento';

  @override
  String get momentEdit => 'Editar';

  @override
  String get momentDelete => 'Eliminar';

  @override
  String get momentDeleteConfirmTitle => 'Eliminar momento?';

  @override
  String get momentDeleteConfirmBody =>
      'Isto remove permanentemente este momento e as suas fotos.';

  @override
  String get momentUseAsShowcase => 'Usar como capa';

  @override
  String get momentTastingAdd => 'Adicionar momento de prova';

  @override
  String get momentValidationEmpty => 'Adiciona uma foto ou nota para guardar';

  @override
  String get momentSectionHeader => 'Momentos';

  @override
  String get momentSectionAdd => 'Novo';

  @override
  String get momentSectionEmpty => 'Ainda não há momentos — toca em +.';

  @override
  String momentMetaWith(String names) {
    return 'Com $names';
  }

  @override
  String get winesPhotoSourceTake => 'Tirar foto';

  @override
  String get winesPhotoSourceGallery => 'Escolher da galeria';

  @override
  String get winesGrapeSheetTitle => 'Casta';

  @override
  String get winesGrapeSheetHint => 'p. ex. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Usar «';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '» como personalizada';

  @override
  String get winesGrapeSheetEmpty => 'Ainda não há castas disponíveis.';

  @override
  String get winesGrapeSheetErrorLoad =>
      'Não foi possível carregar o catálogo de castas.';

  @override
  String get winesGrapeSheetUseTyped => 'Usar o que escrevi';

  @override
  String get winesRegionSheetTitle => 'Região vinícola';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Escolhe de que parte de $country é o vinho — ou salta se não tiveres a certeza.';
  }

  @override
  String get winesRegionSheetSkip => 'Saltar';

  @override
  String get winesRegionSheetSearchHint => 'Procurar região...';

  @override
  String get winesRegionSheetClear => 'Limpar região';

  @override
  String get winesRegionSheetOther => 'Outra região…';

  @override
  String get winesRegionSheetOtherTitle => 'Região';

  @override
  String get winesRegionSheetOtherHint => 'p. ex. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Procurar país...';

  @override
  String get winesCountrySheetTopHeader => 'Principais países vinícolas';

  @override
  String get winesCountrySheetOtherHeader => 'Outros países';

  @override
  String get winesRatingSheetSaveCta => 'Guardar nota';

  @override
  String get winesRatingSheetCancel => 'Cancelar';

  @override
  String get winesRatingSheetSaveError => 'Não foi possível guardar.';

  @override
  String get winesRatingHeaderLabel => 'A TUA NOTA';

  @override
  String get winesRatingChipTasting => 'Notas de prova';

  @override
  String get winesRatingInputLabel => 'Nota';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Guarda primeiro o vinho — as notas de prova ligam-se ao id canónico.';

  @override
  String get winesExpertSheetTitle => 'Notas de prova';

  @override
  String get winesExpertSheetSubtitle => 'Perceções ao estilo WSET';

  @override
  String get winesExpertSheetSave => 'Guardar';

  @override
  String get winesExpertAxisBody => 'Corpo';

  @override
  String get winesExpertAxisTannin => 'Tanino';

  @override
  String get winesExpertAxisAcidity => 'Acidez';

  @override
  String get winesExpertAxisSweetness => 'Doçura';

  @override
  String get winesExpertAxisOak => 'Madeira';

  @override
  String get winesExpertAxisFinish => 'Final';

  @override
  String get winesExpertAxisAromas => 'Aromas';

  @override
  String get winesExpertBodyLow => 'leve';

  @override
  String get winesExpertBodyHigh => 'encorpado';

  @override
  String get winesExpertTanninLow => 'suave';

  @override
  String get winesExpertTanninHigh => 'firme';

  @override
  String get winesExpertAcidityLow => 'suave';

  @override
  String get winesExpertAcidityHigh => 'fresca';

  @override
  String get winesExpertSweetnessLow => 'seco';

  @override
  String get winesExpertSweetnessHigh => 'doce';

  @override
  String get winesExpertOakLow => 'sem madeira';

  @override
  String get winesExpertOakHigh => 'intensa';

  @override
  String get winesExpertFinishShort => 'Curto';

  @override
  String get winesExpertFinishMedium => 'Médio';

  @override
  String get winesExpertFinishLong => 'Longo';

  @override
  String get winesExpertSummaryHeader => 'NOTAS DE PROVA';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMAS';

  @override
  String get winesExpertSummaryAxisBody => 'CORPO';

  @override
  String get winesExpertSummaryAxisTannin => 'TANINO';

  @override
  String get winesExpertSummaryAxisAcidity => 'ACIDEZ';

  @override
  String get winesExpertSummaryAxisSweetness => 'DOÇURA';

  @override
  String get winesExpertSummaryAxisOak => 'MADEIRA';

  @override
  String get winesExpertSummaryAxisFinish => 'FINAL';

  @override
  String get winesExpertDescriptorBody1 => 'muito leve';

  @override
  String get winesExpertDescriptorBody2 => 'leve';

  @override
  String get winesExpertDescriptorBody3 => 'médio';

  @override
  String get winesExpertDescriptorBody4 => 'encorpado';

  @override
  String get winesExpertDescriptorBody5 => 'muito encorpado';

  @override
  String get winesExpertDescriptorTannin1 => 'sedoso';

  @override
  String get winesExpertDescriptorTannin2 => 'suave';

  @override
  String get winesExpertDescriptorTannin3 => 'médio';

  @override
  String get winesExpertDescriptorTannin4 => 'firme';

  @override
  String get winesExpertDescriptorTannin5 => 'marcado';

  @override
  String get winesExpertDescriptorAcidity1 => 'plano';

  @override
  String get winesExpertDescriptorAcidity2 => 'suave';

  @override
  String get winesExpertDescriptorAcidity3 => 'equilibrado';

  @override
  String get winesExpertDescriptorAcidity4 => 'fresco';

  @override
  String get winesExpertDescriptorAcidity5 => 'vibrante';

  @override
  String get winesExpertDescriptorSweetness1 => 'muito seco';

  @override
  String get winesExpertDescriptorSweetness2 => 'seco';

  @override
  String get winesExpertDescriptorSweetness3 => 'meio-seco';

  @override
  String get winesExpertDescriptorSweetness4 => 'doce';

  @override
  String get winesExpertDescriptorSweetness5 => 'muito doce';

  @override
  String get winesExpertDescriptorOak1 => 'sem madeira';

  @override
  String get winesExpertDescriptorOak2 => 'subtil';

  @override
  String get winesExpertDescriptorOak3 => 'presente';

  @override
  String get winesExpertDescriptorOak4 => 'muito presente';

  @override
  String get winesExpertDescriptorOak5 => 'intensa';

  @override
  String get winesExpertDescriptorFinish1 => 'curto';

  @override
  String get winesExpertDescriptorFinish2 => 'médio';

  @override
  String get winesExpertDescriptorFinish3 => 'longo';

  @override
  String get winesCanonicalPromptTitle => 'O mesmo vinho?';

  @override
  String get winesCanonicalPromptBody =>
      'Parece-se com um vinho que já está no catálogo. Ligá-los mantém as tuas estatísticas e correspondências certas.';

  @override
  String get winesCanonicalPromptInputLabel => 'O que estás a adicionar';

  @override
  String get winesCanonicalPromptExistingLabel => 'JÁ NO CATÁLOGO';

  @override
  String get winesCanonicalPromptDifferent => 'Não, este é um vinho diferente';

  @override
  String get winesFriendRatingsHeader => 'AMIGOS QUE AVALIARAM';

  @override
  String get winesFriendRatingsFallback => 'Amigo';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count mais';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Todos';

  @override
  String get winesTypeFilterRed => 'Tinto';

  @override
  String get winesTypeFilterWhite => 'Branco';

  @override
  String get winesTypeFilterRose => 'Rosé';

  @override
  String get winesTypeFilterSparkling => 'Espumante';

  @override
  String get winesStatsHeader => 'ESTATÍSTICAS';

  @override
  String get winesStatsSubtitle => 'A tua viagem no vinho, visualizada';

  @override
  String get winesStatsPreviewBadge => 'PRÉ-VISUALIZAÇÃO';

  @override
  String get winesStatsPreviewHint => 'O que vais ver após algumas notas.';

  @override
  String get winesStatsEmptyEyebrow => 'COMEÇAR';

  @override
  String get winesStatsEmptyTitle =>
      'As tuas estatísticas começam com uma nota';

  @override
  String get winesStatsEmptyBody =>
      'Avalia o teu primeiro vinho para dar vida aqui ao teu gosto, regiões e valor.';

  @override
  String get winesStatsEmptyCta => 'Avaliar um vinho';

  @override
  String get winesStatsHeroLabel => 'A TUA MÉDIA';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'pessoal';

  @override
  String get winesStatsHeroChipGroup => 'grupo';

  @override
  String get winesStatsHeroChipTasting => 'prova';

  @override
  String get winesStatsSectionTypeBreakdown => 'Distribuição por tipo';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Como o teu gosto se reparte pelos quatro estilos.';

  @override
  String get winesStatsSectionTopRated => 'Melhor avaliados';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'O teu pódio pessoal.';

  @override
  String get winesStatsSectionTimeline => 'Cronologia';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Mês a mês, os vinhos que escreveram o teu ano.';

  @override
  String get winesStatsSectionPartners => 'Parceiros de prova';

  @override
  String get winesStatsSectionPartnersSubtitle => 'Com quem provas mais.';

  @override
  String get winesStatsSectionPrices => 'Preços e valor';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Soma dos preços de garrafa registados nos teus vinhos avaliados — não o gasto real de consumo.';

  @override
  String get winesStatsSectionPlaces => 'Onde conheceste os teus vinhos';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Um pino por vinho, o teu primeiro Sipp.';

  @override
  String get winesStatsSectionRegions => 'Regiões de topo';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'De onde vem a maioria das tuas garrafas.';

  @override
  String get winesStatsPartnersErrorTitle =>
      'Não foi possível carregar os parceiros';

  @override
  String get winesStatsPartnersErrorBody =>
      'Puxa para atualizar ou volta daqui a um momento.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Provar em conjunto';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Quando tu e um amigo avaliarem o mesmo vinho num grupo, vão aparecer aqui.';

  @override
  String get winesStatsPartnersCta => 'Abrir grupos';

  @override
  String get winesStatsPriceEmptyTitle => 'Adiciona um preço';

  @override
  String get winesStatsPriceEmptyBody =>
      'Regista o que pagaste num vinho para desbloquear gasto, preço médio e melhores valores.';

  @override
  String get winesStatsPriceEmptyCta => 'Editar um vinho';

  @override
  String get winesStatsPlacesEmptyTitle => 'Adiciona uma localização';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Coloca um pino num vinho para começares a mapear onde bebes — bares, jantares, viagens.';

  @override
  String get winesStatsPlacesEmptyCta => 'Editar um vinho';

  @override
  String get winesStatsRegionsEmptyTitle => 'Adiciona uma região';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Etiqueta vinhos com região ou país para veres para onde o teu gosto pende.';

  @override
  String get winesStatsRegionsEmptyCta => 'Editar um vinho';

  @override
  String get winesStatsPartnersHint =>
      'Conta vinhos avaliados em conjunto em grupos partilhados.';

  @override
  String get winesStatsPartnersFallback => 'Companheiro de vinho';

  @override
  String get winesStatsSpendingLabel => 'PORTEFÓLIO AVALIADO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vinhos com preço',
      one: '1 vinho com preço',
    );
    return 'em $_temp0 · média $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Mais caro';

  @override
  String get winesStatsSpendingBestValue => 'Melhor valor';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count mais';
  }

  @override
  String get winesStatsProLockTitle => 'Desbloqueia mais 3 insights';

  @override
  String get winesStatsProLockBody =>
      'Vê de onde vieram as tuas garrafas, o que gastas e em que regiões apostas mais.';

  @override
  String get winesStatsProLockPillPrices => 'Preços';

  @override
  String get winesStatsProLockPillWhere => 'Onde';

  @override
  String get winesStatsProLockPillRegions => 'Regiões de topo';

  @override
  String get winesStatsProLockCta => 'Desbloquear com Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 mês anterior';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count meses anteriores';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vinhos',
      one: '1 vinho',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locais',
      one: '1 local',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Fechar';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'vinho';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'vinhos';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Mais bebido';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Melhor avaliado';

  @override
  String get tastingCreateHeader => 'NOVA PROVA';

  @override
  String get tastingEditHeader => 'EDITAR PROVA';

  @override
  String get tastingFieldTitleLabel => 'Título';

  @override
  String get tastingFieldDateLabel => 'Data';

  @override
  String get tastingFieldTimeLabel => 'Hora';

  @override
  String get tastingFieldPlaceLabel => 'Local';

  @override
  String get tastingFieldDescriptionLabel => 'Descrição';

  @override
  String get tastingFieldTapToAdd => 'Toca para adicionar';

  @override
  String get tastingFieldOpenLineupLabel => 'Alinhamento aberto';

  @override
  String get tastingFieldOpenLineupHint =>
      'Adiciona vinhos à medida que aparecem';

  @override
  String get tastingTitleSheetTitle => 'Título da prova';

  @override
  String get tastingTitleSheetHint => 'p. ex. Noite de Barolo';

  @override
  String get tastingDescriptionSheetTitle => 'Descrição';

  @override
  String get tastingDescriptionSheetHint => 'Do que é que se trata?';

  @override
  String get tastingCreateSubmitCta => 'Criar prova';

  @override
  String get tastingEditSubmitCta => 'Guardar alterações';

  @override
  String get tastingCreateFailedSnack => 'Não foi possível criar a prova';

  @override
  String get tastingUpdateFailedSnack => 'Não foi possível atualizar a prova';

  @override
  String get tastingDetailNotFound => 'Prova não encontrada';

  @override
  String get tastingDetailErrorLoad => 'Não foi possível carregar a prova';

  @override
  String get tastingDetailMenuAddToCalendar => 'Adicionar ao calendário';

  @override
  String get tastingDetailMenuShare => 'Partilhar';

  @override
  String get tastingDetailMenuEdit => 'Editar prova';

  @override
  String get tastingDetailMenuCancel => 'Cancelar prova';

  @override
  String get tastingDetailCancelDialogTitle => 'Cancelar prova?';

  @override
  String get tastingDetailCancelDialogBody =>
      'Isto remove-a para toda a gente.';

  @override
  String get tastingDetailCancelDialogKeep => 'Manter';

  @override
  String get tastingDetailCancelDialogConfirm => 'Cancelar';

  @override
  String get tastingDetailEndDialogTitle => 'Terminar prova?';

  @override
  String get tastingDetailEndDialogBody =>
      'Isto bloqueia o resumo. Os participantes ainda podem adicionar notas por mais um pouco.';

  @override
  String get tastingDetailEndDialogKeep => 'Continuar';

  @override
  String get tastingDetailEndDialogConfirm => 'Terminar';

  @override
  String get tastingCalendarFailedSnack =>
      'Não foi possível abrir o calendário';

  @override
  String get tastingLifecycleUpcoming => 'PRÓXIMA';

  @override
  String get tastingLifecycleLive => 'AO VIVO';

  @override
  String get tastingLifecycleConcluded => 'TERMINADA';

  @override
  String get tastingLifecycleStartCta => 'Começar prova';

  @override
  String get tastingLifecycleEndCta => 'Terminar prova';

  @override
  String get tastingDetailSectionPeople => 'Pessoas';

  @override
  String get tastingDetailSectionPlace => 'Local';

  @override
  String get tastingDetailSectionWines => 'VINHOS';

  @override
  String get tastingDetailAddWines => 'Adicionar vinhos';

  @override
  String get tastingDetailNoAttendees => 'Ainda não há ninguém convidado.';

  @override
  String get tastingDetailUnknownAttendee => 'Desconhecido';

  @override
  String get tastingDetailRsvpYour => 'A tua resposta';

  @override
  String get tastingDetailRsvpGoing => 'Vou';

  @override
  String get tastingDetailRsvpMaybe => 'Talvez';

  @override
  String get tastingDetailRsvpDeclined => 'Não';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count vão';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count talvez';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count não vão';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count pendentes';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Vão';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Talvez';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'Não vão';

  @override
  String get tastingDetailAttendeesSheetPending => 'Pendentes';

  @override
  String get tastingEmptyOpenActiveTitle =>
      'O alinhamento enche-se à medida que avanças';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Qualquer pessoa que vá pode adicionar garrafas';

  @override
  String get tastingEmptyDefaultTitle => 'Ainda não há vinhos no alinhamento';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Os vinhos podem ser adicionados quando a prova começar';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Os vinhos são adicionados na noite';

  @override
  String get tastingEmptyPlannedHost =>
      'Toca em «Adicionar vinhos» para montar o alinhamento';

  @override
  String get tastingEmptyPlannedGuest =>
      'O anfitrião ainda não adicionou vinhos';

  @override
  String get tastingRecapResultsHeader => 'RESULTADOS';

  @override
  String get tastingRecapShareCta => 'Partilhar resumo';

  @override
  String get tastingRecapTopWineEyebrow => 'VINHO DA NOITE';

  @override
  String get tastingRecapEmpty =>
      'Ainda não foram submetidas notas para esta prova.';

  @override
  String get tastingRecapRowNoRatings => 'sem notas';

  @override
  String get tastingRecapGroupFallback => 'Prova de grupo';

  @override
  String get tastingPickerSheetTitle => 'Adicionar vinhos ao alinhamento';

  @override
  String get tastingPickerEmpty => 'Ainda não tens vinhos.';

  @override
  String get tastingPickerErrorFallback =>
      'Não foi possível carregar os vinhos.';

  @override
  String get tastingPickerSubmitDefault => 'Adicionar vinhos';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Adicionar $count vinhos',
      one: 'Adicionar 1 vinho',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Adicionado';

  @override
  String get groupListHeader => 'GRUPOS';

  @override
  String get groupListSubtitle => 'Provar em conjunto';

  @override
  String get groupListSortRecent => 'Ordenar: recentes';

  @override
  String get groupListSortName => 'Ordenar: nome';

  @override
  String get groupListCreateTooltip => 'Criar grupo';

  @override
  String get groupListJoinTitle => 'Entrar num grupo';

  @override
  String get groupListJoinSubtitle => 'Introduz um código de convite';

  @override
  String get groupListJoinNotFound => 'Grupo não encontrado';

  @override
  String get groupListErrorLoad => 'Não foi possível carregar os grupos';

  @override
  String get groupListEmptyTitle => 'Ainda não há grupos';

  @override
  String get groupListEmptyBody => 'Cria um ou entra num para partilhar vinhos';

  @override
  String get groupListEmptyCta => 'Criar grupo';

  @override
  String get groupCreateSourceCamera => 'Câmara';

  @override
  String get groupCreateSourceGallery => 'Galeria';

  @override
  String get groupCreateSourceRemovePhoto => 'Remover foto';

  @override
  String get groupCreatePickFailedFallback => 'Falha na seleção.';

  @override
  String get groupCreateUploadFailedFallback => 'Falha ao carregar a foto.';

  @override
  String get groupCreateFailedFallback =>
      'Não foi possível criar o grupo. Tenta novamente.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Falha ao guardar: $error';
  }

  @override
  String get groupCreateTitle => 'Novo grupo';

  @override
  String get groupCreateNameHint => 'Nome do grupo';

  @override
  String get groupCreateSubmit => 'Criar';

  @override
  String get groupJoinTitle => 'Código de convite';

  @override
  String get groupJoinHint => 'p. ex. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Entrar';

  @override
  String get groupDetailNotFound => 'Grupo não encontrado';

  @override
  String get groupDetailErrorLoad => 'Não foi possível carregar o grupo';

  @override
  String get groupDetailSectionSharedWines => 'Vinhos partilhados';

  @override
  String get groupDetailSectionTastings => 'Provas';

  @override
  String get groupDetailActionShare => 'Partilhar';

  @override
  String get groupDetailActionPlan => 'Planear';

  @override
  String get groupDetailMenuEdit => 'Editar grupo';

  @override
  String get groupDetailMenuDelete => 'Eliminar grupo';

  @override
  String get groupDetailMenuLeave => 'Sair do grupo';

  @override
  String get groupDetailLeaveDialogTitle => 'Sair do grupo?';

  @override
  String get groupDetailLeaveDialogBody =>
      'Podes voltar a entrar mais tarde com o código de convite.';

  @override
  String get groupDetailLeaveDialogCancel => 'Cancelar';

  @override
  String get groupDetailLeaveDialogConfirm => 'Sair';

  @override
  String get groupDetailDeleteDialogTitle => 'Eliminar grupo?';

  @override
  String get groupDetailDeleteDialogBody =>
      'O grupo e os seus vinhos partilhados serão removidos para toda a gente.';

  @override
  String get groupDetailDeleteDialogCancel => 'Cancelar';

  @override
  String get groupDetailDeleteDialogConfirm => 'Eliminar';

  @override
  String get groupSettingsEditTitle => 'Editar grupo';

  @override
  String get groupSettingsNameLabel => 'Nome';

  @override
  String get groupSettingsSourceCamera => 'Câmara';

  @override
  String get groupSettingsSourceGallery => 'Galeria';

  @override
  String get groupSettingsRemovePhoto => 'Remover foto';

  @override
  String get groupSettingsUploadFailedFallback => 'Falha ao carregar.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Falha ao eliminar.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Falha ao guardar: $error';
  }

  @override
  String get groupSettingsSave => 'Guardar';

  @override
  String get groupInviteEyebrow => 'CONVITE';

  @override
  String get groupInviteFriendsEyebrow => 'CONVIDAR AMIGOS';

  @override
  String get groupInviteCodeCopied => 'Código de convite copiado';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Junta-te a «$groupName» no Sippd 🍷\n\n$url\n\nOu introduz o código: $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Junta-te a $groupName no Sippd';
  }

  @override
  String get groupInviteActionCopy => 'Copiar código';

  @override
  String get groupInviteActionShare => 'Partilhar link';

  @override
  String get groupInviteFriendsEmpty =>
      'Não há amigos disponíveis para convidar.';

  @override
  String get groupInviteFriendsAllInvited =>
      'Todos os teus amigos já estão neste grupo ou foram convidados.';

  @override
  String get groupInviteFriendsErrorLoad =>
      'Não foi possível carregar os amigos';

  @override
  String get groupInviteFriendFallback => 'amigo';

  @override
  String get groupInviteUnknownName => 'Desconhecido';

  @override
  String groupInviteSentSnack(String name) {
    return 'Convite enviado a $name';
  }

  @override
  String get groupInviteSendFailedFallback =>
      'Não foi possível enviar o convite.';

  @override
  String get groupInvitationsHeader => 'CONVITES';

  @override
  String get groupInvitationsInviterFallback => 'Alguém';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Convidado por $name';
  }

  @override
  String get groupInvitationsDecline => 'Recusar';

  @override
  String get groupInvitationsAccept => 'Aceitar';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return 'Entraste em $name';
  }

  @override
  String get groupInvitationsAcceptFailed =>
      'Não foi possível aceitar o convite';

  @override
  String get groupMembersCountOne => '1 membro';

  @override
  String groupMembersCountMany(int count) {
    return '$count membros';
  }

  @override
  String get groupMembersUnknown => 'Desconhecido';

  @override
  String get groupMembersOwnerBadge => 'PROPRIETÁRIO';

  @override
  String get groupWineCarouselDetails => 'Detalhes';

  @override
  String get groupWineCarouselEmptyTitle =>
      'Ainda não foi partilhado nenhum vinho';

  @override
  String get groupWineCarouselEmptyBody =>
      'Escolhe um da tua coleção para arrancar com a lista.';

  @override
  String get groupWineCarouselEmptyCta => 'Partilhar um vinho';

  @override
  String get groupWineTypeRed => 'TINTO';

  @override
  String get groupWineTypeWhite => 'BRANCO';

  @override
  String get groupWineTypeRose => 'ROSÉ';

  @override
  String get groupWineTypeSparkling => 'ESPUMANTE';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Guarda primeiro o vinho — as notas de prova ligam-se a ele.';

  @override
  String get groupWineRatingNoCanonical =>
      'O vinho ainda não tem identidade canónica — tenta novamente.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'O vinho ainda não tem identidade canónica.';

  @override
  String get groupWineRatingNotesHint => 'Adiciona uma nota';

  @override
  String get groupWineRatingOfflineRetry => 'Offline · Tentar novamente';

  @override
  String get groupWineRatingSaveFailedRetry =>
      'Não foi possível guardar · Tentar novamente';

  @override
  String get groupWineRatingSaved => 'Guardado ✓';

  @override
  String get groupWineRatingSaveCta => 'Guardar avaliação';

  @override
  String get groupWineRatingRemoveMine => 'Remover a minha avaliação';

  @override
  String get groupWineRatingUnshareDialogTitle => 'Remover do grupo?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '«$name» será removido deste grupo. As avaliações dos membros também serão eliminadas.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Cancelar';

  @override
  String get groupWineRatingUnshareConfirm => 'Remover';

  @override
  String get groupWineRatingMoreTooltip => 'Mais';

  @override
  String get groupWineRatingUnshareMenu => 'Remover do grupo';

  @override
  String get groupWineRatingsTitle => 'Avaliações';

  @override
  String get groupWineRatingsCountOne => '1 avaliação';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count avaliações';
  }

  @override
  String get groupWineRatingsAvgLabel => 'média';

  @override
  String get groupWineRatingsBeFirst => 'Sê o primeiro a avaliar';

  @override
  String get groupWineRatingsSoloMe =>
      'És o primeiro · convida outros a avaliar';

  @override
  String get groupShareWineTitle => 'Partilhar um vinho';

  @override
  String get groupShareWineErrorLoad => 'Não foi possível carregar os vinhos.';

  @override
  String get groupShareWineEmpty => 'Ainda não tens vinhos.';

  @override
  String get groupShareWineSharedChip => 'Partilhado';

  @override
  String get groupShareWineSheetTitle => 'Partilhar com o grupo';

  @override
  String get groupShareWineSheetEmpty => 'Ainda não estás em nenhum grupo.';

  @override
  String get groupShareWineSheetErrorLoad =>
      'Não foi possível carregar os grupos.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Já partilhado';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Partilhado com $name';
  }

  @override
  String get groupShareWineRowMemberOne => '1 membro';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count membros';
  }

  @override
  String get groupShareWineRowWineOne => '1 vinho';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count vinhos';
  }

  @override
  String get groupShareMatchTitle => 'Já está neste grupo';

  @override
  String groupShareMatchBody(String name) {
    return '«$name» parece um vinho que um membro já partilhou. É o mesmo vinho?';
  }

  @override
  String get groupShareMatchNone => 'Nenhum destes — partilhar em separado';

  @override
  String get groupShareMatchCancel => 'Cancelar';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Partilhado por @$username';
  }

  @override
  String get groupFriendActionsInvite => 'Convidar para um grupo';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return 'Convidar $name para…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'Não há grupos para convidar. Cria ou entra num primeiro.';

  @override
  String get groupFriendActionsPickerErrorLoad =>
      'Não foi possível carregar os grupos';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Provas passadas ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'Ainda não há provas';

  @override
  String get groupCalendarEmptyBody =>
      'Marca uma para juntar o grupo em torno de uma garrafa.';

  @override
  String get groupCalendarEmptyCta => 'Planear uma prova';

  @override
  String get groupWineDetailSectionRatings => 'AVALIAÇÕES DO GRUPO';

  @override
  String get groupWineDetailEmptyRatings => 'Ainda não há avaliações do grupo.';

  @override
  String get groupWineDetailStatGroupAvg => 'Média do grupo';

  @override
  String get groupWineDetailStatRatings => 'Avaliações';

  @override
  String get groupWineDetailStatNoRatings => 'Sem avaliações';

  @override
  String get groupWineDetailStatRegion => 'Região';

  @override
  String get groupWineDetailStatCountry => 'País';

  @override
  String get groupWineDetailStatOrigin => 'Origem';

  @override
  String get groupWineDetailSharedByEyebrow => 'PARTILHADO POR';

  @override
  String get groupWineDetailSharerFallback => 'alguém';

  @override
  String get groupWineDetailMemberFallback => 'Membro';

  @override
  String get groupWineDetailRelJustNow => 'agora mesmo';

  @override
  String groupWineDetailRelMinutes(int count) {
    return 'há ${count}m';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return 'há ${count}h';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return 'há ${count}d';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return 'há ${count}sem';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return 'há ${count}mês';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return 'há ${count}a';
  }

  @override
  String get friendsHeader => 'AMIGOS';

  @override
  String get friendsSubtitle => 'Prova com pessoas que conheces';

  @override
  String get friendsSearchHint => 'Procura por nome de utilizador ou nome';

  @override
  String get friendsSearchEmpty => 'Nenhum utilizador encontrado';

  @override
  String get friendsSearchErrorFallback =>
      'Não foi possível carregar a pesquisa.';

  @override
  String get friendsUnknownUser => 'Desconhecido';

  @override
  String friendsRequestsHeader(int count) {
    return 'Pedidos ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'À espera de resposta ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Pedido enviado';

  @override
  String get friendsRequestSubtitle => 'quer ser teu amigo';

  @override
  String get friendsActionCancel => 'Cancelar';

  @override
  String get friendsActionAdd => 'Adicionar';

  @override
  String get friendsCancelDialogFallbackUser => 'este utilizador';

  @override
  String get friendsCancelDialogTitle => 'Cancelar pedido?';

  @override
  String friendsCancelDialogBody(String name) {
    return 'Cancelar o teu pedido de amizade a $name?';
  }

  @override
  String get friendsCancelDialogKeep => 'Manter';

  @override
  String get friendsCancelDialogConfirm => 'Cancelar pedido';

  @override
  String get friendsListHeader => 'Os teus amigos';

  @override
  String get friendsListErrorFallback => 'Não foi possível carregar os amigos.';

  @override
  String get friendsRemoveDialogTitle => 'Remover amigo?';

  @override
  String friendsRemoveDialogBody(String name) {
    return 'Remover $name dos teus amigos?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Remover';

  @override
  String get friendsSendRequestErrorFallback =>
      'Não foi possível enviar o pedido.';

  @override
  String get friendsStatusChipFriend => 'Amigo';

  @override
  String get friendsStatusChipPending => 'Pendente';

  @override
  String get friendsEmptyDefaultName => 'Um amigo';

  @override
  String get friendsEmptyTitle => 'Traz o teu círculo de prova';

  @override
  String get friendsEmptyBody =>
      'O Sippd fica melhor com amigos. Envia um convite — aparecem logo no teu perfil.';

  @override
  String get friendsEmptyInviteCta => 'Convidar amigos';

  @override
  String get friendsEmptyFindCta => 'Procurar por nome de utilizador';

  @override
  String get friendsProfileNotFound => 'Perfil não encontrado';

  @override
  String get friendsProfileErrorLoad => 'Não foi possível carregar o perfil';

  @override
  String get friendsProfileNameFallback => 'Amigo';

  @override
  String get friendsProfileRecentWinesHeader => 'VINHOS RECENTES';

  @override
  String get friendsProfileWinesErrorLoad =>
      'Não foi possível carregar os vinhos';

  @override
  String get friendsProfileStatWines => 'Vinhos';

  @override
  String get friendsProfileStatAvg => 'Média';

  @override
  String get friendsProfileStatCountry => 'País';

  @override
  String get friendsProfileStatCountries => 'Países';

  @override
  String get paywallPitchEyebrow => 'Sippd Pro';

  @override
  String get paywallPitchHeadline => 'Descobre como\nprovas a sério.';

  @override
  String get paywallPitchSubhead =>
      'Mapeia cada garrafa, encontra amigos que bebem como tu e aprofunda cada prova.';

  @override
  String get paywallBenefitFriendsTitle =>
      'Grupos ilimitados e match com amigos';

  @override
  String get paywallBenefitFriendsSubtitle =>
      'Traz o teu círculo. Vê quem bebe como tu.';

  @override
  String get paywallBenefitCompassTitle =>
      'Bússola de gosto e estatísticas a fundo';

  @override
  String get paywallBenefitCompassSubtitle =>
      'A tua personalidade vínica, no mapa.';

  @override
  String get paywallBenefitNotesTitle => 'Notas de prova de especialista';

  @override
  String get paywallBenefitNotesSubtitle => 'Nariz · corpo · taninos · final.';

  @override
  String get paywallPlanMonthly => 'Mensal';

  @override
  String get paywallPlanAnnual => 'Anual';

  @override
  String get paywallPlanLifetime => 'Vitalício';

  @override
  String get paywallPlanSubtitleMonthly => 'Cancela quando quiseres';

  @override
  String get paywallPlanSubtitleAnnual => 'Mais popular';

  @override
  String get paywallPlanSubtitleLifetime =>
      'Oferta de lançamento limitada · pagamento único';

  @override
  String get paywallPlanBadgeAnnual => 'MAIS POPULAR';

  @override
  String get paywallPlanBadgeLifetime => 'EDIÇÃO FUNDADORES';

  @override
  String paywallPlanSavingsVsMonthly(int pct) {
    return 'Poupa $pct% face ao mensal';
  }

  @override
  String get paywallTrialTodayTitle => 'Hoje';

  @override
  String get paywallTrialTodaySubtitle => 'Acesso Pro completo desbloqueado.';

  @override
  String get paywallTrialDay5Title => 'Dia 5';

  @override
  String get paywallTrialDay5Subtitle => 'Avisamos-te antes da cobrança.';

  @override
  String get paywallTrialDay7Title => 'Dia 7';

  @override
  String get paywallTrialDay7Subtitle =>
      'O período de teste termina. Cancela quando quiseres.';

  @override
  String get paywallCtaContinue => 'Continuar';

  @override
  String get paywallCtaSelectPlan => 'Escolhe um plano';

  @override
  String get paywallCtaStartTrial => 'Começar teste gratuito de 7 dias';

  @override
  String get paywallCtaMaybeLater => 'Talvez mais tarde';

  @override
  String get paywallCtaRestore => 'Restaurar compras';

  @override
  String get paywallFooterDisclosure =>
      'Cancela quando quiseres · faturado pela Apple ou Google';

  @override
  String get paywallPlansLoadError => 'Não foi possível carregar os planos';

  @override
  String get paywallPlansEmpty => 'Ainda não há planos disponíveis.';

  @override
  String get paywallErrorPurchaseFailed => 'A compra falhou. Tenta novamente.';

  @override
  String get paywallErrorRestoreFailed =>
      'Não foi possível restaurar as compras.';

  @override
  String get paywallRestoreWelcomeBack => 'Bem-vindo de volta ao Sippd Pro!';

  @override
  String get paywallRestoreNoneFound =>
      'Não foi encontrada nenhuma subscrição ativa.';

  @override
  String get paywallSubscriptionTitle => 'Subscrição';

  @override
  String get paywallSubscriptionBrand => 'Sippd Pro';

  @override
  String get paywallSubscriptionChipActive => 'ATIVA';

  @override
  String get paywallSubscriptionChipTrial => 'TESTE';

  @override
  String get paywallSubscriptionChipEnding => 'A TERMINAR';

  @override
  String get paywallSubscriptionChipLifetime => 'VITALÍCIA';

  @override
  String get paywallSubscriptionChipTest => 'MODO TESTE';

  @override
  String get paywallSubscriptionPlanTest => 'Modo teste';

  @override
  String get paywallSubscriptionPlanLifetime => 'Vitalícia';

  @override
  String get paywallSubscriptionPlanAnnual => 'Anual';

  @override
  String get paywallSubscriptionPlanMonthly => 'Mensal';

  @override
  String get paywallSubscriptionPlanWeekly => 'Semanal';

  @override
  String get paywallSubscriptionPlanGeneric => 'Plano Pro';

  @override
  String get paywallSubscriptionPeriodYear => '/ ano';

  @override
  String get paywallSubscriptionPeriodMonth => '/ mês';

  @override
  String get paywallSubscriptionPeriodWeek => '/ semana';

  @override
  String get paywallSubscriptionPeriodLifetime => 'pagamento único';

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
  String get paywallSubscriptionStorePromo => 'Acesso promocional';

  @override
  String paywallSubscriptionBilledVia(String store) {
    return 'Faturado via $store';
  }

  @override
  String get paywallSubscriptionStatusTestNoSub =>
      'Funcionalidades Pro desbloqueadas localmente · sem subscrição real';

  @override
  String get paywallSubscriptionStatusTestLocal =>
      'Funcionalidades Pro desbloqueadas localmente';

  @override
  String get paywallSubscriptionStatusLifetime =>
      'Acesso vitalício — teu para sempre';

  @override
  String get paywallSubscriptionStatusEndingNoDate => 'Não vai renovar';

  @override
  String paywallSubscriptionStatusEndingWithDate(String date) {
    return 'Acesso até $date · não vai renovar';
  }

  @override
  String get paywallSubscriptionStatusTrialActive => 'Teste ativo';

  @override
  String get paywallSubscriptionStatusTrialEndsToday => 'O teste termina hoje';

  @override
  String get paywallSubscriptionStatusTrialEndsTomorrow =>
      'O teste termina amanhã';

  @override
  String paywallSubscriptionStatusTrialEndsInDays(int days) {
    return 'O teste termina em $days dias';
  }

  @override
  String get paywallSubscriptionStatusActive => 'Ativa';

  @override
  String paywallSubscriptionStatusRenewsOn(String date) {
    return 'Renova a $date';
  }

  @override
  String get paywallSubscriptionSectionIncluded => 'Incluído no Pro';

  @override
  String get paywallSubscriptionSectionManage => 'Gerir';

  @override
  String get paywallSubscriptionRowChangePlan => 'Mudar de plano';

  @override
  String get paywallSubscriptionRowRestore => 'Restaurar compras';

  @override
  String get paywallSubscriptionRowCancel => 'Cancelar subscrição';

  @override
  String get paywallSubscriptionDisclosure =>
      'As subscrições são faturadas pela Apple ou Google. Gere-as nas definições da loja.';

  @override
  String get paywallSubscriptionOpenError =>
      'Não foi possível abrir as definições da subscrição.';

  @override
  String get paywallMonthShortJan => 'Jan';

  @override
  String get paywallMonthShortFeb => 'Fev';

  @override
  String get paywallMonthShortMar => 'Mar';

  @override
  String get paywallMonthShortApr => 'Abr';

  @override
  String get paywallMonthShortMay => 'Mai';

  @override
  String get paywallMonthShortJun => 'Jun';

  @override
  String get paywallMonthShortJul => 'Jul';

  @override
  String get paywallMonthShortAug => 'Ago';

  @override
  String get paywallMonthShortSep => 'Set';

  @override
  String get paywallMonthShortOct => 'Out';

  @override
  String get paywallMonthShortNov => 'Nov';

  @override
  String get paywallMonthShortDec => 'Dez';

  @override
  String get tasteTraitBody => 'Corpo';

  @override
  String get tasteTraitTannin => 'Tanino';

  @override
  String get tasteTraitAcidity => 'Acidez';

  @override
  String get tasteTraitSweetness => 'Doçura';

  @override
  String get tasteTraitOak => 'Madeira';

  @override
  String get tasteTraitIntensity => 'Intensidade';

  @override
  String get tasteTraitSweetShort => 'Doce';

  @override
  String get tasteTraitBodyLow => 'Leve, fácil de beber';

  @override
  String get tasteTraitBodyMid => 'Equilibrado';

  @override
  String get tasteTraitBodyHigh => 'Encorpado, robusto';

  @override
  String get tasteTraitTanninLow => 'Suave, pouca pega';

  @override
  String get tasteTraitTanninMid => 'Pega média';

  @override
  String get tasteTraitTanninHigh => 'Firme, estruturado';

  @override
  String get tasteTraitAcidityLow => 'Suave, redondo';

  @override
  String get tasteTraitAcidityMid => 'Equilibrado';

  @override
  String get tasteTraitAcidityHigh => 'Fresco, vibrante';

  @override
  String get tasteTraitSweetnessLow => 'Muito seco';

  @override
  String get tasteTraitSweetnessMid => 'Meio-seco';

  @override
  String get tasteTraitSweetnessHigh => 'Tendência doce';

  @override
  String get tasteTraitOakLow => 'Sem madeira, fresco';

  @override
  String get tasteTraitOakMid => 'Toque de madeira';

  @override
  String get tasteTraitOakHigh => 'Muito amadeirado';

  @override
  String get tasteTraitIntensityLow => 'Aromas subtis';

  @override
  String get tasteTraitIntensityMid => 'Expressivo';

  @override
  String get tasteTraitIntensityHigh => 'Intenso, aromático';

  @override
  String tasteDnaBodyLowPct(int pct) {
    return 'Pendes para vinhos leves · $pct%';
  }

  @override
  String tasteDnaBodyMidPct(int pct) {
    return 'Corpo equilibrado · $pct%';
  }

  @override
  String tasteDnaBodyHighPct(int pct) {
    return 'Pendes para vinhos encorpados · $pct%';
  }

  @override
  String tasteDnaTanninLowPct(int pct) {
    return 'Taninos suaves · $pct%';
  }

  @override
  String tasteDnaTanninMidPct(int pct) {
    return 'Tanino médio · $pct%';
  }

  @override
  String tasteDnaTanninHighPct(int pct) {
    return 'Taninos firmes e marcados · $pct%';
  }

  @override
  String tasteDnaAcidityLowPct(int pct) {
    return 'Acidez suave · $pct%';
  }

  @override
  String tasteDnaAcidityMidPct(int pct) {
    return 'Acidez equilibrada · $pct%';
  }

  @override
  String tasteDnaAcidityHighPct(int pct) {
    return 'Bebedor de acidez alta · $pct%';
  }

  @override
  String tasteDnaSweetnessLowPct(int pct) {
    return 'Muito seco · $pct%';
  }

  @override
  String tasteDnaSweetnessMidPct(int pct) {
    return 'Tendência meio-seco · $pct%';
  }

  @override
  String tasteDnaSweetnessHighPct(int pct) {
    return 'Tendência doce · $pct%';
  }

  @override
  String tasteDnaOakLowPct(int pct) {
    return 'Sem madeira / fresco · $pct%';
  }

  @override
  String tasteDnaOakMidPct(int pct) {
    return 'Alguma madeira · $pct%';
  }

  @override
  String tasteDnaOakHighPct(int pct) {
    return 'Amante de madeira · $pct%';
  }

  @override
  String tasteDnaIntensityLowPct(int pct) {
    return 'Aromas subtis · $pct%';
  }

  @override
  String tasteDnaIntensityMidPct(int pct) {
    return 'Expressivo · $pct%';
  }

  @override
  String tasteDnaIntensityHighPct(int pct) {
    return 'Aromas intensos · $pct%';
  }

  @override
  String get tasteDnaNotEnoughYet =>
      'Ainda não há vinhos avaliados suficientes — continua';

  @override
  String get tasteArchetypeBoldRedHunter => 'Caçador de Tintos Robustos';

  @override
  String get tasteArchetypeBoldRedHunterTagline =>
      'Tintos encorpados e ricos em tanino são o teu território.';

  @override
  String get tasteArchetypeElegantBurgundian => 'Borgonhês Elegante';

  @override
  String get tasteArchetypeElegantBurgundianTagline =>
      'Tintos mais leves com acidez viva guiam o teu palato.';

  @override
  String get tasteArchetypeAromaticWhiteLover => 'Amante do Branco Aromático';

  @override
  String get tasteArchetypeAromaticWhiteLoverTagline =>
      'Brancos frescos e expressivos com acidez bem marcada.';

  @override
  String get tasteArchetypeSparklingSociable => 'Espumante Sociável';

  @override
  String get tasteArchetypeSparklingSociableTagline =>
      'Bolhas e vinhos pálidos dominam a tua coleção.';

  @override
  String get tasteArchetypeClassicStructure => 'Estrutura Clássica';

  @override
  String get tasteArchetypeClassicStructureTagline =>
      'Vinhos comedidos, gastronómicos e com acidez viva.';

  @override
  String get tasteArchetypeSunRipenedBold => 'Maturado ao Sol';

  @override
  String get tasteArchetypeSunRipenedBoldTagline =>
      'Fruta generosa e madeira de vinhas soalheiras.';

  @override
  String get tasteArchetypeDessertOffDry => 'Sobremesa / Meio-seco';

  @override
  String get tasteArchetypeDessertOffDryTagline =>
      'Pendes para garrafas com um toque de doçura.';

  @override
  String get tasteArchetypeNaturalLowIntervention =>
      'Natural / Mínima Intervenção';

  @override
  String get tasteArchetypeNaturalLowInterventionTagline =>
      'Sem madeira, mais leves — o campo da frescura.';

  @override
  String get tasteArchetypeCrispMineralFan => 'Fã de Mineralidade';

  @override
  String get tasteArchetypeCrispMineralFanTagline =>
      'Estilos tensos, minerais e de acidez alta são a tua assinatura.';

  @override
  String get tasteArchetypeEclecticExplorer => 'Explorador Eclético';

  @override
  String get tasteArchetypeEclecticExplorerTagline =>
      'Palato abrangente — provas por todo o mapa do vinho.';

  @override
  String get tasteArchetypeCuriousNewcomer => 'Recém-chegado Curioso';

  @override
  String get tasteArchetypeCuriousNewcomerTagline =>
      'Avalia mais uns vinhos e a tua personalidade revela-se.';

  @override
  String get tasteCompassModeStyle => 'Estilo';

  @override
  String get tasteCompassModeWorld => 'Mundo';

  @override
  String get tasteCompassModeGrapes => 'Castas';

  @override
  String get tasteCompassModeDna => 'ADN';

  @override
  String get tasteCompassMetricCount => 'quantidade';

  @override
  String get tasteCompassMetricRating => 'nota';

  @override
  String get tasteCompassContinentEurope => 'Europa';

  @override
  String get tasteCompassContinentNorthAmerica => 'América do Norte';

  @override
  String get tasteCompassContinentSouthAmerica => 'América do Sul';

  @override
  String get tasteCompassContinentAfrica => 'África';

  @override
  String get tasteCompassContinentAsia => 'Ásia';

  @override
  String get tasteCompassContinentOceania => 'Oceânia';

  @override
  String tasteCompassStyleNoneYet(String label) {
    return 'Ainda não há vinhos $label';
  }

  @override
  String tasteCompassStyleSummaryOne(int count, String label, String avg) {
    return '$count vinho $label · $avg★ média';
  }

  @override
  String tasteCompassStyleSummaryMany(int count, String label, String avg) {
    return '$count vinhos $label · $avg★ média';
  }

  @override
  String tasteCompassWorldNoneYet(String label) {
    return 'Ainda não há garrafas de $label';
  }

  @override
  String tasteCompassWorldSummaryOne(String label, String avg) {
    return '1 garrafa de $label · $avg★ média';
  }

  @override
  String tasteCompassWorldSummaryMany(int count, String label, String avg) {
    return '$count garrafas de $label · $avg★ média';
  }

  @override
  String get tasteCompassGrapeEmptySlot =>
      'Espaço vazio — avalia mais castas para o preencher';

  @override
  String tasteCompassGrapeSummaryOne(String name, String avg) {
    return '$name · 1 garrafa · $avg★ média';
  }

  @override
  String tasteCompassGrapeSummaryMany(String name, int count, String avg) {
    return '$name · $count garrafas · $avg★ média';
  }

  @override
  String get tasteCompassTitleDefault => 'Bússola de gosto';

  @override
  String get tasteCompassEmptyPromptOne =>
      'Avalia mais 1 vinho para desbloquear a bússola.';

  @override
  String tasteCompassEmptyPromptMany(int count) {
    return 'Avalia mais $count vinhos para desbloquear a bússola.';
  }

  @override
  String get tasteCompassNotEnoughData =>
      'Ainda não há dados suficientes para este modo.';

  @override
  String get tasteCompassDnaNeedsGrapes =>
      'O ADN precisa de uns vinhos com uma casta reconhecida. Escolhe uma casta canónica nos teus vinhos para desbloquear esta vista.';

  @override
  String get tasteCompassEyebrowPersonality => 'A TUA PERSONALIDADE VÍNICA';

  @override
  String get tasteCompassTentativeHint =>
      'Provisório — avalia mais vinhos para afinar';

  @override
  String get tasteCompassTopRegions => 'Regiões de topo';

  @override
  String get tasteCompassTopCountries => 'Países de topo';

  @override
  String get tasteCompassFooterWinesOne => '1 vinho';

  @override
  String tasteCompassFooterWinesMany(int count) {
    return '$count vinhos';
  }

  @override
  String tasteCompassFooterAvg(String avg) {
    return '$avg ★ média';
  }

  @override
  String get tasteHeroEyebrow => 'PERSONALIDADE';

  @override
  String get tasteHeroPromptCuriousOne =>
      'Avalia mais 1 vinho para revelar a tua personalidade.';

  @override
  String tasteHeroPromptCuriousMany(int count) {
    return 'Avalia mais $count vinhos para revelar a tua personalidade.';
  }

  @override
  String get tasteHeroAlmostThere => 'Quase lá';

  @override
  String get tasteHeroPromptThinDnaOne =>
      'Etiqueta uma casta canónica em mais 1 vinho para desbloquear o teu arquétipo.';

  @override
  String tasteHeroPromptThinDnaMany(int count) {
    return 'Etiqueta uma casta canónica em mais $count vinhos para desbloquear o teu arquétipo.';
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
  String get tasteHeroWinesOne => '1 vinho';

  @override
  String tasteHeroWinesMany(int count) {
    return '$count vinhos';
  }

  @override
  String tasteHeroAvg(String avg) {
    return '$avg★ média';
  }

  @override
  String get tasteHeroShare => 'Partilhar';

  @override
  String get tasteTraitsHeading => 'TRAÇOS';

  @override
  String get tasteTraitsProDivider => 'PRO';

  @override
  String get tasteTraitsUnlockAll => 'Desbloqueia todos os traços com Pro';

  @override
  String get tasteMatchLabel => 'match de gosto';

  @override
  String get tasteMatchConfidenceStrong => 'Forte';

  @override
  String get tasteMatchConfidenceSolid => 'Sólido';

  @override
  String get tasteMatchConfidenceEarly => 'Inicial';

  @override
  String tasteMatchSupportingOne(String dnaPart) {
    return 'Com base em 1 zona partilhada de região/tipo$dnaPart.';
  }

  @override
  String tasteMatchSupportingMany(int overlap, String dnaPart) {
    return 'Com base em $overlap zonas partilhadas de região/tipo$dnaPart.';
  }

  @override
  String get tasteMatchSupportingDnaPart => ' + sobreposição de estilo WSET';

  @override
  String get tasteMatchSignalStrong => 'Sinal forte.';

  @override
  String get tasteMatchSignalSolid => 'Sinal sólido.';

  @override
  String get tasteMatchSignalEarly =>
      'Sinal inicial — continua a avaliar para afinar.';

  @override
  String get tasteMatchBreakdownBucket => 'Encaixe de região e tipo';

  @override
  String get tasteMatchBreakdownDna => 'Encaixe de ADN de estilo';

  @override
  String get tasteMatchEmptyNotEnough =>
      'Ainda não há vinhos suficientes para comparar — avalia mais umas garrafas para desbloquear o match.';

  @override
  String get tasteMatchEmptyNoOverlap =>
      'Ainda não avaliaram vinhos das mesmas regiões ou tipos. O match aparece quando os vossos gostos se sobrepõem.';

  @override
  String tasteFriendUpsellTitle(String name) {
    return 'Vê como $name prova';
  }

  @override
  String get tasteFriendUpsellBody =>
      'Compara os vossos palatos, encontra vinhos que ambos adorem e descobre onde o vosso gosto diverge.';

  @override
  String get tasteFriendUpsellPillMatch => 'Match de gosto';

  @override
  String get tasteFriendUpsellPillShared => 'Garrafas partilhadas';

  @override
  String get tasteFriendUpsellCta => 'Desbloquear Sippd Pro';

  @override
  String get tasteFriendSharedHeading => 'VINHOS QUE AMBOS AVALIARAM';

  @override
  String tasteFriendSharedMore(int count) {
    return '+ $count mais';
  }

  @override
  String get tasteFriendRatingYou => 'tu';

  @override
  String get tasteFriendRatingThem => 'ele/ela';

  @override
  String shareRatedOn(String date) {
    return 'AVALIADO · $date';
  }

  @override
  String get shareRatingDenominator => '/ 10';

  @override
  String shareFooterRateYours(String url) {
    return 'avalia os teus em $url';
  }

  @override
  String shareFooterFindYours(String url) {
    return 'encontra o teu gosto em $url';
  }

  @override
  String shareFooterHostYours(String url) {
    return 'organiza a tua em $url';
  }

  @override
  String shareFooterJoinAt(String url) {
    return 'junta-te em $url';
  }

  @override
  String get shareCompassEyebrow => 'PERSONALIDADE VÍNICA';

  @override
  String get shareCompassWhatDefinesMe => 'O QUE ME DEFINE';

  @override
  String get shareCompassSampleSizeOne => 'com base em 1 vinho';

  @override
  String shareCompassSampleSizeMany(int count) {
    return 'com base em $count vinhos';
  }

  @override
  String shareCompassPhrase(String descriptor, String trait) {
    return '$descriptor $trait';
  }

  @override
  String shareCompassShareText(String archetype, String url) {
    return 'A minha personalidade vínica: $archetype · encontra a tua em $url';
  }

  @override
  String get shareTastingEyebrow => 'PROVA DE GRUPO';

  @override
  String get shareTastingTopWine => 'VINHO DA NOITE';

  @override
  String get shareTastingLineup => 'ALINHAMENTO';

  @override
  String shareTastingMore(int count) {
    return '+ $count mais';
  }

  @override
  String get shareTastingAttendeesOne => '1 provador';

  @override
  String shareTastingAttendeesMany(int count) {
    return '$count provadores';
  }

  @override
  String shareTastingShareTextTop(String wine, String avg, String url) {
    return '$wine levou a noite com $avg/10 · organizada no Sippd · $url';
  }

  @override
  String shareTastingShareTextTitle(String title, String url) {
    return '$title · organizada no Sippd · $url';
  }

  @override
  String shareRatingShareText(String wine, String rating, String url) {
    return 'Acabei de avaliar $wine $rating/10 no Sippd · $url';
  }

  @override
  String get shareInviteEyebrow => 'UM CONVITE';

  @override
  String get shareInviteHero => 'Vamos provar\njuntos.';

  @override
  String get shareInviteSub => 'Avalia-o. Lembra-te dele. Partilha-o.';

  @override
  String get shareInviteWantsToTaste => 'quer provar contigo';

  @override
  String shareInviteFallbackText(String name, String url) {
    return '$name quer provar contigo no Sippd · $url';
  }

  @override
  String shareInviteImageText(String url) {
    return 'Junta-te a mim no Sippd 🍷  $url';
  }

  @override
  String get shareInviteSubject => 'Junta-te a mim no Sippd';

  @override
  String get shareRatingPromptSavedBadge => 'VINHO GUARDADO';

  @override
  String get shareRatingPromptTitle => 'O teu cartão está pronto';

  @override
  String get shareRatingPromptBody =>
      'Envia-o aos teus amigos ou publica na tua story.';

  @override
  String get shareRatingPromptCta => 'Partilhar cartão';

  @override
  String get shareRatingPromptPreparing => 'A preparar…';

  @override
  String get shareRatingPromptDismiss => 'Agora não';

  @override
  String get reviewPromptTitle => 'Estás a gostar do Sippd?';

  @override
  String get reviewPromptBody =>
      'Já avaliaste alguns vinhos. Uma breve avaliação ajuda outros amantes do vinho a descobrir o Sippd.';

  @override
  String get reviewPromptCtaPositive => 'Adoro';

  @override
  String get reviewPromptCtaNegative => 'Ainda não';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClear => 'Limpar';

  @override
  String get commonGotIt => 'Percebi';

  @override
  String get commonOptional => '(opcional)';

  @override
  String get commonOffline => 'Offline';

  @override
  String get commonOfflineMessage =>
      'Estás offline. Volta a ligar-te e tenta novamente.';

  @override
  String get commonNetworkErrorMessage =>
      'Erro de rede. Verifica a tua ligação.';

  @override
  String get commonSomethingWentWrong => 'Algo correu mal.';

  @override
  String get commonErrorViewOfflineTitle => 'Estás offline';

  @override
  String get commonErrorViewOfflineSubtitle =>
      'Volta a ligar-te para carregar isto.';

  @override
  String get commonErrorViewGenericTitle => 'Não foi possível carregar';

  @override
  String get commonErrorViewGenericSubtitle =>
      'Puxa para tentar novamente ou volta mais tarde.';

  @override
  String get commonInlineCouldntSaveRetry =>
      'Não foi possível guardar · Tentar novamente';

  @override
  String get commonInlineOfflineRetry => 'Offline · Tentar novamente';

  @override
  String get commonPhotoDialogCameraTitle => 'Acesso à câmara desativado';

  @override
  String get commonPhotoDialogCameraBody =>
      'O Sippd precisa de acesso à câmara para tirar fotos de vinhos. Ativa-o nas Definições para continuar.';

  @override
  String get commonPhotoDialogPhotosTitle => 'Acesso às fotos desativado';

  @override
  String get commonPhotoDialogPhotosBody =>
      'O Sippd precisa de acesso à biblioteca de fotos para anexar imagens. Ativa-o nas Definições para continuar.';

  @override
  String get commonPhotoErrorSnack =>
      'Não foi possível carregar a foto. Tenta novamente.';

  @override
  String get commonPriceSheetTitle => 'Preço da garrafa';

  @override
  String get commonYearPickerTitle => 'Ano';

  @override
  String get locSheetTitle => 'Onde o bebeste?';

  @override
  String get locSearchHint => 'Procurar local...';

  @override
  String get locNoResults => 'Nenhum local encontrado';

  @override
  String get locSearchFailed => 'Falha na pesquisa';

  @override
  String get locUseMyLocation => 'Usar a minha localização atual';

  @override
  String get locFindingLocation => 'A procurar a tua localização…';

  @override
  String get locReadCurrentFailed =>
      'Não foi possível obter a localização atual';

  @override
  String get locServicesDisabled =>
      'Os serviços de localização estão desativados';

  @override
  String get locPermissionDenied => 'Permissão de localização recusada';

  @override
  String get profileEditTitle => 'Editar perfil';

  @override
  String get profileEditSectionProfile => 'Perfil';

  @override
  String get profileEditFieldUsername => 'Nome de utilizador';

  @override
  String get profileEditFieldDisplayName => 'Nome a apresentar';

  @override
  String profileEditDisplayNameHintWithUsername(String username) {
    return 'p. ex. $username';
  }

  @override
  String get profileEditDisplayNameHintGeneric => 'Como te chamamos?';

  @override
  String get profileEditDisplayNameHelper =>
      'Aparece em grupos e provas. Deixa vazio para usar o teu nome de utilizador.';

  @override
  String get profileEditSectionTaste => 'O teu gosto';

  @override
  String get profileEditSectionTasteSubtitle =>
      'Ajusta o que o Sippd aprende sobre ti. Muda quando quiseres.';

  @override
  String get profileEditAvatarUpdateFailed =>
      'Não foi possível atualizar a foto. Tenta novamente.';

  @override
  String get profileEditUploadFailed => 'Falha ao carregar.';

  @override
  String get profileEditSaveChangesFailed =>
      'Não foi possível guardar as alterações. Tenta novamente.';

  @override
  String get profileAvatarTakePhoto => 'Tirar foto';

  @override
  String get profileAvatarChooseGallery => 'Escolher da galeria';

  @override
  String get profileAvatarRemove => 'Remover foto';

  @override
  String get profileUsernameTooShort => 'Pelo menos 3 caracteres';

  @override
  String get profileUsernameInvalid => 'Apenas letras, números, . e _';

  @override
  String get profileUsernameTaken => 'Já está em uso';

  @override
  String get profileUsernameAvailable => 'Disponível';

  @override
  String get profileUsernameChecking => 'A verificar…';

  @override
  String get profileUsernameHelperIdle =>
      '3–20 caracteres · letras, números, . e _';

  @override
  String get profileChooseUsernameTitle => 'Escolhe um nome de utilizador';

  @override
  String get profileChooseUsernameSubtitle =>
      'Assim os teus amigos encontram-te no Sippd.';

  @override
  String get profileChooseUsernameHint => 'utilizador';

  @override
  String get profileChooseUsernameContinue => 'Continuar';

  @override
  String get profileChooseUsernameSaveFailed =>
      'Não foi possível guardar o nome de utilizador. Tenta novamente.';

  @override
  String get errNetworkDefault =>
      'Sem ligação à internet. A usar dados em cache.';

  @override
  String get errOffline =>
      'Estás offline. Volta a ligar-te para tentar novamente.';

  @override
  String errDatabase(String msg) {
    return 'Erro nos dados locais: $msg';
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
    return '$resource não encontrado.';
  }

  @override
  String get errNotFoundDefault => 'Não encontrado.';

  @override
  String get errUnauthorized => 'Inicia sessão para continuar.';

  @override
  String errServer(int code) {
    return 'Erro do servidor ($code). Tenta novamente.';
  }

  @override
  String get errServerNoCode => 'Erro do servidor. Tenta novamente.';

  @override
  String get errUnknown => 'Algo correu mal. Tenta novamente.';

  @override
  String routeNotFound(String uri) {
    return 'Página não encontrada: $uri';
  }
}

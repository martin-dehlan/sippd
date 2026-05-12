// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsLoadError =>
      'No se pudo cargar la configuración de notificaciones';

  @override
  String get sectionTastings => 'Catas';

  @override
  String get sectionFriends => 'Amigos';

  @override
  String get sectionGroups => 'Grupos';

  @override
  String get tileTastingRemindersLabel => 'Recordatorios de cata';

  @override
  String get tileTastingRemindersSubtitle => 'Aviso antes de empezar una cata';

  @override
  String get tileFriendActivityLabel => 'Actividad de amigos';

  @override
  String get tileFriendActivitySubtitle => 'Solicitudes y aceptaciones';

  @override
  String get tileGroupActivityLabel => 'Actividad de grupo';

  @override
  String get tileGroupActivitySubtitle =>
      'Invitaciones, ingresos y nuevas catas';

  @override
  String get tileGroupWineSharedLabel => 'Vino nuevo compartido';

  @override
  String get tileGroupWineSharedSubtitle =>
      'Cuando un amigo añade un vino a tu grupo';

  @override
  String get hoursPickerLabel => 'Avísame antes';

  @override
  String get hoursPickerHint =>
      'Se aplica a todas las catas próximas — cámbialo cuando quieras.';

  @override
  String hoursPickerOption(int hours) {
    return '${hours}h';
  }

  @override
  String get hoursPickerDebugOption => '30s · debug';

  @override
  String get profileTileLanguageLabel => 'Idioma';

  @override
  String get languageSheetTitle => 'Elegir idioma';

  @override
  String get languageOptionSystem => 'Idioma del sistema';

  @override
  String get onbWelcomeTitle => 'Tu memoria\ndel vino.';

  @override
  String get onbWelcomeBody =>
      'Puntúa los vinos que te gustan. Recuérdalos para siempre. Cata con tus amigos.';

  @override
  String get onbWelcomeAlreadyHaveAccount => '¿Ya tienes cuenta? ';

  @override
  String get onbWelcomeSignIn => 'Inicia sesión';

  @override
  String get onbWhyEyebrow => 'Por qué Sippd';

  @override
  String get onbWhyTitle => 'Hecho para quien\nde verdad bebe vino.';

  @override
  String get onbWhyPrinciple1Headline => 'Foto. Puntúa. Recuerda.';

  @override
  String get onbWhyPrinciple1Line =>
      'Tres toques y lo encuentras el año que viene.';

  @override
  String get onbWhyPrinciple2Headline => 'Catas con amigos.';

  @override
  String get onbWhyPrinciple2Line =>
      'Catas a ciegas, puntuaciones en común. Sin hojas de cálculo.';

  @override
  String get onbWhyPrinciple3Headline => 'Funciona sin conexión.';

  @override
  String get onbWhyPrinciple3Line =>
      'Apunta donde sea. Se sincroniza al volver a casa.';

  @override
  String get onbLevelEyebrow => 'Sobre ti';

  @override
  String get onbLevelTitle => '¿Qué tan a fondo\nestás en el vino?';

  @override
  String get onbLevelSubtitle =>
      'No hay respuesta mala. Adaptamos las sugerencias a tu ritmo.';

  @override
  String get onbLevelBeginnerLabel => 'Principiante';

  @override
  String get onbLevelBeginnerSubtitle => 'Recién empezando';

  @override
  String get onbLevelCuriousLabel => 'Curioso';

  @override
  String get onbLevelCuriousSubtitle => 'Algunos favoritos';

  @override
  String get onbLevelEnthusiastLabel => 'Entusiasta';

  @override
  String get onbLevelEnthusiastSubtitle => 'Sé lo que me gusta';

  @override
  String get onbLevelProLabel => 'Pro';

  @override
  String get onbLevelProSubtitle => 'Nivel sommelier';

  @override
  String get onbFreqEyebrow => 'Tu ritmo';

  @override
  String get onbFreqTitle => '¿Cada cuánto abres\nuna botella?';

  @override
  String get onbFreqWeekly => 'Cada semana';

  @override
  String get onbFreqMonthly => 'Unas veces al mes';

  @override
  String get onbFreqRare => 'De vez en cuando';

  @override
  String get onbGoalsEyebrow => 'Tus objetivos';

  @override
  String get onbGoalsTitle => '¿Qué buscas\nde Sippd?';

  @override
  String get onbGoalsSubtitle =>
      'Elige uno o varios. Puedes cambiarlo después.';

  @override
  String get onbGoalRemember => 'Recordar botellas que me gustan';

  @override
  String get onbGoalDiscover => 'Descubrir nuevos estilos';

  @override
  String get onbGoalSocial => 'Catar con amigos';

  @override
  String get onbGoalValue => 'Llevar lo que pago';

  @override
  String get onbStylesEyebrow => 'Tus estilos';

  @override
  String get onbStylesTitle => '¿A qué\nsueles ir?';

  @override
  String get onbStylesSubtitle =>
      'Marca los que te encajen. Tendremos en cuenta tus elecciones.';

  @override
  String get wineTypeRed => 'Tinto';

  @override
  String get wineTypeWhite => 'Blanco';

  @override
  String get wineTypeRose => 'Rosado';

  @override
  String get wineTypeSparkling => 'Espumoso';

  @override
  String get onbRespEyebrow => 'Una nota nuestra';

  @override
  String get onbRespTitle => 'Bebe menos,\ncata más.';

  @override
  String get onbRespSubtitle =>
      'Sippd es para recordar y puntuar vinos que has disfrutado — no para presionarte a beber más. No hay rachas ni cuotas diarias. A propósito.';

  @override
  String get onbRespHelpBody =>
      'Si el alcohol te está dañando a ti o a alguien cercano,\nhay ayuda gratuita y confidencial.';

  @override
  String get onbRespHelpCta => 'Buscar ayuda';

  @override
  String get onbNameEyebrow => 'Casi listo';

  @override
  String get onbNameTitle => '¿Cómo\nte llamamos?';

  @override
  String get onbNameSubtitle =>
      'Nombre, mote — lo que prefieras. Elige también un icono.';

  @override
  String get onbNameHint => 'Tu nombre';

  @override
  String get onbNameIconLabel => 'Elige tu icono';

  @override
  String get onbNameIconSubtitle => 'Aparece como tu avatar.';

  @override
  String get onbNotifEyebrow => 'Mantente al día';

  @override
  String get onbNotifTitle => 'Que no se te escape\nninguna gran botella.';

  @override
  String get onbNotifSubtitle =>
      'Te avisamos cuando tus amigos empiecen una cata o te inviten a un grupo. Puedes desactivarlo cuando quieras.';

  @override
  String get onbNotifPreview =>
      'Invitaciones a catas\nPuntuaciones de grupo\nActividad de amigos';

  @override
  String get onbNotifTurnOn => 'Activar notificaciones';

  @override
  String get onbNotifNotNow => 'Ahora no';

  @override
  String get onbLoaderAlmostThere => 'CASI LISTO';

  @override
  String get onbLoaderCrafting => 'Creando tu perfil.';

  @override
  String get onbLoaderAllSet => 'Listo.';

  @override
  String get onbLoaderStepMatching => 'Encajando tu gusto';

  @override
  String get onbLoaderStepCurating => 'Curando tus estilos';

  @override
  String get onbLoaderStepSetting => 'Preparando tu diario';

  @override
  String get onbLoaderSeeProfile => 'Ver tu perfil';

  @override
  String get onbLoaderContinue => 'Continuar';

  @override
  String get onbResultsEyebrow => 'TU PERFIL DE GUSTO';

  @override
  String get onbResultsLevelCard => 'Nivel';

  @override
  String get onbResultsFreqCard => 'Frecuencia';

  @override
  String get onbResultsStylesCard => 'Estilos';

  @override
  String get onbResultsGoalsCard => 'Objetivos';

  @override
  String get onbArchSommTitle => 'Sommelier curtido';

  @override
  String get onbArchSommSubtitle =>
      'Conoces tu terroir. Sippd guarda las pruebas.';

  @override
  String get onbArchPalateTitle => 'Paladar fino';

  @override
  String get onbArchPalateSubtitle => 'Caza-matices. Sippd captura el detalle.';

  @override
  String get onbArchRegularTitle => 'Habitual de bodega';

  @override
  String get onbArchRegularSubtitle =>
      'Una botella por semana, opiniones más afiladas cada mes.';

  @override
  String get onbArchDevotedTitle => 'Catador devoto';

  @override
  String get onbArchDevotedSubtitle =>
      'Serio en cada copa. Sippd guarda tus notas.';

  @override
  String get onbArchRedTitle => 'Leal al tinto';

  @override
  String get onbArchRedSubtitle => 'Una uva por copa. Te ayudamos a explorar.';

  @override
  String get onbArchBubbleTitle => 'Cazador de burbujas';

  @override
  String get onbArchBubbleSubtitle =>
      'Burbujas por encima de todo. Sippd marca las buenas.';

  @override
  String get onbArchOpenTitle => 'Paladar abierto';

  @override
  String get onbArchOpenSubtitle =>
      'Tinto, blanco, rosado, espumoso — todos valen. Apúntalos todos.';

  @override
  String get onbArchSteadyTitle => 'Catador constante';

  @override
  String get onbArchSteadySubtitle =>
      'El vino sigue en la rotación. Sippd lleva el hilo.';

  @override
  String get onbArchNowAndThenTitle => 'Catador ocasional';

  @override
  String get onbArchNowAndThenSubtitle =>
      'Vino para los momentos que importan.';

  @override
  String get onbArchOccasionalTitle => 'Copa esporádica';

  @override
  String get onbArchOccasionalSubtitle =>
      'Trago raro, vale la pena recordarlo.';

  @override
  String get onbArchFreshTitle => 'Paladar fresco';

  @override
  String get onbArchFreshSubtitle =>
      'Camino nuevo. Cada botella cuenta desde ya.';

  @override
  String get onbArchCuriousTitle => 'Curioso del vino';

  @override
  String get onbArchCuriousSubtitle => 'Cuéntanos más y tu perfil se afina.';

  @override
  String get onbCtaGetStarted => 'Empezar';

  @override
  String get onbCtaIUnderstand => 'Entendido';

  @override
  String get onbCtaContinue => 'Continuar';

  @override
  String get onbCtaSignInToSave => 'Inicia sesión para guardar';

  @override
  String get onbCtaSaveAndContinue => 'Guardar y continuar';

  @override
  String onbStepCounter(int current, int total) {
    return '$current/$total';
  }

  @override
  String get tasteEditorLevel => 'Nivel';

  @override
  String get tasteEditorFreq => 'Con qué frecuencia';

  @override
  String get tasteEditorStyles => 'Estilos favoritos';

  @override
  String get tasteEditorGoals => 'Qué buscas';

  @override
  String get tasteEditorFreqWeekly => 'Semanal';

  @override
  String get tasteEditorFreqMonthly => 'Mensual';

  @override
  String get tasteEditorFreqRare => 'Raro';

  @override
  String get tasteEditorGoalRemember => 'Recordar';

  @override
  String get tasteEditorGoalDiscover => 'Descubrir';

  @override
  String get tasteEditorGoalSocial => 'Social';

  @override
  String get tasteEditorGoalValue => 'Valor';

  @override
  String get authLoginWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get authLoginCreateAccount => 'Crea tu cuenta';

  @override
  String get authLoginDisplayNameLabel => 'Nombre visible';

  @override
  String get authLoginEmailLabel => 'Correo';

  @override
  String get authLoginPasswordLabel => 'Contraseña';

  @override
  String get authLoginConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get authLoginDisplayNameMin => 'Mín. 2 caracteres';

  @override
  String get authLoginDisplayNameMax => 'Máx. 30 caracteres';

  @override
  String get authLoginEmailInvalid => 'Correo válido obligatorio';

  @override
  String get authLoginPasswordMin => 'Mín. 8 caracteres';

  @override
  String get authLoginPasswordRequired => 'Introduce la contraseña';

  @override
  String get authLoginPasswordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get authLoginForgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get authLoginEnterValidEmailFirst =>
      'Primero pon un correo válido arriba.';

  @override
  String get authLoginSignUpFailedFallback =>
      'No se pudo crear la cuenta. Inténtalo de nuevo.';

  @override
  String get authLoginSignInFailedFallback =>
      'Error al iniciar sesión. Revisa tus datos.';

  @override
  String get authLoginCreateAccountButton => 'Crear cuenta';

  @override
  String get authLoginSignInButton => 'Iniciar sesión';

  @override
  String get authLoginToggleHaveAccount => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get authLoginToggleNoAccount => '¿No tienes cuenta? Regístrate';

  @override
  String get authOrDivider => 'o';

  @override
  String get authGoogleContinue => 'Continuar con Google';

  @override
  String get authGoogleFailed =>
      'Error al iniciar con Google. Inténtalo de nuevo.';

  @override
  String get authConfTitleReset => 'Enlace enviado';

  @override
  String get authConfTitleSignup => 'Revisa tu bandeja';

  @override
  String get authConfIntroReset => 'Enviamos un enlace de restablecimiento a';

  @override
  String get authConfIntroSignup => 'Enviamos un enlace de confirmación a';

  @override
  String get authConfOutroReset => '.\nTócalo para poner una contraseña nueva.';

  @override
  String get authConfOutroSignup => '.\nTócalo para activar tu cuenta.';

  @override
  String get authConfOpenMailApp => 'Abrir app de correo';

  @override
  String get authConfResendEmail => 'Reenviar correo';

  @override
  String get authConfResendSending => 'Enviando…';

  @override
  String authConfResendIn(int seconds) {
    return 'Reenviar en ${seconds}s';
  }

  @override
  String get authConfEmailSent => 'Correo enviado.';

  @override
  String get authConfResendFailedFallback =>
      'No se pudo enviar. Inténtalo en un momento.';

  @override
  String get authConfBackToSignIn => 'Volver al inicio de sesión';

  @override
  String get authResetTitle => 'Pon una contraseña nueva';

  @override
  String get authResetSubtitle =>
      'Elige una contraseña que no hayas usado antes.';

  @override
  String get authResetNewPasswordLabel => 'Nueva contraseña';

  @override
  String get authResetConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get authResetPasswordMin => 'Mín. 6 caracteres';

  @override
  String get authResetPasswordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get authResetFailedFallback =>
      'No se pudo actualizar la contraseña. Inténtalo de nuevo.';

  @override
  String get authResetUpdateButton => 'Actualizar contraseña';

  @override
  String get authResetUpdatedSnack => 'Contraseña actualizada.';

  @override
  String get authProfileGuest => 'Invitado';

  @override
  String get authProfileSectionAccount => 'Cuenta';

  @override
  String get authProfileSectionSupport => 'Soporte';

  @override
  String get authProfileSectionLegal => 'Legal';

  @override
  String get authProfileEditProfile => 'Editar perfil';

  @override
  String get authProfileFriends => 'Amigos';

  @override
  String get authProfileNotifications => 'Notificaciones';

  @override
  String get authProfileCleanupDuplicates => 'Limpiar duplicados';

  @override
  String get authProfileSubscription => 'Suscripción';

  @override
  String get authProfileChangePassword => 'Cambiar contraseña';

  @override
  String get authProfileContactUs => 'Contáctanos';

  @override
  String get authProfileRateSippd => 'Valorar Sippd';

  @override
  String get authProfilePrivacyPolicy => 'Política de privacidad';

  @override
  String get authProfileTermsOfService => 'Términos del servicio';

  @override
  String get authProfileSignOut => 'Cerrar sesión';

  @override
  String get authProfileSignIn => 'Iniciar sesión';

  @override
  String get authProfileDeleteAccount => 'Eliminar cuenta';

  @override
  String get authProfileViewFullStats => 'Ver todas las stats';

  @override
  String get authProfileChangePasswordDialogTitle => '¿Cambiar contraseña?';

  @override
  String authProfileChangePasswordDialogBody(String email) {
    return 'Enviaremos un enlace de restablecimiento a $email. Tócalo desde tu bandeja para poner una contraseña nueva.';
  }

  @override
  String get authProfileCancel => 'Cancelar';

  @override
  String get authProfileSendLink => 'Enviar enlace';

  @override
  String get authProfileSendLinkFailedTitle => 'No se pudo enviar el enlace';

  @override
  String get authProfileSendLinkFailedFallback => 'Inténtalo en un momento.';

  @override
  String get authProfileOk => 'OK';

  @override
  String authProfileCouldNotOpen(String url) {
    return 'No se pudo abrir $url';
  }

  @override
  String get authProfileDeleteDialogTitle => '¿Eliminar cuenta?';

  @override
  String get authProfileDeleteDialogBody =>
      'Esto elimina permanentemente tu perfil, vinos, valoraciones, catas, grupos y amigos. No se puede deshacer.';

  @override
  String get authProfileDeleteTypeConfirm => 'Escribe DELETE para confirmar:';

  @override
  String get authProfileDeleteHint => 'DELETE';

  @override
  String get authProfileDelete => 'Eliminar';

  @override
  String get authProfileDeleteFailedFallback => 'Error al eliminar.';

  @override
  String get winesListSubtitle => 'Tu ranking de vinos';

  @override
  String get winesListSortRating => 'Orden: nota';

  @override
  String get winesListSortRecent => 'Orden: reciente';

  @override
  String get winesListSortName => 'Orden: nombre';

  @override
  String get winesListTooltipStats => 'Tus estadísticas';

  @override
  String get winesListTooltipAddWine => 'Añadir vino';

  @override
  String get winesListErrorLoad => 'No se pudieron cargar los vinos';

  @override
  String get winesEmptyTitle => 'Aún no hay vinos';

  @override
  String get winesEmptyFilteredTitle => 'Ningún vino coincide con el filtro';

  @override
  String get winesEmptyFilteredBody => 'Prueba otro filtro';

  @override
  String get winesEmptyAddWineCta => 'Añadir vino';

  @override
  String get winesAddSaveLabel => 'Guardar vino';

  @override
  String get winesAddDiscardTitle => '¿Descartar el vino?';

  @override
  String get winesAddDiscardBody =>
      'Aún no has guardado este vino. Si sales ahora, perderás los cambios.';

  @override
  String get winesAddDiscardKeepEditing => 'Seguir editando';

  @override
  String get winesAddDiscardConfirm => 'Descartar';

  @override
  String get winesAddDuplicateTitle => 'Parece un duplicado';

  @override
  String winesAddDuplicateBody(String name) {
    return 'Ya registraste «$name» con la misma añada, bodega y uva. ¿Abres el existente o añades uno nuevo igualmente?';
  }

  @override
  String get winesAddDuplicateCancel => 'Cancelar';

  @override
  String get winesAddDuplicateAddAnyway => 'Añadir igual';

  @override
  String get winesAddDuplicateOpenExisting => 'Abrir existente';

  @override
  String get winesDetailNotFound => 'Vino no encontrado';

  @override
  String get winesDetailErrorLoad => 'No se pudo cargar el vino';

  @override
  String get winesDetailMenuCompare => 'Comparar con…';

  @override
  String get winesDetailMenuShareRating => 'Compartir nota';

  @override
  String get winesDetailMenuShareToGroup => 'Compartir al grupo';

  @override
  String get winesDetailMenuEdit => 'Editar vino';

  @override
  String get winesDetailMenuTastingNotesPro => 'Notas de cata (Pro)';

  @override
  String get winesDetailMenuDelete => 'Eliminar vino';

  @override
  String get winesDetailStatRating => 'Nota';

  @override
  String get winesDetailStatRatingUnit => '/ 10';

  @override
  String get winesDetailStatPrice => 'Precio';

  @override
  String get winesDetailStatRegion => 'Región';

  @override
  String get winesDetailStatCountry => 'País';

  @override
  String get winesDetailSectionNotes => 'NOTAS';

  @override
  String get winesDetailSectionPlace => 'LUGAR';

  @override
  String get winesDetailPlaceEmpty => 'Sin lugar';

  @override
  String get winesDetailDeleteTitle => '¿Eliminar vino?';

  @override
  String get winesDetailDeleteBody => 'Esto no se puede deshacer.';

  @override
  String get winesDetailDeleteCancel => 'Cancelar';

  @override
  String get winesDetailDeleteConfirm => 'Eliminar';

  @override
  String get winesEditErrorLoad => 'No se pudo cargar el vino';

  @override
  String get winesEditErrorMemories => 'No se pudieron cargar los recuerdos';

  @override
  String get winesEditNotFound => 'Vino no encontrado';

  @override
  String get winesCleanupTitle => 'Limpiar duplicados';

  @override
  String get winesCleanupErrorLoad => 'No se pudieron cargar los duplicados';

  @override
  String get winesCleanupEmptyTitle => 'No hay duplicados que limpiar';

  @override
  String get winesCleanupEmptyBody =>
      'Tus vinos están ordenados. Detectamos nombres y bodegas casi idénticos de forma automática.';

  @override
  String winesCleanupMatchPct(int pct) {
    return '$pct% coincidencia';
  }

  @override
  String get winesCleanupKeepA => 'Quedarme con A';

  @override
  String get winesCleanupKeepB => 'Quedarme con B';

  @override
  String get winesCleanupSkippedSnack =>
      'Omitido por ahora — volverá a aparecer la próxima vez.';

  @override
  String get winesCleanupDifferentWines => 'Son vinos distintos';

  @override
  String winesCleanupMergeTitle(String name) {
    return '¿Fusionar en «$name»?';
  }

  @override
  String winesCleanupMergeBody(String loser, String keeper) {
    return 'Toda nota, compartido en grupo y estadística que apuntaba a «$loser» pasará a «$keeper». No se puede deshacer.';
  }

  @override
  String get winesCleanupMergeCancel => 'Cancelar';

  @override
  String get winesCleanupMergeConfirm => 'Fusionar';

  @override
  String winesCleanupMergeSuccess(String name) {
    return 'Fusionado en «$name».';
  }

  @override
  String get winesCleanupMergeFailedFallback => 'Error al fusionar.';

  @override
  String get winesCompareHeader => 'COMPARAR';

  @override
  String get winesComparePickerSubtitle => 'Elige el segundo vino.';

  @override
  String get winesComparePickerEmptyTitle => 'Aún no hay otros vinos';

  @override
  String get winesComparePickerEmptyBody =>
      'Añade al menos un vino más para comparar.';

  @override
  String get winesComparePickerErrorFallback =>
      'No se pudieron cargar los vinos.';

  @override
  String get winesCompareMissingSameWine =>
      'Elige un vino diferente para comparar.';

  @override
  String get winesCompareMissingDefault => 'No se pudieron cargar ambos vinos.';

  @override
  String get winesCompareErrorFallback => 'No se pudieron cargar los vinos.';

  @override
  String get winesCompareSectionAtAGlance => 'De un vistazo';

  @override
  String get winesCompareSectionTasting => 'Perfil de cata';

  @override
  String get winesCompareSectionTastingSubtitle =>
      'Cuerpo, tanino, acidez, dulzor, madera, final.';

  @override
  String get winesCompareSectionNotes => 'Notas';

  @override
  String get winesCompareAttrType => 'TIPO';

  @override
  String get winesCompareAttrVintage => 'AÑADA';

  @override
  String get winesCompareAttrGrape => 'UVA';

  @override
  String get winesCompareAttrOrigin => 'ORIGEN';

  @override
  String get winesCompareAttrPrice => 'PRECIO';

  @override
  String get winesCompareNotesEyebrow => 'NOTAS';

  @override
  String winesCompareSlotWineLabel(String slot) {
    return 'VINO $slot';
  }

  @override
  String get winesCompareVs => 'VS';

  @override
  String get winesCompareTastingLockedBody =>
      'Compara cuerpo, tanino, acidez y más, lado a lado.';

  @override
  String get winesCompareTastingPro => 'PRO';

  @override
  String get winesCompareTastingUnlockCta => 'Desbloquear con Pro';

  @override
  String get winesCompareTastingEmpty =>
      'Añade notas de cata a alguno de los vinos para verlas comparadas aquí.';

  @override
  String get winesFormHintName => 'Nombre del vino';

  @override
  String get winesFormSubmitDefault => 'Guardar vino';

  @override
  String get winesFormPhotoLabel => 'Foto';

  @override
  String get winesFormStatRating => 'Nota';

  @override
  String get winesFormStatRatingUnit => '/ 10';

  @override
  String get winesFormStatPrice => 'Precio';

  @override
  String get winesFormStatPriceUnit => 'EUR';

  @override
  String get winesFormStatRegion => 'Región';

  @override
  String get winesFormStatCountry => 'País';

  @override
  String get winesFormChipWinery => 'Bodega';

  @override
  String get winesFormChipGrape => 'Uva';

  @override
  String get winesFormChipYear => 'Año';

  @override
  String get winesFormChipNotes => 'Notas';

  @override
  String get winesFormChipNotesFilled => 'Notas ✓';

  @override
  String get winesFormPlaceTapToAdd => 'Toca para añadir lugar';

  @override
  String get winesFormWineryTitle => 'Bodega';

  @override
  String get winesFormWineryHint => 'p. ej. Château Margaux';

  @override
  String get winesFormNotesTitle => 'Notas de cata';

  @override
  String get winesFormNotesHint => 'Aromas, cuerpo, final…';

  @override
  String get winesFormTypeRed => 'Tinto';

  @override
  String get winesFormTypeWhite => 'Blanco';

  @override
  String get winesFormTypeRose => 'Rosado';

  @override
  String get winesFormTypeSparkling => 'Espumoso';

  @override
  String get winesMemoriesHeader => 'Recuerdos';

  @override
  String winesMemoriesHeaderWithCount(int count) {
    return 'Recuerdos ($count)';
  }

  @override
  String get winesMemoriesAddTile => 'Añadir';

  @override
  String get winesMemoriesRemoveTitle => '¿Eliminar recuerdo?';

  @override
  String get winesMemoriesRemoveBody => 'Esto quitará la foto del vino.';

  @override
  String get winesMemoriesRemoveCancel => 'Cancelar';

  @override
  String get winesMemoriesRemoveConfirm => 'Eliminar';

  @override
  String get winesPhotoSourceTake => 'Hacer foto';

  @override
  String get winesPhotoSourceGallery => 'Elegir de la galería';

  @override
  String get winesGrapeSheetTitle => 'Variedad de uva';

  @override
  String get winesGrapeSheetHint => 'p. ej. Pinot Noir';

  @override
  String get winesGrapeSheetUseFreetextPrefix => 'Usar «';

  @override
  String get winesGrapeSheetUseFreetextSuffix => '» como personalizada';

  @override
  String get winesGrapeSheetEmpty => 'Aún no hay uvas disponibles.';

  @override
  String get winesGrapeSheetErrorLoad =>
      'No se pudo cargar el catálogo de uvas.';

  @override
  String get winesGrapeSheetUseTyped => 'Usar lo que escribí';

  @override
  String get winesRegionSheetTitle => 'Región vinícola';

  @override
  String winesRegionSheetSubtitle(String country) {
    return 'Elige de qué parte de $country es el vino — o sáltatelo si no estás seguro.';
  }

  @override
  String get winesRegionSheetSkip => 'Saltar';

  @override
  String get winesRegionSheetSearchHint => 'Buscar región…';

  @override
  String get winesRegionSheetClear => 'Quitar región';

  @override
  String get winesRegionSheetOther => 'Otra región…';

  @override
  String get winesRegionSheetOtherTitle => 'Región';

  @override
  String get winesRegionSheetOtherHint => 'p. ej. Côtes Catalanes';

  @override
  String get winesCountrySheetSearchHint => 'Buscar país…';

  @override
  String get winesCountrySheetTopHeader => 'Países vinícolas top';

  @override
  String get winesCountrySheetOtherHeader => 'Otros países';

  @override
  String get winesRatingSheetSaveCta => 'Guardar nota';

  @override
  String get winesRatingSheetCancel => 'Cancelar';

  @override
  String get winesRatingSheetSaveError => 'No se pudo guardar.';

  @override
  String get winesRatingHeaderLabel => 'TU NOTA';

  @override
  String get winesRatingChipTasting => 'Notas de cata';

  @override
  String get winesRatingInputLabel => 'Nota';

  @override
  String get winesRatingInputMin => '0';

  @override
  String get winesRatingInputMax => '10';

  @override
  String get winesExpertSheetSaveFirstSnack =>
      'Guarda el vino primero — las notas de cata se enlazan al ID canónico.';

  @override
  String get winesExpertSheetTitle => 'Notas de cata';

  @override
  String get winesExpertSheetSubtitle => 'Percepciones estilo WSET';

  @override
  String get winesExpertSheetSave => 'Guardar';

  @override
  String get winesExpertAxisBody => 'Cuerpo';

  @override
  String get winesExpertAxisTannin => 'Tanino';

  @override
  String get winesExpertAxisAcidity => 'Acidez';

  @override
  String get winesExpertAxisSweetness => 'Dulzor';

  @override
  String get winesExpertAxisOak => 'Madera';

  @override
  String get winesExpertAxisFinish => 'Final';

  @override
  String get winesExpertAxisAromas => 'Aromas';

  @override
  String get winesExpertBodyLow => 'ligero';

  @override
  String get winesExpertBodyHigh => 'pleno';

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
  String get winesExpertSweetnessHigh => 'dulce';

  @override
  String get winesExpertOakLow => 'sin madera';

  @override
  String get winesExpertOakHigh => 'intensa';

  @override
  String get winesExpertFinishShort => 'Corto';

  @override
  String get winesExpertFinishMedium => 'Medio';

  @override
  String get winesExpertFinishLong => 'Largo';

  @override
  String get winesExpertSummaryHeader => 'NOTAS DE CATA';

  @override
  String get winesExpertSummaryAromasHeader => 'AROMAS';

  @override
  String get winesExpertSummaryAxisBody => 'CUERPO';

  @override
  String get winesExpertSummaryAxisTannin => 'TANINO';

  @override
  String get winesExpertSummaryAxisAcidity => 'ACIDEZ';

  @override
  String get winesExpertSummaryAxisSweetness => 'DULZOR';

  @override
  String get winesExpertSummaryAxisOak => 'MADERA';

  @override
  String get winesExpertSummaryAxisFinish => 'FINAL';

  @override
  String get winesExpertDescriptorBody1 => 'muy ligero';

  @override
  String get winesExpertDescriptorBody2 => 'ligero';

  @override
  String get winesExpertDescriptorBody3 => 'medio';

  @override
  String get winesExpertDescriptorBody4 => 'pleno';

  @override
  String get winesExpertDescriptorBody5 => 'pesado';

  @override
  String get winesExpertDescriptorTannin1 => 'sedoso';

  @override
  String get winesExpertDescriptorTannin2 => 'suave';

  @override
  String get winesExpertDescriptorTannin3 => 'medio';

  @override
  String get winesExpertDescriptorTannin4 => 'firme';

  @override
  String get winesExpertDescriptorTannin5 => 'tenso';

  @override
  String get winesExpertDescriptorAcidity1 => 'plano';

  @override
  String get winesExpertDescriptorAcidity2 => 'suave';

  @override
  String get winesExpertDescriptorAcidity3 => 'equilibrado';

  @override
  String get winesExpertDescriptorAcidity4 => 'fresco';

  @override
  String get winesExpertDescriptorAcidity5 => 'agudo';

  @override
  String get winesExpertDescriptorSweetness1 => 'muy seco';

  @override
  String get winesExpertDescriptorSweetness2 => 'seco';

  @override
  String get winesExpertDescriptorSweetness3 => 'semiseco';

  @override
  String get winesExpertDescriptorSweetness4 => 'dulce';

  @override
  String get winesExpertDescriptorSweetness5 => 'muy dulce';

  @override
  String get winesExpertDescriptorOak1 => 'sin madera';

  @override
  String get winesExpertDescriptorOak2 => 'sutil';

  @override
  String get winesExpertDescriptorOak3 => 'presente';

  @override
  String get winesExpertDescriptorOak4 => 'muy presente';

  @override
  String get winesExpertDescriptorOak5 => 'intensa';

  @override
  String get winesExpertDescriptorFinish1 => 'corto';

  @override
  String get winesExpertDescriptorFinish2 => 'medio';

  @override
  String get winesExpertDescriptorFinish3 => 'largo';

  @override
  String get winesCanonicalPromptTitle => '¿El mismo vino?';

  @override
  String get winesCanonicalPromptBody =>
      'Se parece a un vino que ya está en el catálogo. Enlazarlos mantiene tus estadísticas y coincidencias precisas.';

  @override
  String get winesCanonicalPromptInputLabel => 'Lo que estás añadiendo';

  @override
  String get winesCanonicalPromptExistingLabel => 'YA EN EL CATÁLOGO';

  @override
  String get winesCanonicalPromptDifferent => 'No, es un vino diferente';

  @override
  String get winesFriendRatingsHeader => 'AMIGOS QUE LO VALORARON';

  @override
  String get winesFriendRatingsFallback => 'Amigo';

  @override
  String winesFriendRatingsMore(int count) {
    return '+ $count más';
  }

  @override
  String get winesFriendRatingsUnit => '/ 10';

  @override
  String get winesTypeFilterAll => 'Todos';

  @override
  String get winesTypeFilterRed => 'Tinto';

  @override
  String get winesTypeFilterWhite => 'Blanco';

  @override
  String get winesTypeFilterRose => 'Rosado';

  @override
  String get winesTypeFilterSparkling => 'Espumoso';

  @override
  String get winesStatsHeader => 'STATS';

  @override
  String get winesStatsSubtitle => 'Tu viaje por el vino, visualizado';

  @override
  String get winesStatsPreviewBadge => 'VISTA PREVIA';

  @override
  String get winesStatsPreviewHint => 'Lo que verás tras unas pocas notas.';

  @override
  String get winesStatsEmptyEyebrow => 'EMPEZAR';

  @override
  String get winesStatsEmptyTitle => 'Tus stats empiezan con una nota';

  @override
  String get winesStatsEmptyBody =>
      'Valora tu primer vino para dar vida aquí a tu gusto, regiones y valor.';

  @override
  String get winesStatsEmptyCta => 'Valorar un vino';

  @override
  String get winesStatsHeroLabel => 'TU MEDIA';

  @override
  String get winesStatsHeroUnit => '/ 10';

  @override
  String get winesStatsHeroChipPersonal => 'personal';

  @override
  String get winesStatsHeroChipGroup => 'grupo';

  @override
  String get winesStatsHeroChipTasting => 'cata';

  @override
  String get winesStatsSectionTypeBreakdown => 'Reparto por tipo';

  @override
  String get winesStatsSectionTypeBreakdownSubtitle =>
      'Cómo se divide tu gusto entre los cuatro estilos.';

  @override
  String get winesStatsSectionTopRated => 'Mejor valorados';

  @override
  String get winesStatsSectionTopRatedSubtitle => 'Tu podio personal.';

  @override
  String get winesStatsSectionTimeline => 'Línea de tiempo';

  @override
  String get winesStatsSectionTimelineSubtitle =>
      'Mes a mes, los vinos que escribieron tu año.';

  @override
  String get winesStatsSectionPartners => 'Compañeros de cata';

  @override
  String get winesStatsSectionPartnersSubtitle => 'Con quién catas más.';

  @override
  String get winesStatsSectionPrices => 'Precios y valor';

  @override
  String get winesStatsSectionPricesSubtitle =>
      'Suma de precios de botella en tus vinos valorados — no el gasto real de consumo.';

  @override
  String get winesStatsSectionPlaces => 'Dónde has bebido vino';

  @override
  String get winesStatsSectionPlacesSubtitle =>
      'Cada vino que registraste con un lugar.';

  @override
  String get winesStatsSectionRegions => 'Regiones top';

  @override
  String get winesStatsSectionRegionsSubtitle =>
      'De dónde vienen la mayoría de tus botellas.';

  @override
  String get winesStatsPartnersErrorTitle =>
      'No se pudieron cargar los compañeros';

  @override
  String get winesStatsPartnersErrorBody =>
      'Tira para refrescar o vuelve en un momento.';

  @override
  String get winesStatsPartnersEmptyTitle => 'Catar juntos';

  @override
  String get winesStatsPartnersEmptyBody =>
      'Cuando tú y un amigo valoréis el mismo vino en un grupo, aparecerá aquí.';

  @override
  String get winesStatsPartnersCta => 'Abrir grupos';

  @override
  String get winesStatsPriceEmptyTitle => 'Añade un precio';

  @override
  String get winesStatsPriceEmptyBody =>
      'Registra lo que pagaste para desbloquear gasto, precio medio y mejores valores.';

  @override
  String get winesStatsPriceEmptyCta => 'Editar un vino';

  @override
  String get winesStatsPlacesEmptyTitle => 'Añade una ubicación';

  @override
  String get winesStatsPlacesEmptyBody =>
      'Marca un vino con un punto para mapear dónde bebes — bares, cenas, viajes.';

  @override
  String get winesStatsPlacesEmptyCta => 'Editar un vino';

  @override
  String get winesStatsRegionsEmptyTitle => 'Añade una región';

  @override
  String get winesStatsRegionsEmptyBody =>
      'Etiqueta vinos con región o país para ver hacia dónde se inclina tu gusto.';

  @override
  String get winesStatsRegionsEmptyCta => 'Editar un vino';

  @override
  String get winesStatsPartnersHint =>
      'Cuenta vinos valorados juntos en grupos compartidos.';

  @override
  String get winesStatsPartnersFallback => 'Compi de vino';

  @override
  String get winesStatsSpendingLabel => 'PORTFOLIO VALORADO';

  @override
  String winesStatsSpendingSummary(int count, String avg) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vinos con precio',
      one: '1 vino con precio',
    );
    return 'en $_temp0 · media $avg';
  }

  @override
  String get winesStatsSpendingMostExpensive => 'Más caro';

  @override
  String get winesStatsSpendingBestValue => 'Mejor relación';

  @override
  String winesStatsRegionsMore(int count) {
    return '+ $count más';
  }

  @override
  String get winesStatsProLockTitle => 'Desbloquea 3 insights más';

  @override
  String get winesStatsProLockBody =>
      'Mira de dónde vinieron tus botellas, qué gastas y a qué regiones apuestas más.';

  @override
  String get winesStatsProLockPillPrices => 'Precios';

  @override
  String get winesStatsProLockPillWhere => 'Dónde';

  @override
  String get winesStatsProLockPillRegions => 'Regiones top';

  @override
  String get winesStatsProLockCta => 'Desbloquear con Pro';

  @override
  String get winesStatsTimelineEarlierOne => '+ 1 mes anterior';

  @override
  String winesStatsTimelineEarlierMany(int count) {
    return '+ $count meses anteriores';
  }

  @override
  String winesStatsTimelineWines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vinos',
      one: '1 vino',
    );
    return '$_temp0';
  }

  @override
  String winesStatsMapPlacesLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lugares',
      one: '1 lugar',
    );
    return '$_temp0';
  }

  @override
  String get winesStatsMapClose => 'Cerrar';

  @override
  String get winesStatsTypeBreakdownTotalOne => 'vino';

  @override
  String get winesStatsTypeBreakdownTotalMany => 'vinos';

  @override
  String get winesStatsTypeBreakdownMostDrunk => 'Más bebido';

  @override
  String get winesStatsTypeBreakdownTopRated => 'Mejor valorado';

  @override
  String get tastingCreateHeader => 'NUEVA CATA';

  @override
  String get tastingEditHeader => 'EDITAR CATA';

  @override
  String get tastingFieldTitleLabel => 'Título';

  @override
  String get tastingFieldDateLabel => 'Fecha';

  @override
  String get tastingFieldTimeLabel => 'Hora';

  @override
  String get tastingFieldPlaceLabel => 'Lugar';

  @override
  String get tastingFieldDescriptionLabel => 'Descripción';

  @override
  String get tastingFieldTapToAdd => 'Toca para añadir';

  @override
  String get tastingFieldOpenLineupLabel => 'Lineup abierto';

  @override
  String get tastingFieldOpenLineupHint => 'Añade vinos a medida que aparecen';

  @override
  String get tastingTitleSheetTitle => 'Título de la cata';

  @override
  String get tastingTitleSheetHint => 'p. ej. Noche de Barolo';

  @override
  String get tastingDescriptionSheetTitle => 'Descripción';

  @override
  String get tastingDescriptionSheetHint => '¿De qué va?';

  @override
  String get tastingCreateSubmitCta => 'Crear cata';

  @override
  String get tastingEditSubmitCta => 'Guardar cambios';

  @override
  String get tastingCreateFailedSnack => 'No se pudo crear la cata';

  @override
  String get tastingUpdateFailedSnack => 'No se pudo actualizar la cata';

  @override
  String get tastingDetailNotFound => 'Cata no encontrada';

  @override
  String get tastingDetailErrorLoad => 'No se pudo cargar la cata';

  @override
  String get tastingDetailMenuAddToCalendar => 'Añadir al calendario';

  @override
  String get tastingDetailMenuShare => 'Compartir';

  @override
  String get tastingDetailMenuEdit => 'Editar cata';

  @override
  String get tastingDetailMenuCancel => 'Cancelar cata';

  @override
  String get tastingDetailCancelDialogTitle => '¿Cancelar cata?';

  @override
  String get tastingDetailCancelDialogBody => 'Esto la elimina para todos.';

  @override
  String get tastingDetailCancelDialogKeep => 'Mantener';

  @override
  String get tastingDetailCancelDialogConfirm => 'Cancelar';

  @override
  String get tastingDetailEndDialogTitle => '¿Terminar cata?';

  @override
  String get tastingDetailEndDialogBody =>
      'Esto bloquea el recap. Los asistentes pueden seguir añadiendo notas un rato más.';

  @override
  String get tastingDetailEndDialogKeep => 'Seguir';

  @override
  String get tastingDetailEndDialogConfirm => 'Terminar';

  @override
  String get tastingCalendarFailedSnack => 'No se pudo abrir el calendario';

  @override
  String get tastingLifecycleUpcoming => 'PRÓXIMA';

  @override
  String get tastingLifecycleLive => 'EN VIVO';

  @override
  String get tastingLifecycleConcluded => 'TERMINADA';

  @override
  String get tastingLifecycleStartCta => 'Empezar cata';

  @override
  String get tastingLifecycleEndCta => 'Terminar cata';

  @override
  String get tastingDetailSectionPeople => 'Gente';

  @override
  String get tastingDetailSectionPlace => 'Lugar';

  @override
  String get tastingDetailSectionWines => 'VINOS';

  @override
  String get tastingDetailAddWines => 'Añadir vinos';

  @override
  String get tastingDetailNoAttendees => 'Aún no hay nadie invitado.';

  @override
  String get tastingDetailUnknownAttendee => 'Desconocido';

  @override
  String get tastingDetailRsvpYour => 'Tu respuesta';

  @override
  String get tastingDetailRsvpGoing => 'Voy';

  @override
  String get tastingDetailRsvpMaybe => 'Quizá';

  @override
  String get tastingDetailRsvpDeclined => 'No';

  @override
  String tastingDetailAttendeesCountGoing(int count) {
    return '$count van';
  }

  @override
  String tastingDetailAttendeesCountMaybe(int count) {
    return '$count quizá';
  }

  @override
  String tastingDetailAttendeesCountDeclined(int count) {
    return '$count no van';
  }

  @override
  String tastingDetailAttendeesCountPending(int count) {
    return '$count pendientes';
  }

  @override
  String get tastingDetailAttendeesSheetGoing => 'Van';

  @override
  String get tastingDetailAttendeesSheetMaybe => 'Quizá';

  @override
  String get tastingDetailAttendeesSheetDeclined => 'No van';

  @override
  String get tastingDetailAttendeesSheetPending => 'Pendientes';

  @override
  String get tastingEmptyOpenActiveTitle =>
      'El lineup se llena sobre la marcha';

  @override
  String get tastingEmptyOpenActiveBody =>
      'Cualquiera que vaya puede añadir botellas';

  @override
  String get tastingEmptyDefaultTitle => 'Aún no hay vinos en el lineup';

  @override
  String get tastingEmptyOpenUpcomingHost =>
      'Los vinos se podrán añadir cuando empiece la cata';

  @override
  String get tastingEmptyOpenUpcomingGuest =>
      'Los vinos se añadirán durante la cata';

  @override
  String get tastingEmptyPlannedHost =>
      'Toca «Añadir vinos» para montar el lineup';

  @override
  String get tastingEmptyPlannedGuest => 'El anfitrión aún no ha añadido vinos';

  @override
  String get tastingRecapResultsHeader => 'RESULTADOS';

  @override
  String get tastingRecapShareCta => 'Compartir recap';

  @override
  String get tastingRecapTopWineEyebrow => 'VINO DE LA NOCHE';

  @override
  String get tastingRecapEmpty =>
      'Aún no se han enviado puntuaciones para esta cata.';

  @override
  String get tastingRecapRowNoRatings => 'sin puntuaciones';

  @override
  String get tastingRecapGroupFallback => 'Cata de grupo';

  @override
  String get tastingPickerSheetTitle => 'Añadir vinos al lineup';

  @override
  String get tastingPickerEmpty => 'Aún no tienes vinos.';

  @override
  String get tastingPickerErrorFallback => 'No se pudieron cargar los vinos.';

  @override
  String get tastingPickerSubmitDefault => 'Añadir vinos';

  @override
  String tastingPickerSubmitWithCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Añadir $count vinos',
      one: 'Añadir 1 vino',
    );
    return '$_temp0';
  }

  @override
  String get tastingPickerAddedChip => 'Añadido';

  @override
  String get groupListHeader => 'GRUPOS';

  @override
  String get groupListSubtitle => 'Cata en grupo';

  @override
  String get groupListSortRecent => 'Orden: recientes';

  @override
  String get groupListSortName => 'Orden: nombre';

  @override
  String get groupListCreateTooltip => 'Crear grupo';

  @override
  String get groupListJoinTitle => 'Unirse a un grupo';

  @override
  String get groupListJoinSubtitle => 'Introduce un código de invitación';

  @override
  String get groupListJoinNotFound => 'Grupo no encontrado';

  @override
  String get groupListErrorLoad => 'No se pudieron cargar los grupos';

  @override
  String get groupListEmptyTitle => 'Aún no hay grupos';

  @override
  String get groupListEmptyBody =>
      'Crea uno o únete a uno para compartir vinos';

  @override
  String get groupListEmptyCta => 'Crear grupo';

  @override
  String get groupCreateSourceCamera => 'Cámara';

  @override
  String get groupCreateSourceGallery => 'Galería';

  @override
  String get groupCreateSourceRemovePhoto => 'Quitar foto';

  @override
  String get groupCreatePickFailedFallback => 'Selección fallida.';

  @override
  String get groupCreateUploadFailedFallback => 'Error al subir la foto.';

  @override
  String get groupCreateFailedFallback =>
      'No se pudo crear el grupo. Inténtalo de nuevo.';

  @override
  String groupCreateSaveFailed(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get groupCreateTitle => 'Nuevo grupo';

  @override
  String get groupCreateNameHint => 'Nombre del grupo';

  @override
  String get groupCreateSubmit => 'Crear';

  @override
  String get groupJoinTitle => 'Código de invitación';

  @override
  String get groupJoinHint => 'p. ej. a1b2c3d4';

  @override
  String get groupJoinSubmit => 'Unirse';

  @override
  String get groupDetailNotFound => 'Grupo no encontrado';

  @override
  String get groupDetailErrorLoad => 'No se pudo cargar el grupo';

  @override
  String get groupDetailSectionSharedWines => 'Vinos compartidos';

  @override
  String get groupDetailSectionTastings => 'Catas';

  @override
  String get groupDetailActionShare => 'Compartir';

  @override
  String get groupDetailActionPlan => 'Planear';

  @override
  String get groupDetailMenuEdit => 'Editar grupo';

  @override
  String get groupDetailMenuDelete => 'Eliminar grupo';

  @override
  String get groupDetailMenuLeave => 'Salir del grupo';

  @override
  String get groupDetailLeaveDialogTitle => '¿Salir del grupo?';

  @override
  String get groupDetailLeaveDialogBody =>
      'Puedes volver a unirte después con el código de invitación.';

  @override
  String get groupDetailLeaveDialogCancel => 'Cancelar';

  @override
  String get groupDetailLeaveDialogConfirm => 'Salir';

  @override
  String get groupDetailDeleteDialogTitle => '¿Eliminar grupo?';

  @override
  String get groupDetailDeleteDialogBody =>
      'El grupo y sus vinos compartidos se eliminarán para todos.';

  @override
  String get groupDetailDeleteDialogCancel => 'Cancelar';

  @override
  String get groupDetailDeleteDialogConfirm => 'Eliminar';

  @override
  String get groupSettingsEditTitle => 'Editar grupo';

  @override
  String get groupSettingsNameLabel => 'Nombre';

  @override
  String get groupSettingsSourceCamera => 'Cámara';

  @override
  String get groupSettingsSourceGallery => 'Galería';

  @override
  String get groupSettingsRemovePhoto => 'Quitar foto';

  @override
  String get groupSettingsUploadFailedFallback => 'Error al subir.';

  @override
  String get groupSettingsDeleteFailedFallback => 'Error al eliminar.';

  @override
  String groupSettingsSaveFailed(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get groupSettingsSave => 'Guardar';

  @override
  String get groupInviteEyebrow => 'INVITACIÓN';

  @override
  String get groupInviteFriendsEyebrow => 'INVITAR AMIGOS';

  @override
  String get groupInviteCodeCopied => 'Código de invitación copiado';

  @override
  String groupInviteShareMessage(String groupName, String url, String code) {
    return 'Únete a «$groupName» en Sippd 🍷\n\n$url\n\nO introduce el código: $code';
  }

  @override
  String groupInviteShareSubject(String groupName) {
    return 'Únete a $groupName en Sippd';
  }

  @override
  String get groupInviteActionCopy => 'Copiar código';

  @override
  String get groupInviteActionShare => 'Compartir enlace';

  @override
  String get groupInviteFriendsEmpty =>
      'No hay amigos disponibles para invitar.';

  @override
  String get groupInviteFriendsErrorLoad => 'No se pudieron cargar los amigos';

  @override
  String get groupInviteFriendFallback => 'amigo/a';

  @override
  String get groupInviteUnknownName => 'Desconocido';

  @override
  String groupInviteSentSnack(String name) {
    return 'Invitación enviada a $name';
  }

  @override
  String get groupInviteSendFailedFallback =>
      'No se pudo enviar la invitación.';

  @override
  String get groupInvitationsHeader => 'INVITACIONES';

  @override
  String get groupInvitationsInviterFallback => 'Alguien';

  @override
  String groupInvitationsInvitedBy(String name) {
    return 'Invitado por $name';
  }

  @override
  String get groupInvitationsDecline => 'Rechazar';

  @override
  String get groupInvitationsAccept => 'Aceptar';

  @override
  String groupInvitationsJoinedSnack(String name) {
    return 'Te uniste a $name';
  }

  @override
  String get groupInvitationsAcceptFailed => 'No se pudo aceptar la invitación';

  @override
  String get groupMembersCountOne => '1 miembro';

  @override
  String groupMembersCountMany(int count) {
    return '$count miembros';
  }

  @override
  String get groupMembersUnknown => 'Desconocido';

  @override
  String get groupMembersOwnerBadge => 'PROPIETARIO';

  @override
  String get groupWineCarouselDetails => 'Detalles';

  @override
  String get groupWineCarouselEmptyTitle =>
      'Aún no se ha compartido ningún vino';

  @override
  String get groupWineCarouselEmptyBody =>
      'Elige uno de tu colección para empezar la lista.';

  @override
  String get groupWineCarouselEmptyCta => 'Compartir un vino';

  @override
  String get groupWineTypeRed => 'TINTO';

  @override
  String get groupWineTypeWhite => 'BLANCO';

  @override
  String get groupWineTypeRose => 'ROSADO';

  @override
  String get groupWineTypeSparkling => 'ESPUMOSO';

  @override
  String get groupWineRatingSaveFirstSnack =>
      'Guarda primero el vino: las notas se adjuntan a él.';

  @override
  String get groupWineRatingNoCanonical =>
      'El vino aún no tiene identidad canónica. Inténtalo de nuevo.';

  @override
  String get groupWineRatingNoCanonicalShort =>
      'El vino aún no tiene identidad canónica.';

  @override
  String get groupWineRatingNotesHint => 'Añade una nota';

  @override
  String get groupWineRatingOfflineRetry => 'Sin conexión · Reintentar';

  @override
  String get groupWineRatingSaveFailedRetry =>
      'No se pudo guardar · Reintentar';

  @override
  String get groupWineRatingSaved => 'Guardado ✓';

  @override
  String get groupWineRatingSaveCta => 'Guardar valoración';

  @override
  String get groupWineRatingRemoveMine => 'Eliminar mi valoración';

  @override
  String get groupWineRatingUnshareDialogTitle => '¿Quitar del grupo?';

  @override
  String groupWineRatingUnshareDialogBody(String name) {
    return '«$name» se eliminará de este grupo. Las valoraciones de los miembros también se borrarán.';
  }

  @override
  String get groupWineRatingUnshareCancel => 'Cancelar';

  @override
  String get groupWineRatingUnshareConfirm => 'Quitar';

  @override
  String get groupWineRatingMoreTooltip => 'Más';

  @override
  String get groupWineRatingUnshareMenu => 'Quitar del grupo';

  @override
  String get groupWineRatingsTitle => 'Valoraciones';

  @override
  String get groupWineRatingsCountOne => '1 valoración';

  @override
  String groupWineRatingsCountMany(int count) {
    return '$count valoraciones';
  }

  @override
  String get groupWineRatingsAvgLabel => 'med';

  @override
  String get groupWineRatingsBeFirst => 'Sé el primero en valorar';

  @override
  String get groupWineRatingsSoloMe =>
      'Eres el primero · invita a otros a valorar';

  @override
  String get groupShareWineTitle => 'Compartir un vino';

  @override
  String get groupShareWineErrorLoad => 'No se pudieron cargar los vinos.';

  @override
  String get groupShareWineEmpty => 'Aún no tienes vinos.';

  @override
  String get groupShareWineSharedChip => 'Compartido';

  @override
  String get groupShareWineSheetTitle => 'Compartir con un grupo';

  @override
  String get groupShareWineSheetEmpty => 'Aún no estás en ningún grupo.';

  @override
  String get groupShareWineSheetErrorLoad =>
      'No se pudieron cargar los grupos.';

  @override
  String get groupShareWineSheetAlreadyShared => 'Ya compartido';

  @override
  String groupShareWineSheetSharedSnack(String name) {
    return 'Compartido con $name';
  }

  @override
  String get groupShareWineRowMemberOne => '1 miembro';

  @override
  String groupShareWineRowMemberMany(int count) {
    return '$count miembros';
  }

  @override
  String get groupShareWineRowWineOne => '1 vino';

  @override
  String groupShareWineRowWineMany(int count) {
    return '$count vinos';
  }

  @override
  String get groupShareMatchTitle => 'Ya está en este grupo';

  @override
  String groupShareMatchBody(String name) {
    return '«$name» parece un vino que ya ha compartido un miembro. ¿Es el mismo vino?';
  }

  @override
  String get groupShareMatchNone => 'Ninguno · compartir por separado';

  @override
  String get groupShareMatchCancel => 'Cancelar';

  @override
  String groupShareMatchSharedBy(String username) {
    return 'Compartido por @$username';
  }

  @override
  String get groupFriendActionsInvite => 'Invitar a un grupo';

  @override
  String groupFriendActionsPickerTitle(String name) {
    return 'Invitar a $name a…';
  }

  @override
  String get groupFriendActionsPickerEmpty =>
      'No hay grupos para invitar. Crea uno o únete primero.';

  @override
  String get groupFriendActionsPickerErrorLoad =>
      'No se pudieron cargar los grupos';

  @override
  String groupCalendarPastToggle(int count) {
    return 'Catas pasadas ($count)';
  }

  @override
  String get groupCalendarEmptyTitle => 'Aún no hay catas';

  @override
  String get groupCalendarEmptyBody =>
      'Programa una para reunir al grupo en torno a una botella.';

  @override
  String get groupCalendarEmptyCta => 'Planear una cata';

  @override
  String get groupWineDetailSectionRatings => 'VALORACIONES DEL GRUPO';

  @override
  String get groupWineDetailEmptyRatings =>
      'Aún no hay valoraciones del grupo.';

  @override
  String get groupWineDetailStatGroupAvg => 'Media grupo';

  @override
  String get groupWineDetailStatRatings => 'Valoraciones';

  @override
  String get groupWineDetailStatNoRatings => 'Sin valoraciones';

  @override
  String get groupWineDetailStatRegion => 'Región';

  @override
  String get groupWineDetailStatCountry => 'País';

  @override
  String get groupWineDetailStatOrigin => 'Origen';

  @override
  String get groupWineDetailSharedByEyebrow => 'COMPARTIDO POR';

  @override
  String get groupWineDetailSharerFallback => 'alguien';

  @override
  String get groupWineDetailMemberFallback => 'Miembro';

  @override
  String get groupWineDetailRelJustNow => 'ahora mismo';

  @override
  String groupWineDetailRelMinutes(int count) {
    return 'hace ${count}m';
  }

  @override
  String groupWineDetailRelHours(int count) {
    return 'hace ${count}h';
  }

  @override
  String groupWineDetailRelDays(int count) {
    return 'hace ${count}d';
  }

  @override
  String groupWineDetailRelWeeks(int count) {
    return 'hace ${count}sem';
  }

  @override
  String groupWineDetailRelMonths(int count) {
    return 'hace ${count}mes';
  }

  @override
  String groupWineDetailRelYears(int count) {
    return 'hace ${count}a';
  }

  @override
  String get friendsHeader => 'AMIGOS';

  @override
  String get friendsSubtitle => 'Cata con gente que conoces';

  @override
  String get friendsSearchHint => 'Busca por usuario o nombre';

  @override
  String get friendsSearchEmpty => 'No se encontraron usuarios';

  @override
  String get friendsSearchErrorFallback => 'No se pudo cargar la búsqueda.';

  @override
  String get friendsUnknownUser => 'Desconocido';

  @override
  String friendsRequestsHeader(int count) {
    return 'Solicitudes ($count)';
  }

  @override
  String friendsOutgoingHeader(int count) {
    return 'Esperando respuesta ($count)';
  }

  @override
  String get friendsRequestSentLabel => 'Solicitud enviada';

  @override
  String get friendsRequestSubtitle => 'quiere ser tu amigo';

  @override
  String get friendsActionCancel => 'Cancelar';

  @override
  String get friendsActionAdd => 'Añadir';

  @override
  String get friendsCancelDialogFallbackUser => 'este usuario';

  @override
  String get friendsCancelDialogTitle => '¿Cancelar solicitud?';

  @override
  String friendsCancelDialogBody(String name) {
    return '¿Cancelar tu solicitud de amistad a $name?';
  }

  @override
  String get friendsCancelDialogKeep => 'Mantener';

  @override
  String get friendsCancelDialogConfirm => 'Cancelar solicitud';

  @override
  String get friendsListHeader => 'Tus amigos';

  @override
  String get friendsListErrorFallback => 'No se pudieron cargar los amigos.';

  @override
  String get friendsRemoveDialogTitle => '¿Eliminar amigo?';

  @override
  String friendsRemoveDialogBody(String name) {
    return '¿Eliminar a $name de tus amigos?';
  }

  @override
  String get friendsRemoveDialogConfirm => 'Eliminar';

  @override
  String get friendsSendRequestErrorFallback =>
      'No se pudo enviar la solicitud.';

  @override
  String get friendsStatusChipFriend => 'Amigo';

  @override
  String get friendsStatusChipPending => 'Pendiente';

  @override
  String get friendsEmptyDefaultName => 'Un amigo';

  @override
  String get friendsEmptyTitle => 'Trae tu círculo de cata';

  @override
  String get friendsEmptyBody =>
      'Sippd mejora con amigos. Envía una invitación — aterrizan directo en tu perfil.';

  @override
  String get friendsEmptyInviteCta => 'Invitar amigos';

  @override
  String get friendsEmptyFindCta => 'Buscar por usuario';

  @override
  String get friendsProfileNotFound => 'Perfil no encontrado';

  @override
  String get friendsProfileErrorLoad => 'No se pudo cargar el perfil';

  @override
  String get friendsProfileNameFallback => 'Amigo';

  @override
  String get friendsProfileRecentWinesHeader => 'VINOS RECIENTES';

  @override
  String get friendsProfileWinesErrorLoad => 'No se pudieron cargar los vinos';

  @override
  String get friendsProfileStatWines => 'Vinos';

  @override
  String get friendsProfileStatAvg => 'Media';

  @override
  String get friendsProfileStatCountry => 'País';

  @override
  String get friendsProfileStatCountries => 'Países';
}

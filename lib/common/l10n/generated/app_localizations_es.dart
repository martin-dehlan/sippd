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
}

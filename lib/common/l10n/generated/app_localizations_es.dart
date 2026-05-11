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
}

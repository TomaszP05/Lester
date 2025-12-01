// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Lester';

  @override
  String get settings => 'Configuración';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get sendTestNotification => 'Enviar notificación de prueba';

  @override
  String get testNotificationSubtitle => 'Prueba la configuración de notificaciones';

  @override
  String get testNotificationSent => '✅ ¡Notificación de prueba enviada!';

  @override
  String testNotificationError(Object error) {
    return '❌ Error: $error';
  }

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Francés';

  @override
  String get home => 'Inicio';

  @override
  String get journal => 'Diario';

  @override
  String get challenges => 'Desafíos';

  @override
  String get mood => 'Ánimo';

  @override
  String get weeklyReflection => 'Reflexión semanal';

  @override
  String get reflectionSaved => 'Reflexión guardada';

  @override
  String get reflectionSummary => 'Has sido más amable al ayudar a otros y a ti mismo directamente.';

  @override
  String get ok => 'OK';

  @override
  String get reflectionKindnessPrompt => '💭 ¿Qué acto de bondad te hizo sentir orgulloso esta semana?';

  @override
  String get writeAnswerHere => 'Escribe tu respuesta aquí...';

  @override
  String get reflectionMoodPrompt => '😌 ¿Cómo fue tu estado de ánimo general esta semana?';

  @override
  String get reflectionProductivityPrompt => '📈 ¿Cómo calificarías tu productividad general esta semana?';

  @override
  String get submitReflection => 'Enviar reflexión';

  @override
  String selectMoodTitle(Object type) {
    return 'Selecciona tu estado de ánimo $type';
  }

  @override
  String get moodLabelHappy => '😊 Feliz';

  @override
  String get moodLabelNeutral => '😐 Neutral';

  @override
  String get moodLabelSad => '😔 Triste';

  @override
  String get moodLabelAngry => '😡 Enojado';

  @override
  String get moodLabelTired => '😴 Cansado';

  @override
  String get moodLabelRelaxed => '😌 Relajado';

  @override
  String get moodLabelShocked => '😲 Sorprendido';

  @override
  String get moodLabelConfused => '😕 Confundido';

  @override
  String selectedMood(Object mood) {
    return 'Has seleccionado: $mood';
  }

  @override
  String get fillAllMoods => 'Por favor selecciona todos los estados de ánimo antes de guardar.';

  @override
  String get moodSaved => '¡Ánimo guardado exitosamente! 💾';

  @override
  String get noMoodsSaved => '¡Aún no hay ánimos guardados! 😴';

  @override
  String get savedMoods => 'Ánimos guardados';

  @override
  String get close => 'Cerrar';

  @override
  String get trackYourMood => 'Registra tu ánimo 🌸';

  @override
  String get selectOverallMood => 'Seleccionar ánimo general';

  @override
  String get selectMoodBefore => 'Seleccionar ánimo antes del desafío';

  @override
  String get selectMoodAfter => 'Seleccionar ánimo después del desafío';

  @override
  String overallMood(Object mood) {
    return 'Ánimo general: $mood';
  }

  @override
  String beforeMood(Object mood) {
    return 'Ánimo antes: $mood';
  }

  @override
  String afterMood(Object mood) {
    return 'Ánimo después: $mood';
  }

  @override
  String get saveMood => 'Guardar ánimo';

  @override
  String get viewSavedMoods => 'Ver ánimos guardados';

  @override
  String get moodTracker => 'Rastreador de ánimo';

  @override
  String get dailyInsightsTitle => 'Ideas diarias';

  @override
  String get todaysChallengeTitle => 'Desafío de hoy';

  @override
  String get noChallengeMessage => 'No hay desafío disponible para hoy';

  @override
  String get weeklyReflectionTitle => 'Cuestionario de reflexión semanal';

  @override
  String get startWeeklyReflection => 'Comenzar reflexión semanal';

  @override
  String get welcomeTitle => '¡Bienvenido a Lester 🌸!';

  @override
  String get welcomeSubtitle => 'Registremos cómo te sientes';

  @override
  String get quoteLoadError => 'No se pudo cargar la cita. Por favor, inténtalo de nuevo.';

  @override
  String get weatherLoadError => 'No se pudo cargar el clima. Por favor, inténtalo de nuevo.';

  @override
  String get quoteFallback => 'Mantente positivo y sigue adelante.';

  @override
  String get unknownAuthor => 'Desconocido';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get daily_challenge_1_name => 'Desafío Diario 1';

  @override
  String get daily_challenge_1_description => 'Sonríe a cinco personas hoy';

  @override
  String get daily_challenge_2_name => 'Desafío Diario 2';

  @override
  String get daily_challenge_2_description => 'Envía un mensaje positivo a alguien que te importe';

  @override
  String get daily_challenge_3_name => 'Desafío Diario 3';

  @override
  String get daily_challenge_3_description => 'Da un paseo corto al aire libre y aprecia la naturaleza';

  @override
  String get daily_challenge_4_name => 'Desafío Diario 4';

  @override
  String get daily_challenge_4_description => 'Haz una tarea doméstica que has estado posponiendo';

  @override
  String get daily_challenge_5_name => 'Desafío Diario 5';

  @override
  String get daily_challenge_5_description => 'Haz un cumplido sincero a alguien';

  @override
  String get daily_challenge_6_name => 'Desafío Diario 6';

  @override
  String get daily_challenge_6_description => 'Bebe al menos 8 vasos de agua hoy';

  @override
  String get daily_challenge_7_name => 'Desafío Diario 7';

  @override
  String get daily_challenge_7_description => 'Escribe una nota de agradecimiento a un amigo';

  @override
  String get daily_challenge_8_name => 'Desafío Diario 8';

  @override
  String get daily_challenge_8_description => 'Sujeta la puerta a alguien';

  @override
  String get daily_challenge_9_name => 'Desafío Diario 9';

  @override
  String get daily_challenge_9_description => 'Haz un cumplido a un desconocido';

  @override
  String get daily_challenge_10_name => 'Desafío Diario 10';

  @override
  String get daily_challenge_10_description => '¡Toma una foto de una flor y súbela!';

  @override
  String get daily_challenge_11_name => 'Desafío Diario 11';

  @override
  String get daily_challenge_11_description => 'Escucha tu canción favorita y no hagas nada más';

  @override
  String get daily_challenge_12_name => 'Desafío Diario 12';

  @override
  String get daily_challenge_12_description => 'Prueba una nueva comida o bebida que nunca antes habías tomado';

  @override
  String get daily_challenge_13_name => 'Desafío Diario 13';

  @override
  String get daily_challenge_13_description => 'Envía un mensaje amable a un familiar';

  @override
  String get daily_challenge_14_name => 'Desafío Diario 14';

  @override
  String get daily_challenge_14_description => 'Recoge un trozo de basura que encuentres fuera';

  @override
  String get daily_challenge_15_name => 'Desafío Diario 15';

  @override
  String get daily_challenge_15_description => 'Dedica 10 minutos a estirar o meditar';

  @override
  String get daily_challenge_16_name => 'Desafío Diario 16';

  @override
  String get daily_challenge_16_description => 'Dona un artículo que ya no uses';

  @override
  String get daily_challenge_17_name => 'Desafío Diario 17';

  @override
  String get daily_challenge_17_description => 'Haz un cumplido genuino a alguien';

  @override
  String get daily_challenge_18_name => 'Desafío Diario 18';

  @override
  String get daily_challenge_18_description => 'Escribe tres cosas por las que estás agradecido/a';

  @override
  String get daily_challenge_19_name => 'Desafío Diario 19';

  @override
  String get daily_challenge_19_description => 'Llama o haz una videollamada con un ser querido';

  @override
  String get daily_challenge_20_name => 'Desafío Diario 20';

  @override
  String get daily_challenge_20_description => 'Comparte una cita inspiradora en las redes sociales';

  @override
  String get daily_challenge_21_name => 'Desafío Diario 21';

  @override
  String get daily_challenge_21_description => 'Toma una foto de algo que te haga feliz';

  @override
  String get daily_challenge_22_name => 'Desafío Diario 22';

  @override
  String get daily_challenge_22_description => 'Pasa una hora sin tu teléfono u ordenador';

  @override
  String get daily_challenge_23_name => 'Desafío Diario 23';

  @override
  String get daily_challenge_23_description => 'Ayuda a alguien sin esperar nada a cambio';

  @override
  String get daily_challenge_24_name => 'Desafío Diario 24';

  @override
  String get daily_challenge_24_description => 'Cocina o prepara una comida saludable';

  @override
  String get daily_challenge_25_name => 'Desafío Diario 25';

  @override
  String get daily_challenge_25_description => 'Deja una reseña positiva para un pequeño negocio';

  @override
  String get daily_challenge_26_name => 'Desafío Diario 26';

  @override
  String get daily_challenge_26_description => 'Dedica 15 minutos a escribir en un diario o a reflexionar';

  @override
  String get daily_challenge_27_name => 'Desafío Diario 27';

  @override
  String get daily_challenge_27_description => 'Di «gracias» a alguien que te ayude hoy';

  @override
  String get daily_challenge_28_name => 'Desafío Diario 28';

  @override
  String get daily_challenge_28_description => 'Lee o escucha algo edificante';

  @override
  String get daily_challenge_29_name => 'Desafío Diario 29';

  @override
  String get daily_challenge_29_description => 'Haz un acto de bondad al azar de forma anónima';

  @override
  String get daily_challenge_30_name => 'Desafío Diario 30';

  @override
  String get daily_challenge_30_description => 'Dedica 10 minutos a organizar tu espacio';

  @override
  String get daily_challenge_31_name => 'Desafío Diario 31';

  @override
  String get daily_challenge_31_description => 'Reflexiona sobre el mes: ¿de qué estás orgulloso/a?';
}

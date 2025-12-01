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
}

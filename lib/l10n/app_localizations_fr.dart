// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Lester';

  @override
  String get settings => 'Paramètres';

  @override
  String get notifications => 'Notifications';

  @override
  String get sendTestNotification => 'Envoyer une notification de test';

  @override
  String get testNotificationSubtitle => 'Testez vos paramètres de notification';

  @override
  String get testNotificationSent => '✅ Notification de test envoyée !';

  @override
  String testNotificationError(Object error) {
    return '❌ Erreur : $error';
  }

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get english => 'Anglais';

  @override
  String get spanish => 'Espagnol';

  @override
  String get french => 'Français';

  @override
  String get home => 'Accueil';

  @override
  String get journal => 'Journal';

  @override
  String get challenges => 'Défis';

  @override
  String get mood => 'Humeur';

  @override
  String get weeklyReflection => 'Réflexion hebdomadaire';

  @override
  String get reflectionSaved => 'Réflexion enregistrée';

  @override
  String get reflectionSummary => 'Vous avez été le plus gentil en aidant les autres et vous-même directement.';

  @override
  String get ok => 'OK';

  @override
  String get reflectionKindnessPrompt => '💭 Quel acte de gentillesse vous a rendu fier cette semaine ?';

  @override
  String get writeAnswerHere => 'Écrivez votre réponse ici...';

  @override
  String get reflectionMoodPrompt => '😌 Quel a été votre état d\'esprit général cette semaine ?';

  @override
  String get reflectionProductivityPrompt => '📈 Comment évalueriez-vous votre productivité générale cette semaine ?';

  @override
  String get submitReflection => 'Soumettre la réflexion';

  @override
  String selectMoodTitle(Object type) {
    return 'Sélectionnez votre humeur $type';
  }

  @override
  String get moodLabelHappy => '😊 Heureux';

  @override
  String get moodLabelNeutral => '😐 Neutre';

  @override
  String get moodLabelSad => '😔 Triste';

  @override
  String get moodLabelAngry => '😡 En colère';

  @override
  String get moodLabelTired => '😴 Fatigué';

  @override
  String get moodLabelRelaxed => '😌 Détendu';

  @override
  String get moodLabelShocked => '😲 Choqué';

  @override
  String get moodLabelConfused => '😕 Confus';

  @override
  String selectedMood(Object mood) {
    return 'Vous avez sélectionné : $mood';
  }

  @override
  String get fillAllMoods => 'Veuillez sélectionner toutes les humeurs avant d\'enregistrer.';

  @override
  String get moodSaved => 'Humeur enregistrée avec succès ! 💾';

  @override
  String get noMoodsSaved => 'Aucune humeur enregistrée pour le moment ! 😴';

  @override
  String get savedMoods => 'Humeurs enregistrées';

  @override
  String get close => 'Fermer';

  @override
  String get trackYourMood => 'Suivez votre humeur 🌸';

  @override
  String get selectOverallMood => 'Sélectionner l\'humeur générale';

  @override
  String get selectMoodBefore => 'Sélectionner l\'humeur avant le défi';

  @override
  String get selectMoodAfter => 'Sélectionner l\'humeur après le défi';

  @override
  String overallMood(Object mood) {
    return 'Humeur générale : $mood';
  }

  @override
  String beforeMood(Object mood) {
    return 'Humeur avant : $mood';
  }

  @override
  String afterMood(Object mood) {
    return 'Humeur après : $mood';
  }

  @override
  String get saveMood => 'Enregistrer l\'humeur';

  @override
  String get viewSavedMoods => 'Voir les humeurs enregistrées';

  @override
  String get moodTracker => 'Suivi de l\'humeur';

  @override
  String get dailyInsightsTitle => 'Aperçus quotidiens';

  @override
  String get todaysChallengeTitle => 'Défi du jour';

  @override
  String get noChallengeMessage => 'Aucun défi disponible pour aujourd\'hui';

  @override
  String get weeklyReflectionTitle => 'Quiz de réflexion hebdomadaire';

  @override
  String get startWeeklyReflection => 'Commencer la réflexion hebdomadaire';

  @override
  String get welcomeTitle => 'Bienvenue chez Lester 🌸!';

  @override
  String get welcomeSubtitle => 'Enregistrons comment vous vous sentez~ 🧧';

  @override
  String get quoteLoadError => 'Impossible de charger la citation. Veuillez réessayer.';

  @override
  String get weatherLoadError => 'Impossible de charger la météo. Veuillez réessayer.';

  @override
  String get quoteFallback => 'Restez positif et continuez.';

  @override
  String get unknownAuthor => 'Inconnu';

  @override
  String get tryAgain => 'Réessayer';
}

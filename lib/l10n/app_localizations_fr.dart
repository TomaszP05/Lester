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
  String get welcomeSubtitle => 'Enregistrons comment vous vous sentez';

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

  @override
  String get daily_challenge_1_name => 'Défi Quotidien 1';

  @override
  String get daily_challenge_1_description => 'Souris à cinq personnes aujourd\'hui';

  @override
  String get daily_challenge_2_name => 'Défi Quotidien 2';

  @override
  String get daily_challenge_2_description => 'Envoie un message positif à quelqu\'un qui t\'est cher';

  @override
  String get daily_challenge_3_name => 'Défi Quotidien 3';

  @override
  String get daily_challenge_3_description => 'Fais une petite promenade dehors et apprécie la nature';

  @override
  String get daily_challenge_4_name => 'Défi Quotidien 4';

  @override
  String get daily_challenge_4_description => 'Fais une tâche ménagère que tu as repoussée';

  @override
  String get daily_challenge_5_name => 'Défi Quotidien 5';

  @override
  String get daily_challenge_5_description => 'Fais un compliment sincère à quelqu\'un';

  @override
  String get daily_challenge_6_name => 'Défi Quotidien 6';

  @override
  String get daily_challenge_6_description => 'Bois au moins 8 verres d\'eau aujourd\'hui';

  @override
  String get daily_challenge_7_name => 'Défi Quotidien 7';

  @override
  String get daily_challenge_7_description => 'Écris un mot de remerciement à un ami';

  @override
  String get daily_challenge_8_name => 'Défi Quotidien 8';

  @override
  String get daily_challenge_8_description => 'Tiens la porte à quelqu\'un';

  @override
  String get daily_challenge_9_name => 'Défi Quotidien 9';

  @override
  String get daily_challenge_9_description => 'Fais un compliment à un inconnu';

  @override
  String get daily_challenge_10_name => 'Défi Quotidien 10';

  @override
  String get daily_challenge_10_description => 'Prends une photo de fleur et télécharge une photo !';

  @override
  String get daily_challenge_11_name => 'Défi Quotidien 11';

  @override
  String get daily_challenge_11_description => 'Écoute ta chanson préférée sans rien faire d\'autre';

  @override
  String get daily_challenge_12_name => 'Défi Quotidien 12';

  @override
  String get daily_challenge_12_description => 'Essaie un nouvel aliment ou une nouvelle boisson que tu n\'as jamais goûté(e)';

  @override
  String get daily_challenge_13_name => 'Défi Quotidien 13';

  @override
  String get daily_challenge_13_description => 'Envoie un gentil message à un membre de ta famille';

  @override
  String get daily_challenge_14_name => 'Défi Quotidien 14';

  @override
  String get daily_challenge_14_description => 'Ramasse un déchet que tu trouves dehors';

  @override
  String get daily_challenge_15_name => 'Défi Quotidien 15';

  @override
  String get daily_challenge_15_description => 'Passe 10 minutes à t\'étirer ou à méditer';

  @override
  String get daily_challenge_16_name => 'Défi Quotidien 16';

  @override
  String get daily_challenge_16_description => 'Fais don d\'un objet que tu n\'utilises plus';

  @override
  String get daily_challenge_17_name => 'Défi Quotidien 17';

  @override
  String get daily_challenge_17_description => 'Fais un compliment sincère à quelqu\'un';

  @override
  String get daily_challenge_18_name => 'Défi Quotidien 18';

  @override
  String get daily_challenge_18_description => 'Écris trois choses pour lesquelles tu es reconnaissant(e)';

  @override
  String get daily_challenge_19_name => 'Défi Quotidien 19';

  @override
  String get daily_challenge_19_description => 'Appelle ou fais un appel vidéo avec un être cher';

  @override
  String get daily_challenge_20_name => 'Défi Quotidien 20';

  @override
  String get daily_challenge_20_description => 'Partage une citation inspirante sur les réseaux sociaux';

  @override
  String get daily_challenge_21_name => 'Défi Quotidien 21';

  @override
  String get daily_challenge_21_description => 'Prends en photo quelque chose qui te rend heureux/heureuse';

  @override
  String get daily_challenge_22_name => 'Défi Quotidien 22';

  @override
  String get daily_challenge_22_description => 'Passe une heure sans ton téléphone ni ton ordinateur';

  @override
  String get daily_challenge_23_name => 'Défi Quotidien 23';

  @override
  String get daily_challenge_23_description => 'Aide quelqu\'un sans rien attendre en retour';

  @override
  String get daily_challenge_24_name => 'Défi Quotidien 24';

  @override
  String get daily_challenge_24_description => 'Cuisine ou prépare un repas sain';

  @override
  String get daily_challenge_25_name => 'Défi Quotidien 25';

  @override
  String get daily_challenge_25_description => 'Laisse un avis positif pour une petite entreprise';

  @override
  String get daily_challenge_26_name => 'Défi Quotidien 26';

  @override
  String get daily_challenge_26_description => 'Passe 15 minutes à écrire dans un journal ou à réfléchir';

  @override
  String get daily_challenge_27_name => 'Défi Quotidien 27';

  @override
  String get daily_challenge_27_description => 'Dis « merci » à quelqu\'un qui t\'aide aujourd\'hui';

  @override
  String get daily_challenge_28_name => 'Défi Quotidien 28';

  @override
  String get daily_challenge_28_description => 'Lis ou écoute quelque chose d\'édifiant';

  @override
  String get daily_challenge_29_name => 'Défi Quotidien 29';

  @override
  String get daily_challenge_29_description => 'Fais un acte de gentillesse au hasard de manière anonyme';

  @override
  String get daily_challenge_30_name => 'Défi Quotidien 30';

  @override
  String get daily_challenge_30_description => 'Passe 10 minutes à organiser ton espace';

  @override
  String get daily_challenge_31_name => 'Défi Quotidien 31';

  @override
  String get daily_challenge_31_description => 'Réfléchis au mois – de quoi es-tu fier/fière ?';
}

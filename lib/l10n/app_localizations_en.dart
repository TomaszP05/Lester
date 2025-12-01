// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lester';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get sendTestNotification => 'Send Test Notification';

  @override
  String get testNotificationSubtitle => 'Test your notification settings';

  @override
  String get testNotificationSent => '✅ Test notification sent!';

  @override
  String testNotificationError(Object error) {
    return '❌ Error: $error';
  }

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get french => 'French';

  @override
  String get home => 'Home';

  @override
  String get journal => 'Journal';

  @override
  String get challenges => 'Challenges';

  @override
  String get mood => 'Mood';

  @override
  String get weeklyReflection => 'Weekly Reflection';

  @override
  String get reflectionSaved => 'Reflection Saved';

  @override
  String get reflectionSummary => 'You\'ve been most kind when helping others and yourself directly.';

  @override
  String get ok => 'OK';

  @override
  String get reflectionKindnessPrompt => '💭 What act of kindness made you feel proud this week?';

  @override
  String get writeAnswerHere => 'Write your answer here...';

  @override
  String get reflectionMoodPrompt => '😌 How was your overall mood this week?';

  @override
  String get reflectionProductivityPrompt => '📈 How would you rate your overall productivity this week?';

  @override
  String get submitReflection => 'Submit Reflection';

  @override
  String selectMoodTitle(Object type) {
    return 'Select your $type mood';
  }

  @override
  String get moodLabelHappy => '😊 Happy';

  @override
  String get moodLabelNeutral => '😐 Neutral';

  @override
  String get moodLabelSad => '😔 Sad';

  @override
  String get moodLabelAngry => '😡 Angry';

  @override
  String get moodLabelTired => '😴 Tired';

  @override
  String get moodLabelRelaxed => '😌 Relaxed';

  @override
  String get moodLabelShocked => '😲 Shocked';

  @override
  String get moodLabelConfused => '😕 Confused';

  @override
  String selectedMood(Object mood) {
    return 'You selected: $mood';
  }

  @override
  String get fillAllMoods => 'Please select all moods before saving.';

  @override
  String get moodSaved => 'Mood saved successfully! 💾';

  @override
  String get noMoodsSaved => 'No moods saved yet! 😴';

  @override
  String get savedMoods => 'Saved Moods';

  @override
  String get close => 'Close';

  @override
  String get trackYourMood => 'Track Your Mood 🌸';

  @override
  String get selectOverallMood => 'Select Overall Mood';

  @override
  String get selectMoodBefore => 'Select Mood Before Challenge';

  @override
  String get selectMoodAfter => 'Select Mood After Challenge';

  @override
  String overallMood(Object mood) {
    return 'Overall Mood: $mood';
  }

  @override
  String beforeMood(Object mood) {
    return 'Before Mood: $mood';
  }

  @override
  String afterMood(Object mood) {
    return 'After Mood: $mood';
  }

  @override
  String get saveMood => 'Save Mood';

  @override
  String get viewSavedMoods => 'View Saved Moods';

  @override
  String get moodTracker => 'Mood Tracker';

  @override
  String get dailyInsightsTitle => 'Daily Insights';

  @override
  String get todaysChallengeTitle => 'Today\'s Challenge';

  @override
  String get noChallengeMessage => 'No challenge available for today';

  @override
  String get weeklyReflectionTitle => 'Weekly Reflection Quiz';

  @override
  String get startWeeklyReflection => 'Start Weekly Reflection';

  @override
  String get welcomeTitle => 'Welcome to Lester 🌸!';

  @override
  String get welcomeSubtitle => 'Let\'s log how you\'re feeling';

  @override
  String get quoteLoadError => 'Could not load quote. Please try again.';

  @override
  String get weatherLoadError => 'Could not load weather. Please try again.';

  @override
  String get quoteFallback => 'Stay positive and keep going.';

  @override
  String get unknownAuthor => 'Unknown';

  @override
  String get tryAgain => 'Try again';
}

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

  @override
  String get daily_challenge_1_name => 'Daily Challenge 1';

  @override
  String get daily_challenge_1_description => 'Smile at five people today';

  @override
  String get daily_challenge_2_name => 'Daily Challenge 2';

  @override
  String get daily_challenge_2_description => 'Send a positive message to someone you care about';

  @override
  String get daily_challenge_3_name => 'Daily Challenge 3';

  @override
  String get daily_challenge_3_description => 'Take a short walk outside and appreciate nature';

  @override
  String get daily_challenge_4_name => 'Daily Challenge 4';

  @override
  String get daily_challenge_4_description => 'Do one household task you’ve been putting off';

  @override
  String get daily_challenge_5_name => 'Daily Challenge 5';

  @override
  String get daily_challenge_5_description => 'Compliment someone sincerely';

  @override
  String get daily_challenge_6_name => 'Daily Challenge 6';

  @override
  String get daily_challenge_6_description => 'Drink at least 8 glasses of water today';

  @override
  String get daily_challenge_7_name => 'Daily Challenge 7';

  @override
  String get daily_challenge_7_description => 'Write a thank you note to a friend';

  @override
  String get daily_challenge_8_name => 'Daily Challenge 8';

  @override
  String get daily_challenge_8_description => 'Hold the door open for someone';

  @override
  String get daily_challenge_9_name => 'Daily Challenge 9';

  @override
  String get daily_challenge_9_description => 'Compliment a stranger';

  @override
  String get daily_challenge_10_name => 'Daily Challenge 10';

  @override
  String get daily_challenge_10_description => 'Take a picture of a flower and upload a picture!';

  @override
  String get daily_challenge_11_name => 'Daily Challenge 11';

  @override
  String get daily_challenge_11_description => 'Listen to your favorite song and do nothing else';

  @override
  String get daily_challenge_12_name => 'Daily Challenge 12';

  @override
  String get daily_challenge_12_description => 'Try a new food or drink you’ve never had before';

  @override
  String get daily_challenge_13_name => 'Daily Challenge 13';

  @override
  String get daily_challenge_13_description => 'Send a kind text to a family member';

  @override
  String get daily_challenge_14_name => 'Daily Challenge 14';

  @override
  String get daily_challenge_14_description => 'Pick up a piece of litter you find outside';

  @override
  String get daily_challenge_15_name => 'Daily Challenge 15';

  @override
  String get daily_challenge_15_description => 'Spend 10 minutes stretching or meditating';

  @override
  String get daily_challenge_16_name => 'Daily Challenge 16';

  @override
  String get daily_challenge_16_description => 'Donate an item you no longer use';

  @override
  String get daily_challenge_17_name => 'Daily Challenge 17';

  @override
  String get daily_challenge_17_description => 'Give someone a genuine compliment';

  @override
  String get daily_challenge_18_name => 'Daily Challenge 18';

  @override
  String get daily_challenge_18_description => 'Write down three things you’re grateful for';

  @override
  String get daily_challenge_19_name => 'Daily Challenge 19';

  @override
  String get daily_challenge_19_description => 'Call or video chat with a loved one';

  @override
  String get daily_challenge_20_name => 'Daily Challenge 20';

  @override
  String get daily_challenge_20_description => 'Share an inspiring quote on social media';

  @override
  String get daily_challenge_21_name => 'Daily Challenge 21';

  @override
  String get daily_challenge_21_description => 'Take a photo of something that makes you happy';

  @override
  String get daily_challenge_22_name => 'Daily Challenge 22';

  @override
  String get daily_challenge_22_description => 'Spend one hour without your phone or computer';

  @override
  String get daily_challenge_23_name => 'Daily Challenge 23';

  @override
  String get daily_challenge_23_description => 'Help someone without expecting anything in return';

  @override
  String get daily_challenge_24_name => 'Daily Challenge 24';

  @override
  String get daily_challenge_24_description => 'Cook or prepare a healthy meal';

  @override
  String get daily_challenge_25_name => 'Daily Challenge 25';

  @override
  String get daily_challenge_25_description => 'Leave a positive review for a small business';

  @override
  String get daily_challenge_26_name => 'Daily Challenge 26';

  @override
  String get daily_challenge_26_description => 'Spend 15 minutes journaling or reflecting';

  @override
  String get daily_challenge_27_name => 'Daily Challenge 27';

  @override
  String get daily_challenge_27_description => 'Say “thank you” to someone who helps you today';

  @override
  String get daily_challenge_28_name => 'Daily Challenge 28';

  @override
  String get daily_challenge_28_description => 'Read or listen to something uplifting';

  @override
  String get daily_challenge_29_name => 'Daily Challenge 29';

  @override
  String get daily_challenge_29_description => 'Do a random act of kindness anonymously';

  @override
  String get daily_challenge_30_name => 'Daily Challenge 30';

  @override
  String get daily_challenge_30_description => 'Spend 10 minutes organizing your space';

  @override
  String get daily_challenge_31_name => 'Daily Challenge 31';

  @override
  String get daily_challenge_31_description => 'Reflect on the month — what are you proud of?';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Lester'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @sendTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Send Test Notification'**
  String get sendTestNotification;

  /// No description provided for @testNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Test your notification settings'**
  String get testNotificationSubtitle;

  /// No description provided for @testNotificationSent.
  ///
  /// In en, this message translates to:
  /// **'✅ Test notification sent!'**
  String get testNotificationSent;

  /// No description provided for @testNotificationError.
  ///
  /// In en, this message translates to:
  /// **'❌ Error: {error}'**
  String testNotificationError(Object error);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @weeklyReflection.
  ///
  /// In en, this message translates to:
  /// **'Weekly Reflection'**
  String get weeklyReflection;

  /// No description provided for @reflectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Reflection Saved'**
  String get reflectionSaved;

  /// No description provided for @reflectionSummary.
  ///
  /// In en, this message translates to:
  /// **'You\'ve been most kind when helping others and yourself directly.'**
  String get reflectionSummary;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @reflectionKindnessPrompt.
  ///
  /// In en, this message translates to:
  /// **'💭 What act of kindness made you feel proud this week?'**
  String get reflectionKindnessPrompt;

  /// No description provided for @writeAnswerHere.
  ///
  /// In en, this message translates to:
  /// **'Write your answer here...'**
  String get writeAnswerHere;

  /// No description provided for @reflectionMoodPrompt.
  ///
  /// In en, this message translates to:
  /// **'😌 How was your overall mood this week?'**
  String get reflectionMoodPrompt;

  /// No description provided for @reflectionProductivityPrompt.
  ///
  /// In en, this message translates to:
  /// **'📈 How would you rate your overall productivity this week?'**
  String get reflectionProductivityPrompt;

  /// No description provided for @submitReflection.
  ///
  /// In en, this message translates to:
  /// **'Submit Reflection'**
  String get submitReflection;

  /// No description provided for @selectMoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your {type} mood'**
  String selectMoodTitle(Object type);

  /// No description provided for @moodLabelHappy.
  ///
  /// In en, this message translates to:
  /// **'😊 Happy'**
  String get moodLabelHappy;

  /// No description provided for @moodLabelNeutral.
  ///
  /// In en, this message translates to:
  /// **'😐 Neutral'**
  String get moodLabelNeutral;

  /// No description provided for @moodLabelSad.
  ///
  /// In en, this message translates to:
  /// **'😔 Sad'**
  String get moodLabelSad;

  /// No description provided for @moodLabelAngry.
  ///
  /// In en, this message translates to:
  /// **'😡 Angry'**
  String get moodLabelAngry;

  /// No description provided for @moodLabelTired.
  ///
  /// In en, this message translates to:
  /// **'😴 Tired'**
  String get moodLabelTired;

  /// No description provided for @moodLabelRelaxed.
  ///
  /// In en, this message translates to:
  /// **'😌 Relaxed'**
  String get moodLabelRelaxed;

  /// No description provided for @moodLabelShocked.
  ///
  /// In en, this message translates to:
  /// **'😲 Shocked'**
  String get moodLabelShocked;

  /// No description provided for @moodLabelConfused.
  ///
  /// In en, this message translates to:
  /// **'😕 Confused'**
  String get moodLabelConfused;

  /// No description provided for @selectedMood.
  ///
  /// In en, this message translates to:
  /// **'You selected: {mood}'**
  String selectedMood(Object mood);

  /// No description provided for @fillAllMoods.
  ///
  /// In en, this message translates to:
  /// **'Please select all moods before saving.'**
  String get fillAllMoods;

  /// No description provided for @moodSaved.
  ///
  /// In en, this message translates to:
  /// **'Mood saved successfully! 💾'**
  String get moodSaved;

  /// No description provided for @noMoodsSaved.
  ///
  /// In en, this message translates to:
  /// **'No moods saved yet! 😴'**
  String get noMoodsSaved;

  /// No description provided for @savedMoods.
  ///
  /// In en, this message translates to:
  /// **'Saved Moods'**
  String get savedMoods;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @trackYourMood.
  ///
  /// In en, this message translates to:
  /// **'Track Your Mood 🌸'**
  String get trackYourMood;

  /// No description provided for @selectOverallMood.
  ///
  /// In en, this message translates to:
  /// **'Select Overall Mood'**
  String get selectOverallMood;

  /// No description provided for @selectMoodBefore.
  ///
  /// In en, this message translates to:
  /// **'Select Mood Before Challenge'**
  String get selectMoodBefore;

  /// No description provided for @selectMoodAfter.
  ///
  /// In en, this message translates to:
  /// **'Select Mood After Challenge'**
  String get selectMoodAfter;

  /// No description provided for @overallMood.
  ///
  /// In en, this message translates to:
  /// **'Overall Mood: {mood}'**
  String overallMood(Object mood);

  /// No description provided for @beforeMood.
  ///
  /// In en, this message translates to:
  /// **'Before Mood: {mood}'**
  String beforeMood(Object mood);

  /// No description provided for @afterMood.
  ///
  /// In en, this message translates to:
  /// **'After Mood: {mood}'**
  String afterMood(Object mood);

  /// No description provided for @saveMood.
  ///
  /// In en, this message translates to:
  /// **'Save Mood'**
  String get saveMood;

  /// No description provided for @viewSavedMoods.
  ///
  /// In en, this message translates to:
  /// **'View Saved Moods'**
  String get viewSavedMoods;

  /// No description provided for @moodTracker.
  ///
  /// In en, this message translates to:
  /// **'Mood Tracker'**
  String get moodTracker;

  /// No description provided for @dailyInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Insights'**
  String get dailyInsightsTitle;

  /// No description provided for @todaysChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Challenge'**
  String get todaysChallengeTitle;

  /// No description provided for @noChallengeMessage.
  ///
  /// In en, this message translates to:
  /// **'No challenge available for today'**
  String get noChallengeMessage;

  /// No description provided for @weeklyReflectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Reflection Quiz'**
  String get weeklyReflectionTitle;

  /// No description provided for @startWeeklyReflection.
  ///
  /// In en, this message translates to:
  /// **'Start Weekly Reflection'**
  String get startWeeklyReflection;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Lester 🌸!'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s log how you\'re feeling'**
  String get welcomeSubtitle;

  /// No description provided for @quoteLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load quote. Please try again.'**
  String get quoteLoadError;

  /// No description provided for @weatherLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load weather. Please try again.'**
  String get weatherLoadError;

  /// No description provided for @quoteFallback.
  ///
  /// In en, this message translates to:
  /// **'Stay positive and keep going.'**
  String get quoteFallback;

  /// No description provided for @unknownAuthor.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownAuthor;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

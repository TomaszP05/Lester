import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../databases/challenge_database.dart';
import '../l10n/app_localizations.dart';
import '../l10n/key_resolver.dart';

class ChallengesNotifications {
  static final ChallengesNotifications instance = ChallengesNotifications._init();
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  ChallengesNotifications._init();

  Future<void> initialize() async {
    try {
      // Initialize timezone
      tz.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notifications.initialize(initSettings);

      final androidImplementation = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
      }

      // Request permissions for iOS
      await _notifications
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      print('Error in notification initialization: $e');
      rethrow;
    }
  }

  // Get current day's challenge
  static int getCurrentDayNumber() {
    return DateTime.now().day;
  }

  // Get current challenge
  Future<Challenge?> getCurrentChallenge() async {
    final challenges = await DatabaseHelper.instance.readAllChallenges();
    final currentDay = getCurrentDayNumber();

    try {
      return challenges.firstWhere((c) => c.dayNumber == currentDay);
    } catch (e) {
      return null;
    }
  }

  // Schedule hourly notifications. If a BuildContext is provided, resolve
  // localization keys to translated strings before scheduling.
  Future<void> scheduleHourlyNotifications([BuildContext? context]) async {
    try {
      // Cancel any existing notifications
      await _notifications.cancelAll();

      final currentChallenge = await getCurrentChallenge();
      if (currentChallenge == null || currentChallenge.completed) return;

      // Resolve localized title/body if context is available
      final localizedTitle = context != null
          ? resolveLocalizedKey(context, currentChallenge.name)
          : currentChallenge.name;
      final localizedBody = context != null
          ? resolveLocalizedKey(context, currentChallenge.description)
          : currentChallenge.description;

      // Schedule notifications for every hour from 8 AM to 8 PM
      for (int hour = 8; hour <= 20; hour++) {
        await _scheduleNotificationForHour(hour, localizedTitle, localizedBody, currentChallenge);
      }
    } catch (e) {
      print('Error scheduling notifications: $e');
    }
  }

  Future<void> _scheduleNotificationForHour(int hour, String title, String body, Challenge challenge) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, 0);

    // If the time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'daily_challenges',
      'Daily Challenges',
      channelDescription: 'Hourly reminders for daily challenges',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      hour, // Unique ID for each hour
      title,
      body,
      tzScheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Cancel all notifications (challenge is completed)
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Get time until next challenge (in hours)
  static int getHoursUntilNextChallenge() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 0, 0);
    final difference = tomorrow.difference(now);
    return difference.inHours;
  }

  // Get formatted time until next challenge
  static String getFormattedTimeUntilNext() {
    final hours = getHoursUntilNextChallenge();
    if (hours == 1) return '1 hour';
    return '$hours hours';
  }

  // Send immediate test notification. If context is provided, resolve localized strings.
  Future<void> sendTestNotification([BuildContext? context]) async {
    final currentChallenge = await getCurrentChallenge();

    final title = context != null
        ? (currentChallenge != null ? resolveLocalizedKey(context, currentChallenge.name) : (AppLocalizations.of(context)?.testNotificationSent ?? 'Daily Challenge Reminder'))
        : 'Daily Challenge Reminder';

    final body = context != null
        ? (currentChallenge != null ? resolveLocalizedKey(context, currentChallenge.description) : (AppLocalizations.of(context)?.testNotificationSubtitle ?? 'Complete your daily challenge!'))
        : (currentChallenge?.description ?? 'Complete your daily challenge!');

    const androidDetails = AndroidNotificationDetails(
      'daily_challenges',
      'Daily Challenges',
      channelDescription: 'Hourly reminders for daily challenges',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      999, // Unique ID for test notifications
      title,
      body,
      notificationDetails,
    );
  }
}
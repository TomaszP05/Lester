import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/mood_screen.dart';
import 'notifications/challenges_notifications.dart';

final ValueNotifier<Locale?> _localeNotifier = ValueNotifier<Locale?>(null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Allow HTTP connections in debug mode (for insights widget)
  if (!kReleaseMode) {
    HttpOverrides.global = _PermissiveHttpOverrides();
  }

  try {
    await ChallengesNotifications.instance.initialize();
    await ChallengesNotifications.instance.scheduleHourlyNotifications();
  } catch (e) {
    print('Error initializing notifications: $e');
  }

  runApp(const LesterApp());
}

class LesterApp extends StatelessWidget {
  const LesterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: _localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'Lester',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.teal),
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
            Locale('fr'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const MainNavigation(),
        );
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final GlobalKey<JournalScreenState> _journalKey =
      GlobalKey<JournalScreenState>();
  final GlobalKey<HomeScreenState> _homeKey = GlobalKey<HomeScreenState>();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(key: _homeKey),
      JournalScreen(key: _journalKey),
      const ChallengesScreen(),
      const MoodScreen(),
      const SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Refresh home screen when returning to it
    if (index == 0) {
      _homeKey.currentState?.loadCurrentChallenge();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc?.appTitle ?? 'Lester'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () => _journalKey.currentState?.openComposer(),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: loc?.home ?? 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.auto_stories), label: loc?.journal ?? 'Journal'),
          BottomNavigationBarItem(icon: const Icon(Icons.emoji_events), label: loc?.challenges ?? 'Challenges'),
          BottomNavigationBarItem(icon: const Icon(Icons.mood), label: loc?.mood ?? 'Mood'),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: loc?.settings ?? 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _sendTestNotification(BuildContext context) async {
    try {
      await ChallengesNotifications.instance.sendTestNotification();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.testNotificationSent ?? '✅ Test notification sent!'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        final errorMsg = AppLocalizations.of(context)?.testNotificationError(e) ?? '❌ Error: $e';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc?.settings ?? 'Settings',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            loc?.notifications ?? 'Notifications',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.notifications_active,
                color: Colors.teal,
                size: 28,
              ),
              title: Text(
                loc?.sendTestNotification ?? 'Send Test Notification',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(loc?.testNotificationSubtitle ?? 'Test your notification settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _sendTestNotification(context),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            loc?.language ?? 'Language',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.language,
                color: Colors.teal,
                size: 28,
              ),
              title: Text(loc?.selectLanguage ?? 'Select Language'),
              trailing: DropdownButton<Locale>(
                value: _localeNotifier.value ?? Localizations.localeOf(context),
                onChanged: (Locale? newLocale) {
                  _localeNotifier.value = newLocale;
                },
                items: [
                  DropdownMenuItem(
                    value: const Locale('en'),
                    child: Text(loc?.english ?? 'English'),
                  ),
                  DropdownMenuItem(
                    value: const Locale('es'),
                    child: Text(loc?.spanish ?? 'Spanish'),
                  ),
                  DropdownMenuItem(
                    value: const Locale('fr'),
                    child: Text(loc?.french ?? 'French'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissiveHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

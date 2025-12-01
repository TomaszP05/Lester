import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/mood_screen.dart';
import 'notifications/challenges_notifications.dart';

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

class LesterApp extends StatefulWidget {
  const LesterApp({super.key});

  @override
  State<LesterApp> createState() => _LesterAppState();
}

class _LesterAppState extends State<LesterApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void updateTheme(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lester',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      // 🌸 Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        cardColor: Colors.white.withOpacity(0.7),
        useMaterial3: true,
      ),

      // 🌙 Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111114),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        cardColor: Colors.white.withOpacity(0.15),
        useMaterial3: true,
      ),

      home: MainNavigation(onThemeChange: updateTheme),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final void Function(ThemeMode) onThemeChange;

  const MainNavigation({super.key, required this.onThemeChange});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final GlobalKey<JournalScreenState> _journalKey = GlobalKey<JournalScreenState>();
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
      SettingsScreen(onThemeChange: widget.onThemeChange),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      _homeKey.currentState?.loadCurrentChallenge();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lester'),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_selectedIndex],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
        onPressed: () => _journalKey.currentState?.openComposer(),
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Mood'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final void Function(ThemeMode) onThemeChange;

  const SettingsScreen({super.key, required this.onThemeChange});

  Future<void> _sendTestNotification(BuildContext context) async {
    try {
      await ChallengesNotifications.instance.sendTestNotification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Test notification sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Settings", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),

        const Text("Appearance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ListTile(
          leading: const Icon(Icons.light_mode),
          title: const Text("Light Mode"),
          onTap: () => onThemeChange(ThemeMode.light),
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text("Dark Mode"),
          onTap: () => onThemeChange(ThemeMode.dark),
        ),

        const SizedBox(height: 24),
        const Text("Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ListTile(
          leading: const Icon(Icons.notifications_active),
          title: const Text("Send Test Notification"),
          onTap: () => _sendTestNotification(context),
        ),
      ],
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

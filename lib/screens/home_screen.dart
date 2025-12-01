import 'dart:ui';
import 'package:flutter/material.dart';
import '../databases/challenge_database.dart';
import '../notifications/challenges_notifications.dart';
import '../widgets/insights_widget.dart';
import 'reflection_screen.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Challenge? _currentChallenge;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentChallenge();
  }

  Future<void> _loadCurrentChallenge() async {
    final challenge = await ChallengesNotifications.instance.getCurrentChallenge();
    setState(() {
      _currentChallenge = challenge;
      _isLoading = false;
    });
  }

  void loadCurrentChallenge() => _loadCurrentChallenge();

  Future<void> _toggleChallenge() async {
    if (_currentChallenge == null) return;

    final wasCompleted = _currentChallenge!.completed;

    setState(() {
      _currentChallenge = _currentChallenge!.copyWith(completed: !wasCompleted);
    });

    await DatabaseHelper.instance.toggleCompletion(
      _currentChallenge!.id!,
      !wasCompleted,
    );

    if (!wasCompleted && _currentChallenge!.completed) {
      await ChallengesNotifications.instance.cancelAllNotifications();
      if (mounted) {
        final timeUntilNext = ChallengesNotifications.getFormattedTimeUntilNext();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 Challenge completed! Next challenge drops in $timeUntilNext'),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    } else {
      await ChallengesNotifications.instance.scheduleHourlyNotifications();
    }
  }

  // Pastel Rotation
  Color _pastelColor(int index) {
    final list = [
      const Color(0xFFCDA9FC),
      const Color(0xFFA1D9FF),
      const Color(0xFFFBC576),
      const Color(0xFF81EDA9),
      const Color(0xFFF897BD),
    ];
    return list[index % list.length];
  }

  /// Glass Card Container (Light Mode Only)
  Widget _glassContainer({required Widget child, required Color color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.60),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          _glassContainer(
            color: _pastelColor(3),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc?.welcomeTitle ?? 'Welcome to Lester 🌸!',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loc?.welcomeSubtitle ?? "Let's log how you're feeling~ 🧧",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset('assets/LesterMascot.png', height: 60),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Daily Insights
          Text(
            loc?.dailyInsightsTitle ?? 'Daily Insights',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const InsightsWidget(),

          const SizedBox(height: 24),

          // Today's Challenge
          Text(
            loc?.todaysChallengeTitle ?? "Today's Challenge",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_currentChallenge == null)
            _glassContainer(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    loc?.noChallengeMessage ?? 'No challenge available for today',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          else
            _glassContainer(
              color: _pastelColor(_currentChallenge!.dayNumber),
              child: _buildChallengeCard(_currentChallenge!),
            ),

          const SizedBox(height: 32),

          // Weekly Reflection
          Text(
            loc?.weeklyReflectionTitle ?? 'Weekly Reflection Quiz',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          _glassContainer(
            color: _pastelColor(1),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReflectionScreen()),
                  ),
                  icon: const Icon(Icons.self_improvement, color: Colors.white),
                  label: Text(
                    loc?.startWeeklyReflection ?? 'Start Weekly Reflection',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Challenge challenge) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  challenge.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              if (challenge.completed)
                const Icon(Icons.check_circle, color: Colors.green, size: 26),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            challenge.description,
            style: TextStyle(
              fontSize: 15,
              color: challenge.completed ? Colors.grey : Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "${challenge.points} Points",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}

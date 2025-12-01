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

  void loadCurrentChallenge() {
    _loadCurrentChallenge(); // call private implementation from same file
  }

  Future<void> _toggleChallenge() async {
    if (_currentChallenge == null) return;

    final wasCompleted = _currentChallenge!.completed;

    setState(() {
      _currentChallenge = _currentChallenge!.copyWith(completed: !wasCompleted);
    });

    // Update database
    await DatabaseHelper.instance.toggleCompletion(
      _currentChallenge!.id!,
      !wasCompleted,
    );

    // If  completed, cancel notifications and show snackbar
    if (!wasCompleted && _currentChallenge!.completed) {
      await ChallengesNotifications.instance.cancelAllNotifications();

      if (mounted) {
        final timeUntilNext = ChallengesNotifications.getFormattedTimeUntilNext();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 Challenge completed! Next challenge drops in $timeUntilNext'),
            duration: const Duration(seconds: 4),
            backgroundColor: const Color(0xFF477247),
          ),
        );
      }
    } else if (wasCompleted && !_currentChallenge!.completed) {
      // If incomplete, reschedule notifications
      await ChallengesNotifications.instance.scheduleHourlyNotifications();
    }
  }

  Color _getCardColor(int dayNumber) {
    final colors = [
      const Color(0xFFE8D4F8), // Light purple
      const Color(0xFFD4E8F8), // Light blue
      const Color(0xFFF8E8D4), // Light orange
      const Color(0xFFD4F8E8), // Light green
    ];
    return colors[dayNumber % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD4F8E8), // light green background
              borderRadius: BorderRadius.circular(16),
            ),
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
                Image.asset('assets/LesterMascot.png', height: 60),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            loc?.dailyInsightsTitle ?? 'Daily Insights',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const InsightsWidget(),
          
          const SizedBox(height: 24),
          Text(
            loc?.todaysChallengeTitle ?? 'Today\'s Challenge',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_currentChallenge == null)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  loc?.noChallengeMessage ?? 'No challenge available for today',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          else
            _buildChallengeCard(_currentChallenge!),

          const SizedBox(height: 32),
          Text(
            loc?.weeklyReflectionTitle ?? 'Weekly Reflection Quiz',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // 🌸 ADD REFLECTION BUTTON
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReflectionScreen()),
                );
              },
              icon: const Icon(Icons.self_improvement, color: Colors.white),
              label: Text(
                loc?.startWeeklyReflection ?? "Start Weekly Reflection",
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildChallengeCard(Challenge challenge) {
    return Container(
      decoration: BoxDecoration(
        color: _getCardColor(challenge.dayNumber),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleChallenge,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    if (challenge.completed)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Color(0xFF477247),
                          size: 24,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  challenge.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: challenge.completed
                        ? Colors.grey
                        : const Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${challenge.points} Points',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF888888),
                      ),
                    ),
                    if (challenge.completed)
                      Text(
                        '+${challenge.points} Points',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF477247),
                        ),
                      ),
                  ],
                ),
                if (challenge.name.contains('picture') &&
                    !challenge.completed)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
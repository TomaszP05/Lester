import 'package:flutter/material.dart';
import 'challenge_database.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Challenge> _challenges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    final challenges = await DatabaseHelper.instance.readAllChallenges();
    setState(() {
      _challenges = challenges;
      _isLoading = false;
    });
  }

  Future<void> _toggleChallenge(int index) async {
    final challenge = _challenges[index];

    // Update UI immediately
    setState(() {
      _challenges[index] = challenge.copyWith(completed: !challenge.completed);
    });

    // Update database in background
    await DatabaseHelper.instance.toggleCompletion(
      challenge.id!,
      !challenge.completed,
    );
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_challenges.isEmpty) {
      return const Center(
        child: Text('No challenges available'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _challenges.length,
      itemBuilder: (context, index) {
        final challenge = _challenges[index];
        return _buildChallengeCard(challenge, index);
      },
    );
  }

  Widget _buildChallengeCard(Challenge challenge, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          onTap: () => _toggleChallenge(index),
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
                    fontSize: 14,
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
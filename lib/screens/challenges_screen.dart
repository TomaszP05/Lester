import 'dart:ui';
import 'package:flutter/material.dart';
import '../databases/challenge_database.dart';
import '../l10n/key_resolver.dart';

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

    setState(() {
      _challenges[index] = challenge.copyWith(completed: !challenge.completed);
    });

    await DatabaseHelper.instance.toggleCompletion(
      challenge.id!,
      !challenge.completed,
    );
  }

  /// Pastel colors cycle
  Color _pastel(int index) {
    final colors = [
      const Color(0xFFCDA9FC), // lilac
      const Color(0xFFA1D9FF), // soft blue
      const Color(0xFFFBC576), // peach
      const Color(0xFF81EDA9), // mint
      const Color(0xFFF897BD), // pink
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_challenges.isEmpty) {
      return const Center(
        child: Text('No challenges available 😔'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _challenges.length,
      itemBuilder: (context, index) => _buildGlassCard(context, _challenges[index], index),
    );
  }

  Widget _buildGlassCard(BuildContext context, Challenge challenge, int index) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    final title = resolveLocalizedKey(context, challenge.name);
    final description = resolveLocalizedKey(context, challenge.description);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _pastel(index).withOpacity(
              dark ? 0.25 : 0.60, // lighter transparency in light mode
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
            ),
            boxShadow: [
              BoxShadow(
                color: dark
                    ? Colors.black.withOpacity(0.35)
                    : Colors.grey.withOpacity(0.20),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _toggleChallenge(index),
            borderRadius: BorderRadius.circular(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Title + Checkmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    if (challenge.completed)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                /// 🔹 Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: challenge.completed
                        ? Colors.grey
                        : (dark ? Colors.white70 : Colors.black54),
                  ),
                ),

                const SizedBox(height: 12),

                /// 🔹 Points row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${challenge.points} Points',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: dark ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                    if (challenge.completed)
                      Text(
                        '+${challenge.points} ⭐',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: dark ? Colors.greenAccent : Colors.green,
                        ),
                      ),
                  ],
                ),

                /// 🔹 Camera section
                if (title.toLowerCase().contains("picture") &&
                    !challenge.completed)
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: dark ? Colors.white60 : Colors.black54,
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

import 'dart:ui';
import 'package:flutter/material.dart';
import '../databases/mood_database.dart';
import '../l10n/app_localizations.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String? overallMood;
  String? beforeMood;
  String? afterMood;

  final List<String> moods = [
    '😊 Happy',
    '😐 Neutral',
    '😔 Sad',
    '😡 Angry',
    '😴 Tired',
    '😌 Relaxed',
    '😲 Shocked',
    '😕 Confused',
  ];

  String _localizedMoodLabel(BuildContext context, String mood) {
    final loc = AppLocalizations.of(context);
    switch (mood) {
      case '😊 Happy':
        return loc?.moodLabelHappy ?? mood;
      case '😐 Neutral':
        return loc?.moodLabelNeutral ?? mood;
      case '😔 Sad':
        return loc?.moodLabelSad ?? mood;
      case '😡 Angry':
        return loc?.moodLabelAngry ?? mood;
      case '😴 Tired':
        return loc?.moodLabelTired ?? mood;
      case '😌 Relaxed':
        return loc?.moodLabelRelaxed ?? mood;
      case '😲 Shocked':
        return loc?.moodLabelShocked ?? mood;
      case '😕 Confused':
        return loc?.moodLabelConfused ?? mood;
      default:
        return mood;
    }
  }

  // Pastel theme rotation
  Color _pastelColor(int index) {
    final colors = [
      const Color(0xFFCDA9FC), // lilac
      const Color(0xFFA1D9FF), // soft blue
      const Color(0xFFFBC576), // peach
      const Color(0xFF81EDA9), // mint
      const Color(0xFFF897BD), // pink
    ];
    return colors[index % colors.length].withOpacity(0.55);
  }

  // Mood picker dialog
  Future<void> _pickMood(String type) async {
    final loc = AppLocalizations.of(context);
    
    // Determine title based on type
    String title;
    if (type == 'overall') {
      title = loc?.selectOverallMood ?? 'Select Overall Mood';
    } else if (type == 'before') {
      title = loc?.selectMoodBefore ?? 'Select Mood Before Challenge';
    } else {
      title = loc?.selectMoodAfter ?? 'Select Mood After Challenge';
    }

    final String? selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        children: moods.map((mood) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, mood),
            child: Text(_localizedMoodLabel(context, mood), style: const TextStyle(fontSize: 18)),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      setState(() {
        if (type == 'overall') overallMood = selected;
        if (type == 'before') beforeMood = selected;
        if (type == 'after') afterMood = selected;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc?.selectedMood(_localizedMoodLabel(context, selected)) ?? 'You selected: $selected'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Save mood to database
  Future<void> _saveMood() async {
    final loc = AppLocalizations.of(context);
    if (overallMood == null || beforeMood == null || afterMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc?.fillAllMoods ?? 'Please select all moods before saving.')),
      );
      return;
    }

    final moodEntry = MoodEntry(
      overallMood: overallMood!,
      beforeMood: beforeMood!,
      afterMood: afterMood!,
      createdAt: DateTime.now(),
    );

    await MoodDatabase.instance.insertMood(moodEntry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(loc?.saveMood ?? 'Mood saved successfully! 💾')),
    );

    setState(() {
      overallMood = null;
      beforeMood = null;
      afterMood = null;
    });
  }

  // Show saved moods
  Future<void> _showSavedMoods() async {
    final loc = AppLocalizations.of(context);
    final moods = await MoodDatabase.instance.getMoods();

    if (moods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No moods saved yet! 💤')), // TODO: add to arb if needed
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(loc?.viewSavedMoods ?? 'Saved Moods'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: moods.length,
            itemBuilder: (context, index) {
              final m = moods[index];
              return ListTile(
                leading: const Icon(Icons.mood, color: Colors.teal),
                title: Text('Overall: ${_localizedMoodLabel(context, m.overallMood)}'),
                subtitle: Text(
                    'Before: ${_localizedMoodLabel(context, m.beforeMood)}\nAfter: ${_localizedMoodLabel(context, m.afterMood)}\nDate: ${m.createdAt.toLocal()}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')), // TODO: localize Close
        ],
      ),
    );
  }

  // Glass button builder
  Widget _glassButton(String label, VoidCallback action, int index) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ElevatedButton(
            onPressed: action,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(55),
              backgroundColor: _pastelColor(index),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: dark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc?.moodTracker ?? 'Mood Tracker')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 35),
            child: Column(
              children: [
                Text(
                  loc?.trackYourMood ?? 'Track Your Mood 🌸',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                // Buttons
                _glassButton(loc?.selectOverallMood ?? 'Select Overall Mood', () => _pickMood('overall'), 0),
                const SizedBox(height: 15),

                _glassButton(loc?.selectMoodBefore ?? 'Select Mood Before Challenge', () => _pickMood('before'), 1),
                const SizedBox(height: 15),

                _glassButton(loc?.selectMoodAfter ?? 'Select Mood After Challenge', () => _pickMood('after'), 2),
                const SizedBox(height: 25),

                _glassButton(loc?.saveMood ?? 'Save Mood', _saveMood, 3),
                const SizedBox(height: 12),

                _glassButton(loc?.viewSavedMoods ?? 'View Saved Moods', _showSavedMoods, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

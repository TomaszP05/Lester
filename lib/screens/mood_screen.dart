import 'dart:ui';
import 'package:flutter/material.dart';
import '../databases/mood_database.dart';

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
    final String? selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Select your $type mood'),
        children: moods.map((mood) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, mood),
            child: Text(mood, style: const TextStyle(fontSize: 18)),
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
            content: Text('You selected: $selected'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Save mood to database
  Future<void> _saveMood() async {
    if (overallMood == null || beforeMood == null || afterMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all moods before saving!')),
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
      const SnackBar(content: Text('Mood saved successfully! 💾')),
    );

    setState(() {
      overallMood = null;
      beforeMood = null;
      afterMood = null;
    });
  }

  // Show saved moods
  Future<void> _showSavedMoods() async {
    final moods = await MoodDatabase.instance.getMoods();

    if (moods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No moods saved yet! 💤')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Saved Moods'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: moods.length,
            itemBuilder: (context, index) {
              final m = moods[index];
              return ListTile(
                leading: const Icon(Icons.mood, color: Colors.teal),
                title: Text('Overall: ${m.overallMood}'),
                subtitle: Text(
                    'Before: ${m.beforeMood}\nAfter: ${m.afterMood}\nDate: ${m.createdAt.toLocal()}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 35),
            child: Column(
              children: [
                const Text(
                  'Track Your Mood 🌸',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                // Buttons
                _glassButton('Select Overall Mood', () => _pickMood('overall'), 0),
                const SizedBox(height: 15),

                _glassButton('Select Mood Before Challenge', () => _pickMood('before'), 1),
                const SizedBox(height: 15),

                _glassButton('Select Mood After Challenge', () => _pickMood('after'), 2),
                const SizedBox(height: 25),

                _glassButton('Save Mood', _saveMood, 3),
                const SizedBox(height: 12),

                _glassButton('View Saved Moods', _showSavedMoods, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

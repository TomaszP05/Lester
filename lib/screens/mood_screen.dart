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

  // Mood picker dialog
  void _pickMood(String type) async {
    final loc = AppLocalizations.of(context);
    String? selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(loc?.selectMoodTitle(type) ?? 'Select your $type mood'),
          children: moods.map((mood) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, mood),
              child: Text(_localizedMoodLabel(context, mood)),
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        if (type == 'overall') overallMood = selected;
        if (type == 'before') beforeMood = selected;
        if (type == 'after') afterMood = selected;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc?.selectedMood(_localizedMoodLabel(context, selected)) ?? 'You selected: $selected')),
      );
    }
  }

  // Save mood to database
  Future<void> _saveMood() async {
    if (overallMood == null || beforeMood == null || afterMood == null) {
      final loc = AppLocalizations.of(context);
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
      const SnackBar(content: Text('Mood saved successfully! 💾')),
    );

    setState(() {
      overallMood = null;
      beforeMood = null;
      afterMood = null;
    });
  }

  // Show saved moods in a dialog
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
      builder: (context) {
        return AlertDialog(
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
                    'Before: ${m.beforeMood}\nAfter: ${m.afterMood}\nDate: ${m.createdAt.toLocal()}',
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc?.moodTracker ?? 'Mood Tracker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc?.trackYourMood ?? 'Track Your Mood 🌸',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _pickMood('overall'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(loc?.selectOverallMood ?? 'Select Overall Mood'),
                ),
              ),
              if (overallMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    loc?.overallMood(_localizedMoodLabel(context, overallMood!)) ?? 'Overall Mood: ${_localizedMoodLabel(context, overallMood!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _pickMood('before'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(loc?.selectMoodBefore ?? 'Select Mood Before Challenge'),
                ),
              ),
              if (beforeMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    loc?.beforeMood(_localizedMoodLabel(context, beforeMood!)) ?? 'Before Mood: ${_localizedMoodLabel(context, beforeMood!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _pickMood('after'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(loc?.selectMoodAfter ?? 'Select Mood After Challenge'),
                ),
              ),
              if (afterMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    loc?.afterMood(_localizedMoodLabel(context, afterMood!)) ?? 'After Mood: ${_localizedMoodLabel(context, afterMood!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveMood,
                  icon: const Icon(Icons.save),
                  label: Text(loc?.saveMood ?? 'Save Mood'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showSavedMoods,
                  icon: const Icon(Icons.history),
                  label: Text(loc?.viewSavedMoods ?? 'View Saved Moods'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

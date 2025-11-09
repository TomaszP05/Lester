import 'package:flutter/material.dart';

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
  ];

  void _pickMood(String type) async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select your $type mood'),
          children: moods.map((mood) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, mood),
              child: Text(mood),
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
        SnackBar(content: Text('You selected: $selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Track Your Mood 🌸',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Overall Mood Button
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
                  child: const Text('Select Overall Mood'),
                ),
              ),
              if (overallMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Overall Mood: $overallMood',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

              const SizedBox(height: 25),

              // Before Challenge Mood Button
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
                  child: const Text('Select Mood Before Challenge'),
                ),
              ),
              if (beforeMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Before Mood: $beforeMood',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

              const SizedBox(height: 25),

              // After Challenge Mood Button
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
                  child: const Text('Select Mood After Challenge'),
                ),
              ),
              if (afterMood != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'After Mood: $afterMood',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

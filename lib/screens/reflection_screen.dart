import 'package:flutter/material.dart';
import '../databases/reflection_database.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({super.key});

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  final TextEditingController _kindnessController = TextEditingController();
  double _productivity = 5;
  String? _moodEmoji;

  Future<void> _submitReflection() async {
    final reflection = ReflectionEntry(
      actOfKindness: _kindnessController.text.trim(),
      productivity: _productivity,
      moodEmoji: _moodEmoji ?? "🙂",
      date: DateTime.now(),
    );

    await ReflectionDatabase.instance.insertReflection(reflection);

    String summary = "You've been most kind when helping others and yourself directly.";

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Reflection Saved'),
          content: Text(summary),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // return to home screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Reflection')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "💭 What act of kindness made you feel proud this week?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _kindnessController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 24),
            const Text(
              "😌 How was your overall mood this week?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["😡", "😞", "😕", "😲", "😴", "😐", "😌", "🙂", "😄", "🤩"].map((emoji) {
                final isSelected = _moodEmoji == emoji;
                return GestureDetector(
                  onTap: () => setState(() => _moodEmoji = emoji),
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: isSelected ? 40 : 32),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            const Text(
              "📈 How would you rate your overall productivity this week?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _productivity,
              min: 0,
              max: 10,
              divisions: 10,
              label: _productivity.round().toString(),
              onChanged: (value) => setState(() => _productivity = value),
            ),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _submitReflection,
                child: const Text(
                  "Submit Reflection",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
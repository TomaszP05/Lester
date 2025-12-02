import 'package:flutter/material.dart';
import '../databases/reflection_database.dart';
import '../l10n/app_localizations.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({super.key});

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  final TextEditingController _weekSentenceController = TextEditingController();
  final TextEditingController _rememberController = TextEditingController();
  final TextEditingController _smileController = TextEditingController();
  final TextEditingController _newThingController = TextEditingController();
  final TextEditingController _insightController = TextEditingController();
  final TextEditingController _kindnessController = TextEditingController();

  double _productivity = 5;
  double _satisfaction = 5;

  String? _moodEmoji;

  String? _showedKindness;
  String? _feltMostYourselfDay;
  String? _completedTasksOption;

  final List<String> _kindnessOptions = [
    "Yes",
    "No",
    "Maybe",
    "A little",
    "A lot",
    "Less than I would like",
  ];

  final List<String> _completionOptions = [
    "Yes",
    "No",
    "Maybe",
    "A little",
    "A lot",
    "Less than I would like",
  ];

  final List<String> _daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Future<void> _submitReflection() async {
    final reflection = ReflectionEntry(
      actOfKindness: _kindnessController.text.trim(),
      productivity: _productivity,
      moodEmoji: _moodEmoji ?? "😌",
      date: DateTime.now(),
      weekSentence: _weekSentenceController.text.trim(),
      remember: _rememberController.text.trim(),
      smile: _smileController.text.trim(),
      showedKindness: _showedKindness ?? "",
      feltMostYourselfDay: _feltMostYourselfDay ?? "",
      completedTasksOption: _completedTasksOption ?? "",
      satisfaction: _satisfaction,
      newThing: _newThingController.text.trim(),
      insight: _insightController.text.trim(),
    );

    await ReflectionDatabase.instance.insertReflection(reflection);

    String summary = AppLocalizations.of(context)?.reflectionSummary ?? "You've been most kind when helping others and yourself directly.";

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.reflectionSaved ?? 'Reflection Saved'),
          content: Text(summary),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // return to home screen
              },
              child: Text(AppLocalizations.of(context)?.ok ?? 'OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc?.weeklyReflection ?? 'Weekly Reflection')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "✍️ If you had to describe your week in one sentence, what would it be?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weekSentenceController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            Text(
              "😊 How was your overall mood this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["😡", "😞", "😕", "😲", "😴"].map((emoji) {
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["😐", "😌", "🙂", "😄", "🤩"].map((emoji) {
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
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "💗 What act of kindness made you feel proud this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

            Text(
              "📸 What’s something you want to remember about this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rememberController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            Text(
              "🌟 How satisfied are you with your week overall?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _satisfaction,
              min: 0,
              max: 10,
              divisions: 10,
              label: _satisfaction.round().toString(),
              onChanged: (value) => setState(() => _satisfaction = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Not Satisfied"),
                Text("Very Satisfied"),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "😄 Who or what made you smile this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _smileController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            Text(
              "🫶 Did you show yourself kindness this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _showedKindness,
              items: _kindnessOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: (value) => setState(() => _showedKindness = value),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 24),

            Text(
              "🧘 When did you feel the most like “yourself” this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _feltMostYourselfDay,
              items: _daysOfWeek.map((day) {
                return DropdownMenuItem(value: day, child: Text(day));
              }).toList(),
              onChanged: (value) => setState(() => _feltMostYourselfDay = value),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 24),

            Text(
              "🗂️ Did you complete everything you needed to for this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _completedTasksOption,
              items: _completionOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: (value) =>
                  setState(() => _completedTasksOption = value),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 24),

            Text(
              "💼 How would you rate your overall productivity this week?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _productivity,
              min: 0,
              max: 10,
              divisions: 10,
              label: _productivity.round().toString(),
              onChanged: (value) => setState(() => _productivity = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Not productive at all"),
                Text("Most productive"),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "🌱 Did you try anything new this week? If yes, what was it?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _newThingController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            Text(
              "💡 Is there any new insight or perspective you gained or learned something new about yourself?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _insightController,
              decoration: const InputDecoration(
                hintText: "Write your answer here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _submitReflection,
                child: Text(
                  loc?.submitReflection ?? "Submit Reflection",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
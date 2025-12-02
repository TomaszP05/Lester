import 'package:flutter/material.dart';
import '../databases/reflection_database.dart';

class QuizHistoryScreen extends StatefulWidget {
  const QuizHistoryScreen({super.key});

  @override
  State<QuizHistoryScreen> createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  List<ReflectionEntry> reflections = [];

  @override
  void initState() {
    super.initState();
    _loadReflections();
  }

  Future<void> _loadReflections() async {
    final entries = await ReflectionDatabase.instance.getAllReflections();
    setState(() => reflections = entries);
  }

  void _openReflectionDetails(ReflectionEntry entry) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reflection Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detail("🗓 Date", entry.date.toString().substring(0, 16)),
              _detail("🙂 Mood", entry.moodEmoji),
              _detail("✍️ Week Summary", entry.weekSentence),
              _detail("📸 Something to Remember", entry.remember),
              _detail("😄 What Made You Smile", entry.smile),
              _detail("💗 Act of Kindness", entry.actOfKindness),
              _detail("🫶 Showed Yourself Kindness", entry.showedKindness),
              _detail("🧘 Felt Most Yourself On", entry.feltMostYourselfDay),
              _detail("🗂 Completed Weekly Tasks", entry.completedTasksOption),
              _detail("🌟 Satisfaction", entry.satisfaction.toString()),
              _detail("💼 Productivity", entry.productivity.toString()),
              _detail("🌱 New Thing Tried", entry.newThing),
              _detail("💡 Insight Gained", entry.insight),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? "—" : value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Reflections"),
        centerTitle: true,
      ),
      body: reflections.isEmpty
          ? const Center(
              child: Text(
                "No reflections saved yet.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: reflections.length,
              itemBuilder: (context, index) {
                final entry = reflections[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Text(
                      entry.moodEmoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      entry.weekSentence.isNotEmpty
                          ? entry.weekSentence
                          : "Reflection Entry",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      entry.date.toString().substring(0, 16),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openReflectionDetails(entry),
                  ),
                );
              },
            ),
    );
  }
}

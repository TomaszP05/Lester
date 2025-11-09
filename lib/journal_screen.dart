import 'package:flutter/material.dart';
import 'journal_database.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});
  @override
  JournalScreenState createState() => JournalScreenState();
}

class JournalScreenState extends State<JournalScreen> {
  final JournalDatabase _database = JournalDatabase.instance;
  List<JournalEntry> _entries = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    await _database.ensurePresetEntries();
    final entries = await _database.getEntries();
    if (!mounted) return;
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  Future<void> openComposer() async {
    final result = await Navigator.of(context).push<JournalEntry>(
      MaterialPageRoute(builder: (_) => const JournalEntryFormPage()),
    );
    if (result == null) return;
    await _database.insertEntry(result);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Journal entry saved')));
    await _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return RefreshIndicator(
      onRefresh: _loadEntries,
      child: _entries.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              children: const [
                Icon(Icons.auto_stories_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No journal entries yet.\nTap the + button to start writing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return _JournalEntryCard(entry: entry);
              },
            ),
    );
  }
}

class _JournalEntryCard extends StatelessWidget {
  const _JournalEntryCard({required this.entry});
  final JournalEntry entry;
  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final monthLabel = months[date.month - 1];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$monthLabel ${date.day}, ${date.year} · $hour:$minute $period';
  }

  Widget _buildSection(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 15, height: 1.3)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateColor = Colors.teal.shade700;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(entry.createdAt),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: dateColor,
                  ),
                ),
                const Icon(Icons.bookmark, color: Colors.teal),
              ],
            ),
            const SizedBox(height: 12),
            _buildSection('Thoughts', entry.thoughts, Colors.teal.shade400),
            const SizedBox(height: 12),
            _buildSection('Feelings', entry.feelings, Colors.purple.shade400),
            const SizedBox(height: 12),
            _buildSection(
              'Accomplishments',
              entry.accomplishments,
              Colors.orange.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class JournalEntryFormPage extends StatefulWidget {
  const JournalEntryFormPage({super.key});
  @override
  State<JournalEntryFormPage> createState() => _JournalEntryFormPageState();
}

class _JournalEntryFormPageState extends State<JournalEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _thoughtsController = TextEditingController();
  final _feelingsController = TextEditingController();
  final _accomplishmentsController = TextEditingController();
  @override
  void dispose() {
    _thoughtsController.dispose();
    _feelingsController.dispose();
    _accomplishmentsController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final entry = JournalEntry(
      thoughts: _thoughtsController.text.trim(),
      feelings: _feelingsController.text.trim(),
      accomplishments: _accomplishmentsController.text.trim(),
      createdAt: DateTime.now(),
    );
    Navigator.of(context).pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Journal Entry')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What is on your mind today?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _thoughtsController,
                label: 'Thoughts',
                hint: 'Write your reflections, ideas, or worries...',
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _feelingsController,
                label: 'Feelings',
                hint: 'How are you feeling? Be honest with yourself.',
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _accomplishmentsController,
                label: 'Accomplishments',
                hint: 'Celebrate your wins, big or small.',
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Save Entry'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 3,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label.';
        }
        return null;
      },
    );
  }
}

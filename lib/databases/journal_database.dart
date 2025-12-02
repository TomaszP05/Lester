import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Model that represents a single journal submission.
class JournalEntry {
  final int? id;
  final String thoughts;
  final String feelings;
  final String accomplishments;
  final DateTime createdAt;
  const JournalEntry({
    this.id,
    required this.thoughts,
    required this.feelings,
    required this.accomplishments,
    required this.createdAt,
  });
  JournalEntry copyWith({
    int? id,
    String? thoughts,
    String? feelings,
    String? accomplishments,
    DateTime? createdAt,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      thoughts: thoughts ?? this.thoughts,
      feelings: feelings ?? this.feelings,
      accomplishments: accomplishments ?? this.accomplishments,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thoughts': thoughts,
      'feelings': feelings,
      'accomplishments': accomplishments,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'] as int?,
      thoughts: map['thoughts'] as String,
      feelings: map['feelings'] as String,
      accomplishments: map['accomplishments'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

/// Handles all SQLite interaction for the journal feature.
class JournalDatabase {
  JournalDatabase._();
  static final JournalDatabase instance = JournalDatabase._();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('journal.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE journal_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            thoughts TEXT NOT NULL,
            feelings TEXT NOT NULL,
            accomplishments TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
    await _ensurePresetEntries(db);
    return db;
  }

  // Pre-set journal entries to populate on first launch.
  Future<void> _ensurePresetEntries(Database db) async {
    for (final entry in _presetEntries()) {
      final countResult = await db.query(
        'journal_entries',
        columns: ['COUNT(*) as count'],
        where: 'thoughts = ? AND created_at = ?',
        whereArgs: [entry.thoughts, entry.createdAt.toIso8601String()],
      );
      final count = Sqflite.firstIntValue(countResult) ?? 0;
      if (count == 0) {
        await db.insert('journal_entries', entry.toMap());
      }
    }
  }

  Future<void> ensurePresetEntries() async {
    final db = await database;
    await _ensurePresetEntries(db);
  }

  List<JournalEntry> _presetEntries() {
    return [
      JournalEntry(
        thoughts: 'Took a quiet walk and enjoyed the fresh air.',
        feelings: 'Calm',
        accomplishments: 'Completed my readings for class.',
        createdAt: DateTime.utc(2025, 11, 01, 8),
      ),
      JournalEntry(
        thoughts: 'Had a great chat with a friend over lunch.',
        feelings: 'Happy',
        accomplishments: 'Cooked a healthy meal for dinner.',
        createdAt: DateTime.utc(2025, 10, 30, 12, 30),
      ),
    ];
  }

  Future<List<JournalEntry>> getEntries() async {
    final db = await database;
    final rows = await db.query(
      'journal_entries',
      orderBy: 'datetime(created_at) DESC',
    );
    return rows.map(JournalEntry.fromMap).toList();
  }

  Future<int> insertEntry(JournalEntry entry) async {
    final db = await database;
    return db.insert('journal_entries', entry.toMap());
  }

  Future<int> updateEntry(JournalEntry entry) async {
    final db = await database;
    if (entry.id == null) {
      throw Exception('Cannot update entry without an id');
    }
    return db.update(
      'journal_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteEntry(int id) async {
    final db = await database;
    return db.delete(
      'journal_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

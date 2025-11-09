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
    return openDatabase(
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
}

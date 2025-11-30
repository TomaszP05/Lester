import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Model that represents a single mood entry.
class MoodEntry {
  final int? id;
  final String overallMood;
  final String beforeMood;
  final String afterMood;
  final DateTime createdAt;

  const MoodEntry({
    this.id,
    required this.overallMood,
    required this.beforeMood,
    required this.afterMood,
    required this.createdAt,
  });

  MoodEntry copyWith({
    int? id,
    String? overallMood,
    String? beforeMood,
    String? afterMood,
    DateTime? createdAt,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      overallMood: overallMood ?? this.overallMood,
      beforeMood: beforeMood ?? this.beforeMood,
      afterMood: afterMood ?? this.afterMood,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'overall_mood': overallMood,
      'before_mood': beforeMood,
      'after_mood': afterMood,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'] as int?,
      overallMood: map['overall_mood'] as String,
      beforeMood: map['before_mood'] as String,
      afterMood: map['after_mood'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

/// Handles all SQLite interaction for the mood tracker.
class MoodDatabase {
  MoodDatabase._();
  static final MoodDatabase instance = MoodDatabase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('moods.db');
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
          CREATE TABLE moods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            overall_mood TEXT NOT NULL,
            before_mood TEXT NOT NULL,
            after_mood TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
    return db;
  }

  Future<int> insertMood(MoodEntry entry) async {
    final db = await database;
    return db.insert('moods', entry.toMap());
  }

  Future<List<MoodEntry>> getMoods() async {
    final db = await database;
    final rows = await db.query(
      'moods',
      orderBy: 'datetime(created_at) DESC',
    );
    return rows.map(MoodEntry.fromMap).toList();
  }

  Future<void> clearMoods() async {
    final db = await database;
    await db.delete('moods');
  }
}

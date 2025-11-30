import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReflectionEntry {
  final int? id;
  final String actOfKindness;
  final double productivity;
  final String moodEmoji;
  final DateTime date;

  ReflectionEntry({
    this.id,
    required this.actOfKindness,
    required this.productivity,
    required this.moodEmoji,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'actOfKindness': actOfKindness,
    'productivity': productivity,
    'moodEmoji': moodEmoji,
    'date': date.toIso8601String(),
  };

  factory ReflectionEntry.fromMap(Map<String, dynamic> map) => ReflectionEntry(
    id: map['id'],
    actOfKindness: map['actOfKindness'],
    productivity: map['productivity'],
    moodEmoji: map['moodEmoji'],
    date: DateTime.parse(map['date']),
  );
}

class ReflectionDatabase {
  static final ReflectionDatabase instance = ReflectionDatabase._init();
  static Database? _database;
  ReflectionDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('reflections.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE reflections(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      actOfKindness TEXT,
      productivity REAL,
      moodEmoji TEXT,
      date TEXT
    )
    ''');
  }

  Future<int> insertReflection(ReflectionEntry reflection) async {
    final db = await instance.database;
    return await db.insert('reflections', reflection.toMap());
  }

  Future<List<ReflectionEntry>> getAllReflections() async {
    final db = await instance.database;
    final result = await db.query('reflections', orderBy: 'date DESC');
    return result.map((e) => ReflectionEntry.fromMap(e)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
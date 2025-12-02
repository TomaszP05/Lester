import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReflectionEntry {
  final int? id;
  final String actOfKindness;
  final double productivity;
  final String moodEmoji;
  final DateTime date;
  final String weekSentence;
  final String remember;
  final String smile;
  final String showedKindness;
  final String feltMostYourselfDay;
  final String completedTasksOption;
  final double satisfaction;
  final String newThing;
  final String insight;

  ReflectionEntry({
    this.id,
    required this.actOfKindness,
    required this.productivity,
    required this.moodEmoji,
    required this.date,
    required this.weekSentence,
    required this.remember,
    required this.smile,
    required this.showedKindness,
    required this.feltMostYourselfDay,
    required this.completedTasksOption,
    required this.satisfaction,
    required this.newThing,
    required this.insight,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'actOfKindness': actOfKindness,
    'productivity': productivity,
    'moodEmoji': moodEmoji,
    'date': date.toIso8601String(),
    'weekSentence': weekSentence,
    'remember': remember,
    'smile': smile,
    'showedKindness': showedKindness,
    'feltMostYourselfDay': feltMostYourselfDay,
    'completedTasksOption': completedTasksOption,
    'satisfaction': satisfaction,
    'newThing': newThing,
    'insight': insight,
  };

  factory ReflectionEntry.fromMap(Map<String, dynamic> map) => ReflectionEntry(
    id: map['id'],
    actOfKindness: map['actOfKindness'],
    productivity: map['productivity'],
    moodEmoji: map['moodEmoji'],
    date: DateTime.parse(map['date']),
    weekSentence: map['weekSentence'],
    remember: map['remember'],
    smile: map['smile'],
    showedKindness: map['showedKindness'],
    feltMostYourselfDay: map['feltMostYourselfDay'],
    completedTasksOption: map['completedTasksOption'],
    satisfaction: map['satisfaction'],
    newThing: map['newThing'],
    insight: map['insight'],
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
      date TEXT,
      weekSentence TEXT,
      remember TEXT,
      smile TEXT,
      showedKindness TEXT,
      feltMostYourselfDay TEXT,
      completedTasksOption TEXT,
      satisfaction REAL,
      newThing TEXT,
      insight TEXT
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
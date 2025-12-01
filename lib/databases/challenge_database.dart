import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Challenge Model
class Challenge {
  final int? id;
  final String name;
  final String description;
  final int points;
  final bool completed;
  final int dayNumber;

  Challenge({
    this.id,
    required this.name,
    required this.description,
    required this.points,
    this.completed = false,
    required this.dayNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'completed': completed ? 1 : 0,
      'dayNumber': dayNumber,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      points: map['points'],
      completed: map['completed'] == 1,
      dayNumber: map['dayNumber'],
    );
  }

  Challenge copyWith({
    int? id,
    String? name,
    String? description,
    int? points,
    bool? completed,
    int? dayNumber,
  }) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      points: points ?? this.points,
      completed: completed ?? this.completed,
      dayNumber: dayNumber ?? this.dayNumber,
    );
  }
}

// Database Helper
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('challenges.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE challenges (
        id $idType,
        name $textType,
        description $textType,
        points $intType,
        completed $intType,
        dayNumber $intType
      )
    ''');

    // Insert default weekly challenges
    await _insertDefaultChallenges(db);
  }

  Future<void> _insertDefaultChallenges(Database db) async {
    final challenges = [
      Challenge(
        name: 'daily_challenge_1_name',
        description: 'daily_challenge_1_description',
        points: 5,
        dayNumber: 1,
      ),
      Challenge(
        name: 'daily_challenge_2_name',
        description: 'daily_challenge_2_description',
        points: 5,
        dayNumber: 2,
      ),
      Challenge(
        name: 'daily_challenge_3_name',
        description: 'daily_challenge_3_description',
        points: 5,
        dayNumber: 3,
      ),
      Challenge(
        name: 'daily_challenge_4_name',
        description: 'daily_challenge_4_description',
        points: 5,
        dayNumber: 4,
      ),
      Challenge(
        name: 'daily_challenge_5_name',
        description: 'daily_challenge_5_description',
        points: 5,
        dayNumber: 5,
      ),
      Challenge(
        name: 'daily_challenge_6_name',
        description: 'daily_challenge_6_description',
        points: 5,
        dayNumber: 6,
      ),
      Challenge(
        name: 'daily_challenge_7_name',
        description: 'daily_challenge_7_description',
        points: 5,
        dayNumber: 7,
      ),
      Challenge(
        name: 'daily_challenge_8_name',
        description: 'daily_challenge_8_description',
        points: 5,
        dayNumber: 8,
      ),
      Challenge(
        name: 'daily_challenge_9_name',
        description: 'daily_challenge_9_description',
        points: 5,
        dayNumber: 9,
      ),
      Challenge(
        name: 'daily_challenge_10_name',
        description: 'daily_challenge_10_description',
        points: 10,
        dayNumber: 10,
      ),
      Challenge(
        name: 'daily_challenge_11_name',
        description: 'daily_challenge_11_description',
        points: 5,
        dayNumber: 11,
      ),
      Challenge(
        name: 'daily_challenge_12_name',
        description: 'daily_challenge_12_description',
        points: 5,
        dayNumber: 12,
      ),
      Challenge(
        name: 'daily_challenge_13_name',
        description: 'daily_challenge_13_description',
        points: 5,
        dayNumber: 13,
      ),
      Challenge(
        name: 'daily_challenge_14_name',
        description: 'daily_challenge_14_description',
        points: 5,
        dayNumber: 14,
      ),
      Challenge(
        name: 'daily_challenge_15_name',
        description: 'daily_challenge_15_description',
        points: 5,
        dayNumber: 15,
      ),
      Challenge(
        name: 'daily_challenge_16_name',
        description: 'daily_challenge_16_description',
        points: 10,
        dayNumber: 16,
      ),
      Challenge(
        name: 'daily_challenge_17_name',
        description: 'daily_challenge_17_description',
        points: 5,
        dayNumber: 17,
      ),
      Challenge(
        name: 'daily_challenge_18_name',
        description: 'daily_challenge_18_description',
        points: 5,
        dayNumber: 18,
      ),
      Challenge(
        name: 'daily_challenge_19_name',
        description: 'daily_challenge_19_description',
        points: 10,
        dayNumber: 19,
      ),
      Challenge(
        name: 'daily_challenge_20_name',
        description: 'daily_challenge_20_description',
        points: 5,
        dayNumber: 20,
      ),
      Challenge(
        name: 'daily_challenge_21_name',
        description: 'daily_challenge_21_description',
        points: 10,
        dayNumber: 21,
      ),
      Challenge(
        name: 'daily_challenge_22_name',
        description: 'daily_challenge_22_description',
        points: 10,
        dayNumber: 22,
      ),
      Challenge(
        name: 'daily_challenge_23_name',
        description: 'daily_challenge_23_description',
        points: 10,
        dayNumber: 23,
      ),
      Challenge(
        name: 'daily_challenge_24_name',
        description: 'daily_challenge_24_description',
        points: 5,
        dayNumber: 24,
      ),
      Challenge(
        name: 'daily_challenge_25_name',
        description: 'daily_challenge_25_description',
        points: 5,
        dayNumber: 25,
      ),
      Challenge(
        name: 'daily_challenge_26_name',
        description: 'daily_challenge_26_description',
        points: 5,
        dayNumber: 26,
      ),
      Challenge(
        name: 'daily_challenge_27_name',
        description: 'daily_challenge_27_description',
        points: 5,
        dayNumber: 27,
      ),
      Challenge(
        name: 'daily_challenge_28_name',
        description: 'daily_challenge_28_description',
        points: 5,
        dayNumber: 28,
      ),
      Challenge(
        name: 'daily_challenge_29_name',
        description: 'daily_challenge_29_description',
        points: 10,
        dayNumber: 29,
      ),
      Challenge(
        name: 'daily_challenge_30_name',
        description: 'daily_challenge_30_description',
        points: 5,
        dayNumber: 30,
      ),
      Challenge(
        name: 'daily_challenge_31_name',
        description: 'daily_challenge_31_description',
        points: 10,
        dayNumber: 31,
      ),
    ];

    for (var challenge in challenges) {
      await db.insert('challenges', challenge.toMap());
    }
  }


  Future<Challenge> create(Challenge challenge) async {
    final db = await instance.database;
    final id = await db.insert('challenges', challenge.toMap());
    return challenge.copyWith(id: id);
  }

  Future<Challenge?> readChallenge(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'challenges',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Challenge.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Challenge>> readAllChallenges() async {
    final db = await instance.database;
    const orderBy = 'dayNumber DESC';
    final result = await db.query('challenges', orderBy: orderBy);
    return result.map((map) => Challenge.fromMap(map)).toList();
  }

  Future<int> update(Challenge challenge) async {
    final db = await instance.database;
    return db.update(
      'challenges',
      challenge.toMap(),
      where: 'id = ?',
      whereArgs: [challenge.id],
    );
  }

  Future<int> toggleCompletion(int id, bool completed) async {
    final db = await instance.database;
    return db.update(
      'challenges',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'challenges',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> resetAllChallenges() async {
    final db = await instance.database;
    await db.update(
      'challenges',
      {'completed': 0},
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
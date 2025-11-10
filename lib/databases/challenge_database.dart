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
        name: 'Daily Challenge 1',
        description: 'Smile at five people today',
        points: 5,
        dayNumber: 1,
      ),
      Challenge(
        name: 'Daily Challenge 2',
        description: 'Send a positive message to someone you care about',
        points: 5,
        dayNumber: 2,
      ),
      Challenge(
        name: 'Daily Challenge 3',
        description: 'Take a short walk outside and appreciate nature',
        points: 5,
        dayNumber: 3,
      ),
      Challenge(
        name: 'Daily Challenge 4',
        description: 'Do one household task you’ve been putting off',
        points: 5,
        dayNumber: 4,
      ),
      Challenge(
        name: 'Daily Challenge 5',
        description: 'Compliment someone sincerely',
        points: 5,
        dayNumber: 5,
      ),
      Challenge(
        name: 'Daily Challenge 6',
        description: 'Drink at least 8 glasses of water today',
        points: 5,
        dayNumber: 6,
      ),
      Challenge(
        name: 'Daily Challenge 7',
        description: 'Write a thank you note to a friend',
        points: 5,
        dayNumber: 7,
      ),
      Challenge(
        name: 'Daily Challenge 8',
        description: 'Hold the door open for someone',
        points: 5,
        dayNumber: 8,
      ),
      Challenge(
        name: 'Daily Challenge 9',
        description: 'Compliment a stranger',
        points: 5,
        dayNumber: 9,
      ),
      Challenge(
        name: 'Daily Challenge 10',
        description: 'Take a picture of a flower and upload a picture!',
        points: 10,
        dayNumber: 10,
      ),
      Challenge(
        name: 'Daily Challenge 11',
        description: 'Listen to your favorite song and do nothing else',
        points: 5,
        dayNumber: 11,
      ),
      Challenge(
        name: 'Daily Challenge 12',
        description: 'Try a new food or drink you’ve never had before',
        points: 5,
        dayNumber: 12,
      ),
      Challenge(
        name: 'Daily Challenge 13',
        description: 'Send a kind text to a family member',
        points: 5,
        dayNumber: 13,
      ),
      Challenge(
        name: 'Daily Challenge 14',
        description: 'Pick up a piece of litter you find outside',
        points: 5,
        dayNumber: 14,
      ),
      Challenge(
        name: 'Daily Challenge 15',
        description: 'Spend 10 minutes stretching or meditating',
        points: 5,
        dayNumber: 15,
      ),
      Challenge(
        name: 'Daily Challenge 16',
        description: 'Donate an item you no longer use',
        points: 10,
        dayNumber: 16,
      ),
      Challenge(
        name: 'Daily Challenge 17',
        description: 'Give someone a genuine compliment',
        points: 5,
        dayNumber: 17,
      ),
      Challenge(
        name: 'Daily Challenge 18',
        description: 'Write down three things you’re grateful for',
        points: 5,
        dayNumber: 18,
      ),
      Challenge(
        name: 'Daily Challenge 19',
        description: 'Call or video chat with a loved one',
        points: 10,
        dayNumber: 19,
      ),
      Challenge(
        name: 'Daily Challenge 20',
        description: 'Share an inspiring quote on social media',
        points: 5,
        dayNumber: 20,
      ),
      Challenge(
        name: 'Daily Challenge 21',
        description: 'Take a photo of something that makes you happy',
        points: 10,
        dayNumber: 21,
      ),
      Challenge(
        name: 'Daily Challenge 22',
        description: 'Spend one hour without your phone or computer',
        points: 10,
        dayNumber: 22,
      ),
      Challenge(
        name: 'Daily Challenge 23',
        description: 'Help someone without expecting anything in return',
        points: 10,
        dayNumber: 23,
      ),
      Challenge(
        name: 'Daily Challenge 24',
        description: 'Cook or prepare a healthy meal',
        points: 5,
        dayNumber: 24,
      ),
      Challenge(
        name: 'Daily Challenge 25',
        description: 'Leave a positive review for a small business',
        points: 5,
        dayNumber: 25,
      ),
      Challenge(
        name: 'Daily Challenge 26',
        description: 'Spend 15 minutes journaling or reflecting',
        points: 5,
        dayNumber: 26,
      ),
      Challenge(
        name: 'Daily Challenge 27',
        description: 'Say “thank you” to someone who helps you today',
        points: 5,
        dayNumber: 27,
      ),
      Challenge(
        name: 'Daily Challenge 28',
        description: 'Read or listen to something uplifting',
        points: 5,
        dayNumber: 28,
      ),
      Challenge(
        name: 'Daily Challenge 29',
        description: 'Do a random act of kindness anonymously',
        points: 10,
        dayNumber: 29,
      ),
      Challenge(
        name: 'Daily Challenge 30',
        description: 'Spend 10 minutes organizing your space',
        points: 5,
        dayNumber: 30,
      ),
      Challenge(
        name: 'Daily Challenge 31',
        description: 'Reflect on the month — what are you proud of?',
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
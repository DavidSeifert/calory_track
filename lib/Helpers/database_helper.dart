import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

class Databasehelper {
  static Database? _database;

  static final Databasehelper instance = Databasehelper._constructor();
  // Table and column names
  final String tableName = 'Calories';
  final String _colId = 'id';
  final String _colCalories = 'calories';
  final String _colDate = 'date';
  final String _colTime = 'time';
  final String _colWeek = 'week';

  Databasehelper._constructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    return _database!;
  }

  Future<Database> getDatabase() async {
    final databaseDirpath = await getDatabasesPath();
    final path = join(databaseDirpath, 'calory.db');

    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableName (
            $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_colCalories INTEGER NOT NULL,
            $_colDate TEXT NOT NULL,
            $_colTime TEXT NOT NULL,
            $_colWeek INTEGER NOT NULL
          )
        ''');
      },
      version: 1,
    );
    return database;
  }




  void addEntry(int calories) async {
    final db = await database;
    await db.insert(tableName, {
      _colCalories: calories,
      _colDate: DateFormat("dd.MM.yyyy").format(DateTime.now()),
      _colTime: DateFormat("HH:mm").format(DateTime.now()),
      _colWeek: DateTime.now().weekOfYear,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> showValues() async {
    final db = await database;
    return db.query(tableName, orderBy: '$_colDate ASC');
  }

  Future<int> getCaloriesForToday(DateTime time) async {
    final db = await instance.database;

    final date = DateFormat("dd.MM.yyyy").format(time);

    var result = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );
    int dailycalories = 0;
    for (int i = 0; i < result.length; i++) {
      dailycalories += result[i]['calories'] as int? ?? 0;
    }
    if (result.isNotEmpty) {
      // Return calories, safely handle null
      return dailycalories;
    }

    // Handle case where no data is found for today
    return 0; // no calories logged for today
  }

  Future<List<Map<String, dynamic>>> getEntriesForDay(DateTime time) async {
    final db = await instance.database;

    final date = DateFormat("dd.MM.yyyy").format(time);

    var result = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> getEntriesForWeek(int week) async {
    final db = await instance.database;

    var result = await db.query(
      tableName,
      where: 'week = ?',
      whereArgs: [week],
    );

    return result;
  }
}

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE pokemon (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      frontImage TEXT,
      backImage TEXT
    )''');
  }

  // Método para obtener el conteo de Pokémon como un Stream
  Stream<int> getPokemonCountStream() async* {
    final db = await database;
    while (true) {
      await Future.delayed(Duration(seconds: 1)); // Espera entre cada emisión
      final count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM pokemon'));
      yield count ?? 0;
    }
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<int> insertWithConflictResolution(
      String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> values,
      String whereClause, List<Object> whereArgs) async {
    final db = await database;
    return await db.update(table, values,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(
      String table, String whereClause, List<Object> whereArgs) async {
    final db = await database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }
}

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  static DatabaseHelper get instance =>
      _databaseHelper ??= DatabaseHelper._internal();

  Database? _db;
  Database get db => _db!;

  Future<void> init() async {
    _db =
        await openDatabase('database.db', version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE players(id INTEGER PRIMARY KEY, name TEXT, performance REAL, position TEXT, goals INTEGER NOT NULL, status TEXT, team_id INTEGER, FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE SET NULL )');
      db.execute(
          'CREATE TABLE teams(id INTEGER PRIMARY KEY,name TEXT, teamPlayers TEXT NOT NULL, points REAL, teamGoals INTEGER)');
      db.execute(
          'CREATE TABLE match(id INTEGER PRIMARY KEY, teams TEXT NOT NULL, date TEXT, status TEXT)');
    });
  }
}

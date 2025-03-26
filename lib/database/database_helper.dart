import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../player_model.dart';

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
          'CREATE TABLE players(id INTEGER PRIMARY KEY, name TEXT, performance REAL, position TEXT)');
      db.execute(
          'CREATE TABLE teams(id INTEGER PRIMARY KEY,name TEXT, teamPlayers TEXT NOT NULL, points REAL)');
    });
  }
}

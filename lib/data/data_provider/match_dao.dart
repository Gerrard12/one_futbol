import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/domain/entities/match_model.dart';

class MatchDao {
  final database = DatabaseHelper.instance.db;

  Future<List<MatchModel>> readAllMatches() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('match');
    return maps.map((map) => MatchModel.fromJson(map)).toList();
  }

  Future<int> insertmatch(MatchModel match) async {
    return await database.insert('match', match.toJson());
  }

  Future<void> deletematch(MatchModel match) async {
    await database.delete('match', where: 'id = ?', whereArgs: [match.id]);
  }

  Future<void> updatematch(MatchModel match) async {
    await database.update('match', match.toJson(),
        where: 'id = ?', whereArgs: [match.id]);
  }

  Future<void> deleteAll() async {
    await database.delete('match', where: null, whereArgs: null);
  }
}

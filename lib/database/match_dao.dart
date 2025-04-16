import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/models/match_model.dart';

class MatchDao {
  final database = DatabaseHelper.instance.db;

  Future<List<Match>> readAllMatches() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('match');
    return maps.map((map) => Match.fromJson(map)).toList();
  }

  Future<int> insertmatch(Match match) async {
    return await database.insert('match', match.toJson());
  }

  Future<void> deletematch(Match match) async {
    await database.delete('match', where: 'id = ?', whereArgs: [match.id]);
  }

  Future<void> updatematch(Match match) async {
    await database.update('match', match.toJson(),
        where: 'id = ?', whereArgs: [match.id]);
  }
}

import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/models/player_model.dart';

class PlayerDao {
  final database = DatabaseHelper.instance.db;

  Future<List<Player>> readAll() async {
    final data = await database.query('players');
    return data.map((e) => Player.fromJson(e)).toList();
  }

  Future<int> insert(Player player) async {
    return await database.insert('players', {
      'name': player.name,
      'performance': player.performance,
      'position': player.position,
      'goals': player.goals
    });
  }

  Future<void> update(Player player) async {
    await database.update('players', player.toJson(),
        where: 'id = ?', whereArgs: [player.id]);
  }

  Future<void> delete(Player player) async {
    await database.delete('players', where: 'id = ?', whereArgs: [player.id]);
  }

  Future<void> updatePlayerTeam(Player player, int teamId) async {
    await database.update('players', {'team_id': teamId},
        where: 'id = ?', whereArgs: [player.id]);
  }
}

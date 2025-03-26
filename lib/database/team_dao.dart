
import 'package:one_futbol/database/database_helper.dart';
import 'package:one_futbol/team_model.dart';

class TeamDao {
  final database = DatabaseHelper.instance.db;

  Future<List<Team>> readAllTeam() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('teams');
    return maps.map((map) => Team.fromJson(map)).toList();
  }

  Future<int> insertTeam(Team team) async {
    return await database.insert('teams', team.toJson());
  }

  Future<void> updateTeam(Team team, String name) async {
    await database.update('teams', {'name': name},
        where: 'id = ?', whereArgs: [team.id]);
  }

  Future<void> updateTeamPoints(Team team, double points) async {
    await database.update('teams', {'points': points},
        where: 'id = ?', whereArgs: [team.id]);
  }

  Future<void> deleteTeam(Team team) async {
    await database.delete('teams', where: 'id = ?', whereArgs: [team.id]);
  }
}

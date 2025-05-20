import 'package:one_futbol/data/data_provider/team_dao.dart';
import 'package:one_futbol/domain/entities/team_model.dart';

class TeamRepository {
  final dao = TeamDao();

  Future<List<Team>> getAllTeams() async {
    final List<Team> datasetTeam = await dao.readAllTeam();
    return datasetTeam;
  }

  Future<void> deleteTeam(Team team) async {
    await dao.deleteTeam(team);
  }

  Future<void> addTeam(Team team) async {
    await dao.insertTeam(team);
  }

  Future<void> updateTeam(Team team) async {
    await dao.updateTeam(team);
  }
}

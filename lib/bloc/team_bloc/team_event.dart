import 'package:one_futbol/domain/domain.dart';

abstract class TeamEvent {}

class LoadTeam extends TeamEvent {}

class AddTeam extends TeamEvent {
  final Team team;
  AddTeam(this.team);
}

class UpdateTeam extends TeamEvent {
  final Team team;
  UpdateTeam(this.team);
}

class DeleteTeam extends TeamEvent {
  final Team team;
  DeleteTeam(this.team);
}

class GenerateTeamEvent extends TeamEvent {
  final List<Player> selectedPlayers;
  final int count;
  final int playerLength;
  final String type;
  GenerateTeamEvent(
      this.selectedPlayers, this.count, this.playerLength, this.type);
}

class SaveTeam extends TeamEvent {
  final List<Player> teams;
  SaveTeam(this.teams);
}

import 'package:one_futbol/domain/domain.dart';

class GenerateTeams {
  List<Team> call(
      List<Player> selectedPlayers, int count, int playerLength, String type) {
    List<Player> sortedPlayers = List.from(selectedPlayers)
      ..sort(
        (a, b) => b.performance.compareTo(a.performance),
      );

    List<List<Player>> auxTeams = List.generate(
      count,
      (_) => [],
    );
    List<Team> teams = [];
    int start = 0;
    int end = sortedPlayers.length - 1;
    int teamIndex = 0;

    if (type == 'balanceado') {
      while (start <= end &&
          auxTeams.any(
            (element) => element.length < playerLength,
          )) {
        if (start != end && auxTeams[teamIndex].length + 2 <= playerLength) {
          auxTeams[teamIndex]
              .addAll([sortedPlayers[start], sortedPlayers[end]]);
          start++;
          end--;
        } else if (auxTeams[teamIndex].length < playerLength) {
          auxTeams[teamIndex].add(sortedPlayers[start]);
          start++;
        }
        teamIndex = (teamIndex + 1) % count;
      }
    } else {
      sortedPlayers.shuffle();
      while (start <= end &&
          auxTeams.any(
            (element) => element.length < playerLength,
          )) {
        if (auxTeams[teamIndex].length < playerLength) {
          auxTeams[teamIndex].add(sortedPlayers[start]);
          start++;
        }
        teamIndex = (teamIndex + 1) % count;
      }
    }
    for (int i = 0; i < auxTeams.length; i++) {
      bool arquero = auxTeams[i].any(
        (element) => element.position.toLowerCase() == 'arquero',
      );
      if (!arquero && auxTeams[i].isNotEmpty) {
        auxTeams[i][0].position = 'Arquero';
      }
    }
    for (int i = 0; i < auxTeams.length; i++) {
      List<Player> list = auxTeams[i];

      selectedPlayers = auxTeams[i];

      for (Player player in list) {
        player.team_id = i + 1;
      }
      Team team = Team(
          name: 'Equipo ${i + 1}',
          teamPlayers: selectedPlayers,
          points: 0,
          teamGoals: 0);

      teams.add(team);
    }

    return teams;
  }
}

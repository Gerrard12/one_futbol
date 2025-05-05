import 'package:one_futbol/domain/domain.dart';

class GenerateMatches {
  List<MatchModel> call(List<Team> teams) {
    List<Team> selectedTeams = [];
    List<MatchModel> matches = [];
    int count = (teams.length / 2).toInt();
    List<List<Team>> auxMatches = List.generate(count, (index) => []);
    teams.shuffle();
    for (int i = 0; i < teams.length; i++) {
      auxMatches[i % count].add(teams[i]);
    }
    for (int i = 0; i < auxMatches.length; i++) {
      selectedTeams = auxMatches[i];

      MatchModel match = MatchModel(teams: selectedTeams);
      matches.add(match);
    }
    return matches;
  }
}

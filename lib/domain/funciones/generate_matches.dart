import 'dart:developer';

import 'package:one_futbol/domain/domain.dart';

class GenerateMatches {
  List<MatchModel> call(List<Team> teams) {
    List<Team> selectedTeams = [];
    List<MatchModel> matches = [];
    int count = (teams.length / 2).toInt();
    List<List<Team>> auxMatches = List.generate(count, (_) => []);
    teams.shuffle();
    int countPar = count * count;

    if ((count % 2).isEven) {
      for (int i = 0; i < countPar; i++) {
        auxMatches[i % count].add(teams[i % teams.length]);
      }
    } else {
      for (int i = 0; i < count + 1; i++) {
        auxMatches[i % count].add(teams[i]);
      }
    }
    for (int i = 0; i < auxMatches.length; i++) {
      selectedTeams = auxMatches[i % count];
      selectedTeams[i].teamGoals = 0;

      MatchModel match = MatchModel(teams: selectedTeams, status: 'Por jugar');
      matches.add(match);
    }
    return matches;
  }
}

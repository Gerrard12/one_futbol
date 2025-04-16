import 'dart:convert';

import 'package:one_futbol/models/team_model.dart';

class Match {
  Match({
    this.id,
    this.date,
    required this.teams,
  });

  late int? id;
  late List<Team> teams;
  late DateTime? date;

  Match copyWith({int? id, DateTime? date, List<Team>? teams}) {
    return Match(
      id: id ?? this.id,
      teams: teams ?? this.teams,
      date: date ?? this.date,
    );
  }

  factory Match.fromJson(Map<String, dynamic> map) {
    return Match(
      id: map['id'],
      date: map['date'],
      teams: (jsonDecode(map['teams']) as List)
          .map((teamMap) => Team.fromJson(teamMap))
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'date': date,
      'teams': jsonEncode(teams.map((team) => team.toJson()).toList()),
    };
  }
}

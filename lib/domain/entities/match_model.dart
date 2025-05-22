import 'dart:convert';

import 'package:one_futbol/domain/entities/team_model.dart';

class MatchModel {
  MatchModel({
    this.id,
    this.date,
    required this.teams,
    required this.status,
  });

  late int? id;
  late DateTime? date;
  late List<Team> teams;
  late String status;

  MatchModel copyWith(
      {int? id, DateTime? date, List<Team>? teams, String? status}) {
    return MatchModel(
      id: id ?? this.id,
      date: date ?? this.date,
      teams: teams ?? this.teams,
      status: status ?? this.status,
    );
  }

  factory MatchModel.fromJson(Map<String, dynamic> map) {
    return MatchModel(
        id: map['id'],
        date: map['date'],
        teams: (jsonDecode(map['teams']) as List)
            .map((teamMap) => Team.fromJson(teamMap))
            .toList(),
        status: map['status']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'date': date,
      'teams': jsonEncode(teams.map((team) => team.toJson()).toList()),
      'status': status,
    };
  }
}
